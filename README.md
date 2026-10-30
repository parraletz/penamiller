# Penamiller

![Penamiller: esquema oscuro y propuesta visual del modo claro](assets/penamiller-light-dark.png)

> Vista conceptual generada con IA. **Dark** representa la identidad de la paleta
> actual; **Light Concept** es una propuesta visual, no una variante instalable.
> Los ports incluidos siguen siendo oscuros. Para colores exactos consulta
> `palette.json`, no los píxeles de la ilustración.

Paleta oscura creada por **aparra**, independiente de sus dotfiles personales.
Repositorio: [parraletz/penamiller](https://github.com/parraletz/penamiller).

- Fondo: `#141413`; texto: `#FAF9F5`; acento naranja: `#D97757`.
- [`palette.json`](palette.json): paleta central, 16 colores ANSI y ocho acentos.
- [`palette.schema.json`](palette.schema.json): JSON Schema 2020-12; la referencia
  relativa de la paleta permite validarla sin consultar un servidor.
- [`ports/`](ports/): temas y fragmentos de color, sin configuraciones personales.
- [`SOURCE.md`](SOURCE.md): procedencia, ajustes de la extracción y licencias existentes.

Los ports son archivos estáticos: cambiar la paleta **no los regenera**.
No se instala ni activa nada automáticamente. Respalda tus archivos y combina
los fragmentos con tu configuración; no reemplaces configuraciones completas.

## Instalación por aplicación

Las rutas siguientes asumen `~/.config`; ajústalas si usas `XDG_CONFIG_HOME`.

| Aplicación | Recurso | Instalación / activación |
| --- | --- | --- |
| Ghostty | `ports/ghostty/Penamiller` | Copiar a `~/.config/ghostty/themes/Penamiller`; añadir `theme = Penamiller` a la configuración. |
| WezTerm | `ports/wezterm/penamiller.lua` | Copiar junto a `wezterm.lua`; usar `config.colors = require("penamiller")` en lugar del esquema previo. |
| bat | `ports/bat/penamiller.tmTheme` | Copiar a `$(bat --config-dir)/themes/`; ejecutar `bat cache --build` y seleccionar `--theme=penamiller`. |
| iTerm2 | `ports/iterm2/Penamiller.itermcolors` | Importar en Settings → Profiles → Colors → Color Presets → Import. |
| Zed | `ports/zed/penamiller.json` | Copiar a `~/.config/zed/themes/`; seleccionar `Penamiller`. |
| OpenCode | `ports/opencode/penamiller.json` | Copiar a `~/.config/opencode/themes/`; seleccionar `penamiller` en el ajuste `theme` de tu TUI. |
| Zellij | `ports/zellij/penamiller.kdl` | Copiar a `~/.config/zellij/themes/`; usar `theme "penamiller"` en `config.kdl`. |
| Herdr | `ports/herdr/penamiller.toml` | Combinar `[theme]` y `[theme.custom]` con `~/.config/herdr/config.toml`, sin duplicar tablas. |
| fzf | `ports/fzf/penamiller.sh` | Cargar con `source /ruta/a/penamiller/ports/fzf/penamiller.sh` desde tu shell; conserva las demás opciones de fzf. |
| Neovim / Catppuccin | `ports/nvim/penamiller.lua` | Combinar los overrides con las opciones de Catppuccin; ejemplo abajo. |
| Konsole | `ports/konsole/` | Copiar el esquema a `~/.local/share/konsole/`; seleccionarlo desde la apariencia del perfil. El perfil incluido es opcional. |
| KDE / Plasma | `ports/kde/` | Copiar `color-schemes/` y los paquetes de `plasma/` a las mismas rutas bajo `~/.local/share/`; elegirlos en Preferencias del sistema. |
| GTK 3 / 4 | `ports/gtk-3.0/penamiller.css`, `ports/gtk-4.0/penamiller.css` | Copiar cada archivo a su directorio `~/.config/gtk-3.0/` o `gtk-4.0/`; añadir `@import url("penamiller.css");` al principio de cada `gtk.css`, preservando el resto. |

### Neovim

Requiere `catppuccin/nvim`; es una personalización de Catppuccin, no un
colorscheme independiente. Copia el archivo a `~/.config/nvim/lua/penamiller.lua`.
Con lazy.nvim, combina este fragmento con la especificación existente:

```lua
{
  "catppuccin/nvim",
  name = "catppuccin",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, require("penamiller"))
  end,
}
```

Selecciona `catppuccin-mocha` como colorscheme; en LazyVim, mediante las
opciones de `LazyVim/LazyVim`. Las integraciones existentes permanecen intactas.

### KDE y GTK

El estilo Plasma necesita Breeze como fallback. Los overrides GTK se diseñaron
sobre Breeze y pueden no cubrir aplicaciones que impongan su propio estilo.
El Global Theme `com.parraletz.penamiller` aplica solo esquema de colores,
estilo Plasma y estilo de widgets Breeze: no cambia layout, iconos, cursor,
número de escritorios ni efectos. El preview original muestra también las
preferencias personales del escritorio de origen, que no se incluyen.

## Validación

Con Python 3.11 o posterior:

```sh
python3 -m venv .venv
.venv/bin/pip install -r requirements-dev.txt
.venv/bin/python -m unittest discover -s tests -v
```

Las pruebas comprueban el schema, casos inválidos, formatos JSON/plist/TOML,
paridad ANSI de Ghostty y el alcance visual del Global Theme. No sustituyen
las pruebas de apariencia dentro de cada aplicación.
