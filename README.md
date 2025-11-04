# Iris

*A simple game library around [Rayua](https://github.com/uiua-lang/rayua)*

- [Getting Started](./docs/getting-started.md)
- [Docs](https://marcos-cat.github.io/iris/)
- [Examples](./examples/)

```uiua
# Experimental!
I ~ "gh: Marcos-cat/iris"
```

## Features

This is a list of the core improvements over Rayua that drove me to write this.

### Shorter names

I want more code than words in my code. Rayua uses the names of the C functions
from Raylib, which are quite verbose. Iris also organizes things into modules,
for further potential to shorten names.

### Pervasive functions

Iris adds logic so that calling functions on arrays takes one call. The basic
Rayua functions are direct wrappers of the C functions, which of course aren't
pervasive, and require heavy use of `≡ rows`.

### Complex coordinates

All functions that accept a pair of pixel values (a width and height, or a
position) also accept complex scalars. This can make manipulating many
coordinates much easier, as they are scalars. It also influences the user to use
complex numbers, which can make 2d calculations much easier.

### Inverses

Many Iris functions that act as getters are also setters as inverses. This
removes the need for many similar functions, such as `SetTargetFPS` and
`GetFPS`.

### Normal colors

Iris exclusively uses Uiua-native colors (RGB \[0, 1\]) instead of \[0, 255\].
This makes manipulating colors much easier - functions like `⁅`, `¬`, or `√` now
work. It also means that you can use the
[built-in color constants](https://www.uiua.org/docs/constants).

## Projects in Iris

- [Wordle](https://github.com/Marcos-cat/wordle-uiua)
- [Fractal Zoom](https://github.com/ronondex2009/Uiua-Interactive-Fractal-Zoomer)
- [Minesweeper](https://github.com/Marcos-cat/minesweeper-uiua)
- [Bejeweled](https://github.com/donstenzel/bejeweled-uiua)
- [Takua](https://github.com/Omnikar/takua)

## Modules

Iris has a few modules to control different parts of an OS window. The most
common are:

- `Draw` - draw different shapes on the screen
- `Mouse` - access the user's mouse
- `Key` - access the user's keyboard
- `Window` - access the OS window
