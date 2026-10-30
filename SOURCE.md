# Origen

Extraído de `parraletz/dotfiles-ai`, commit `9a5da19`, sin copiar su
historial ni las configuraciones personales. Autor de la paleta: parraletz.

Los archivos de tema se conservan; Ghostty, WezTerm,
Herdr y fzf contienen solo el fragmento reutilizable de color.
El Global Theme conserva la captura original como preview, pero ya no
establece iconos, cursor, escritorios virtuales, efectos, botones de ventanas
ni otros ajustes personales. Su apariencia dependerá de esos ajustes locales.

El estilo Plasma usa Breeze como fallback y toma Soplos Classic Black como
referencia. Se conservan las declaraciones `GPL-3.0-or-later` de los paquetes
KDE; esta extracción no asigna una licencia nueva al resto de los archivos.

## Native Neovim colorscheme

The original Neovim port consisted of Catppuccin palette overrides. It has
been replaced by an independently implemented, self-contained colorscheme in
`colors/penamiller.lua`, using the Penamiller palette and Neovim's highlight API.
No Catppuccin source code or runtime dependency is included. Common plugin
highlight groups are defined directly; support does not imply identical
coverage or appearance to the previous Catppuccin-based configuration.
