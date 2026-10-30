import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
NVIM = shutil.which('nvim')


class NeovimSourceTests(unittest.TestCase):
    def test_palette_values_are_present(self):
        palette = json.loads((ROOT / 'palette.json').read_text())
        source = (ROOT / 'colors/penamiller.lua').read_text()
        colors = [palette['background'], palette['foreground'], *palette['ansi'],
                  *palette['extras'].values()]
        for color in colors:
            with self.subTest(color=color):
                self.assertIn(color, source)

    def test_old_catppuccin_overrides_removed(self):
        self.assertFalse((ROOT / 'ports/nvim/penamiller.lua').exists())
        source = (ROOT / 'colors/penamiller.lua').read_text()
        self.assertNotIn('color_overrides', source)
        self.assertNotIn('catppuccin', source.lower())


@unittest.skipUnless(NVIM, 'Neovim 0.10+ is required for runtime tests')
class NeovimRuntimeTests(unittest.TestCase):
    def run_theme(self, standalone):
        with tempfile.TemporaryDirectory(prefix='penamiller-test-') as directory:
            temp = Path(directory)
            runtime = ROOT
            if standalone:
                runtime = temp / 'runtime'
                (runtime / 'colors').mkdir(parents=True)
                shutil.copy2(ROOT / 'colors/penamiller.lua', runtime / 'colors/penamiller.lua')
            env = dict(os.environ)
            for key in ('XDG_CONFIG_HOME', 'XDG_DATA_HOME', 'XDG_STATE_HOME', 'XDG_CACHE_HOME'):
                env[key] = str(temp / key.lower())
            env['PENAMILLER_RUNTIME'] = str(runtime)
            env['PENAMILLER_PALETTE'] = str(ROOT / 'palette.json')
            env['PENAMILLER_TEST'] = str(ROOT / 'tests/test_neovim.lua')
            result = subprocess.run(
                [NVIM, '--headless', '-u', 'NONE', '-i', 'NONE', '-n',
                 '-c', 'lua dofile(vim.env.PENAMILLER_TEST)'],
                env=env, capture_output=True, text=True, timeout=30,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('all checks passed', result.stdout + result.stderr)

    def test_repository_as_plugin(self):
        self.run_theme(standalone=False)

    def test_single_file_install(self):
        self.run_theme(standalone=True)
