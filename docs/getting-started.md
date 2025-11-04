# Getting Started with Iris

## Installation

Iris is a Uiua library using native OS features, so you will need to
[install the Uiua interpreter](https://www.uiua.org/install). The
[latest dev release](https://github.com/uiua-lang/uiua/releases/tag/latest) is
recommended, because many bugs are fixed every day.

Once everything is installed, open up a file called `main.ua` and paste this at
the top.

```uiua
# Experimental!
I ~ "gh: Marcos-cat/iris"

I~Open 500_500 "The Title"

I~Loop!(
  I~Draw~Background Purple
)
```

To verify your installation is working properly, run `uiua run main.ua` and make
sure no errors appear. If you still get errors, you can feel free to
troubleshoot in the
[Uiua Discord server](https://discord.com/invite/3r9nrfYhCc).

## Where Next

If you want to learn the basics of how Iris operates, continue onto
[the tutorial](./basics.md), or skip to a particular section.

<!--TODO: Say list what is next -->
