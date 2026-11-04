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
config.core_text_font_smoothing = false
```

CoreText does not use the FreeType hinting settings. Font selection, font size,
and the terminal cell grid still use the existing configuration.

`core_text_font_smoothing` defaults to `true`. Setting it to `false` disables
CoreText's additional stroke thickening while preserving grayscale antialiasing,
the selected font face, and its metrics.
