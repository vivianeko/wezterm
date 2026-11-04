---
tags:
  - font
---
# `font_rasterizer`

Specifies the method by which fonts are rendered on screen. The default is
`FreeType`. `Harfbuzz` is also available.

On macOS, this fork also provides an experimental `CoreText` renderer. It uses
the native macOS APIs to draw glyphs instead of FreeType:

```lua
config.font_rasterizer = 'CoreText'
```

CoreText does not use the FreeType hinting settings. Font selection, font size,
and the terminal cell grid still use the existing configuration.
