# Penamiller

![Penamiller: dark color scheme and light-mode concept](assets/penamiller-light-dark.png)

> AI-generated concept preview. **Dark** reflects the current palette's visual
> identity; **Light Concept** is a design proposal, not an installable variant.
> All included ports are still dark. For exact colors, refer to `palette.json`
> rather than the illustration's pixels.

A dark color palette created by **parraletz**, independent of personal dotfiles.
Repository: [parraletz/penamiller](https://github.com/parraletz/penamiller).

- Background: `#141413`; foreground: `#FAF9F5`; orange accent: `#D97757`.
- [`palette.json`](palette.json): the central palette, with 16 ANSI colors and eight accents.
- [`palette.schema.json`](palette.schema.json): JSON Schema 2020-12; the palette's
  relative reference allows validation without contacting a server.
- [`colors/penamiller.lua`](colors/penamiller.lua): standalone Neovim colorscheme.
- [`ports/`](ports/): themes and color configuration snippets, without personal settings.
- [`SOURCE.md`](SOURCE.md): provenance, extraction changes, and existing license declarations.

Ports are static files: changing the palette **does not regenerate them**.
Nothing is installed or activated automatically. Back up your files and merge
the snippets into your configuration rather than replacing entire config files.

## Inspiration

Penamiller is inspired by the sunset colors along the road from **Peñamiller
to Pinal de Amoles, Querétaro, Mexico**. Its warm accents and dark background
bring that evening atmosphere into terminals and editors.

For a look at the region behind the palette, explore the
[official Querétaro tourism guide to Pinal de Amoles](https://queretaro.travel/lugares/conoce-pinal-de-amoles/)
(in Spanish), which describes the changing landscape from Peñamiller's
semi-desert mountains to the forests of the Sierra Gorda.

## Installation by application

The paths below assume `~/.config`; adjust them if you use `XDG_CONFIG_HOME`.

| Application | Resource | Installation / activation |
| --- | --- | --- |
| Ghostty | `ports/ghostty/Penamiller` | Copy to `~/.config/ghostty/themes/Penamiller`; add `theme = Penamiller` to your configuration. |
| WezTerm | `ports/wezterm/penamiller.lua` | Copy next to `wezterm.lua`; use `config.colors = require("penamiller")` instead of the previous color scheme. |
| bat | `ports/bat/penamiller.tmTheme` | Copy to `$(bat --config-dir)/themes/`; run `bat cache --build` and select `--theme=penamiller`. |
| btop | `ports/btop/penamiller.theme` | Copy to `~/.config/btop/themes/`; select `penamiller` in Options → Color theme, or set `color_theme = "penamiller"` in `btop.conf` while btop is closed. |
| iTerm2 | `ports/iterm2/Penamiller.itermcolors` | Import through Settings → Profiles → Colors → Color Presets → Import. |
| Zed | `ports/zed/penamiller.json` | Copy to `~/.config/zed/themes/`; select `Penamiller`. |
| OpenCode | `ports/opencode/penamiller.json` | Copy to `~/.config/opencode/themes/`; select `penamiller` in your TUI's `theme` setting. |
| Omarchy | `ports/omarchy/penamiller/` | Copy the directory to `~/.config/omarchy/themes/penamiller`; run `omarchy theme set penamiller`. The port includes Gruvbox Material wallpapers. |
| Zellij | `ports/zellij/penamiller.kdl` | Copy to `~/.config/zellij/themes/`; set `theme "penamiller"` in `config.kdl`. |
| Herdr | `ports/herdr/penamiller.toml` | Merge `[theme]` and `[theme.custom]` into `~/.config/herdr/config.toml` without duplicating tables. |
| fzf | `ports/fzf/penamiller.sh` | Load with `source /path/to/penamiller/ports/fzf/penamiller.sh` in your shell; existing fzf options are preserved. |
| Neovim | `colors/penamiller.lua` | Install this repository as a plugin or copy the file to your `colors/` directory; select `penamiller`. See below. |
| Konsole | `ports/konsole/` | Copy the color scheme to `~/.local/share/konsole/`; select it in your profile's appearance settings. The included profile is optional. |
| KDE / Plasma | `ports/kde/` | Copy `color-schemes/` and the packages in `plasma/` to the corresponding paths under `~/.local/share/`; select them in System Settings. |
| GTK 3 / 4 | `ports/gtk-3.0/penamiller.css`, `ports/gtk-4.0/penamiller.css` | Copy each file to its respective `~/.config/gtk-3.0/` or `gtk-4.0/` directory; add `@import url("penamiller.css");` at the beginning of each `gtk.css`, preserving the remaining content. |

### Neovim

**A standalone dark colorscheme for Neovim 0.10+, with no Catppuccin dependency.**
It provides its own editor UI, Vim syntax, Tree-sitter captures, LSP semantic
tokens, diagnostics, diffs, and 16 terminal colors. It also defines highlight
groups for common plugins: blink.cmp, nvim-cmp, Gitsigns, which-key, Noice,
nvim-notify, Snacks, fzf-lua, Mason, and Telescope. These plugins are optional;
Penamiller does not install or load them. This is a new implementation, not an
exact reproduction of every Catppuccin integration.

#### lazy.nvim

Add this plugin specification:

```lua
{
  "parraletz/penamiller",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("penamiller")
  end,
}
```

No `setup()` call, `opts`, or `require("penamiller")` is needed.

#### LazyVim

Add the following to `~/.config/nvim/lua/plugins/colorscheme.lua` (merge it with
any unrelated plugin settings you already have):

```lua
return {
  { "parraletz/penamiller", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "penamiller" },
  },
}
```

#### Manual installation

Copy only `colors/penamiller.lua` to `~/.config/nvim/colors/penamiller.lua`
(create the `colors/` directory if needed), then add this to `init.lua`:

```lua
vim.cmd.colorscheme("penamiller")
```

The file is self-contained and enables true color. It currently supports only
dark mode; the README's light preview remains a concept.

#### Migrating from the previous Catppuccin-based port

Remove the old Penamiller-specific Catppuccin overrides and any
`require("penamiller")` calls that loaded `lua/penamiller.lua`. That old file
can be removed after migrating; the native file belongs in **`colors/`**, not
`lua/`. Replace `catppuccin-mocha` with `penamiller` in your colorscheme setting.
You may keep Catppuccin installed for other themes, but Penamiller does not use
it. Your plugin configurations are not modified automatically.

### KDE and GTK

The Plasma style requires Breeze as a fallback. The GTK overrides were designed
on top of Breeze and may not cover applications that enforce their own styling.
The `com.parraletz.penamiller` Global Theme only applies the color scheme,
Plasma style, and Breeze widget style: it does not change your layout, icons,
cursor, desktop count, or effects. The original preview also shows personal
desktop preferences from the source setup, which are not included.

## Validation

Using Python 3.11 or later (and Neovim 0.10+ for the runtime tests):

```sh
python3 -m venv .venv
.venv/bin/pip install -r requirements-dev.txt
.venv/bin/python -m unittest discover -s tests -v
```

The tests check the schema, invalid inputs, JSON/plist/TOML formats,
Ghostty ANSI palette consistency, btop theme syntax and palette consistency,
and the Global Theme's visual-only settings.
Neovim tests also load the theme without user configuration or third-party
plugins, check UI/syntax/diagnostic/integration groups and palette consistency,
and exercise reloads and single-file installation. Runtime tests are skipped
if `nvim` is not installed. They do not replace visual testing within each
application.
