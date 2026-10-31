from copy import deepcopy
import configparser
import json
from pathlib import Path
import plistlib
import re
import tomllib
import unittest

from jsonschema import Draft202012Validator

ROOT = Path(__file__).resolve().parents[1]


class PaletteTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.palette = json.loads((ROOT / 'palette.json').read_text())
        schema = json.loads((ROOT / 'palette.schema.json').read_text())
        Draft202012Validator.check_schema(schema)
        cls.validator = Draft202012Validator(schema)

    def test_palette(self):
        self.validator.validate(self.palette)
        self.assertEqual(
            (ROOT / self.palette['$schema']).resolve(), ROOT / 'palette.schema.json'
        )

    def test_invalid_palettes(self):
        mutations = [
            lambda p: p.update(background='141413'),
            lambda p: p['ansi'].pop(),
            lambda p: p['ansi'].append('#000000'),
            lambda p: p['extras'].pop('orange'),
            lambda p: p['extras'].update(unknown='#000000'),
            lambda p: p.update(unknown=True),
        ]
        for mutation in mutations:
            with self.subTest(mutation=mutation):
                palette = deepcopy(self.palette)
                mutation(palette)
                self.assertFalse(self.validator.is_valid(palette))

    def test_json_assets(self):
        for path in ROOT.rglob('*.json'):
            if '.venv' in path.parts:
                continue
            with self.subTest(path=path):
                json.loads(path.read_text())

    def test_plist_assets(self):
        for pattern in ('*.tmTheme', '*.itermcolors'):
            for path in (ROOT / 'ports').rglob(pattern):
                with self.subTest(path=path), path.open('rb') as stream:
                    self.assertIsInstance(plistlib.load(stream), dict)

    def test_herdr_theme_only(self):
        theme = tomllib.loads((ROOT / 'ports/herdr/penamiller.toml').read_text())
        self.assertEqual(set(theme), {'theme'})
        self.assertEqual(theme['theme']['custom']['panel_bg'], self.palette['background'])

    def test_ghostty_palette(self):
        text = (ROOT / 'ports/ghostty/Penamiller').read_text()
        ansi = [line.split('=', 2)[2] for line in text.splitlines()
                if line.startswith('palette = ')]
        self.assertEqual(ansi, self.palette['ansi'])
        self.assertIn('background = ' + self.palette['background'], text)
        self.assertIn('foreground = ' + self.palette['foreground'], text)
        self.assertNotIn('macos-titlebar-style', text)

    def test_global_theme_has_no_personal_defaults(self):
        path = ROOT / 'ports/kde/plasma/look-and-feel/com.parraletz.penamiller/contents/defaults'
        config = configparser.ConfigParser()
        config.read(path)
        self.assertEqual(set(config.sections()), {
            'kdeglobals][General', 'kdeglobals][KDE', 'plasmarc][Theme',
        })
        self.assertEqual(set(config['kdeglobals][General']), {'accentcolor', 'colorscheme'})
        self.assertEqual(set(config['kdeglobals][KDE']), {'widgetstyle'})
        self.assertEqual(set(config['plasmarc][Theme']), {'name'})

    def test_btop_theme(self):
        text = (ROOT / 'ports/btop/penamiller.theme').read_text()
        colors = {}
        palette_colors = {
            self.palette['background'], self.palette['foreground'],
            *self.palette['ansi'], *self.palette['extras'].values(),
        }
        for number, line in enumerate(text.splitlines(), 1):
            if not line.strip() or line.startswith('#'):
                continue
            with self.subTest(line=number):
                match = re.fullmatch(r'theme\[([a-z_]+)\]="(#[0-9A-F]{6})"', line)
                self.assertIsNotNone(match, line)
                key, value = match.groups()
                self.assertNotIn(key, colors, 'Duplicate theme key')
                self.assertIn(value, palette_colors)
                colors[key] = value

        expected = {
            'main_bg', 'main_fg', 'title', 'hi_fg', 'selected_bg', 'selected_fg',
            'inactive_fg', 'graph_text', 'meter_bg', 'proc_misc', 'cpu_box',
            'mem_box', 'net_box', 'proc_box', 'div_line', 'proc_pause_bg',
            'proc_follow_bg', 'proc_banner_bg', 'proc_banner_fg', 'followed_bg',
            'followed_fg',
        }
        for graph in ('temp', 'cpu', 'free', 'cached', 'available', 'used',
                      'download', 'upload', 'process'):
            expected.update(f'{graph}_{stop}' for stop in ('start', 'mid', 'end'))
        self.assertEqual(set(colors), expected)
        self.assertEqual(colors['main_bg'], self.palette['background'])
        self.assertEqual(colors['main_fg'], self.palette['foreground'])
        self.assertEqual(colors['hi_fg'], self.palette['extras']['orange'])
        self.assertEqual(colors['selected_bg'], self.palette['extras']['orange'])
        self.assertEqual(colors['selected_fg'], self.palette['background'])


if __name__ == '__main__':
    unittest.main()
