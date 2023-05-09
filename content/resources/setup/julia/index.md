+++
author = "Álvaro Carril"
title = "Julia"
date = "2022-12-16"
lastmod = "2022-12-23"
draft = true
description = "Sample article showcasing basic Markdown syntax and formatting for HTML elements."
tags = [
    "markdown",
    "css",
    "html",
    "themes",
]
categories = [
    "themes",
    "syntax",
]
series = ["VS Code"]
aliases = ["migrate-from-jekyl"]
+++

{{< toc >}}

## Initial setup

### macOS

As usual, my recommendation in macOS is to use [Homebrew](https://brew.sh/).
If you don't care about compiling from source or managing different Julia versions, the easiest method to install the latest version of Julia is using a cask:

```zsh
brew install --cask julia
```

Alternatively, if you don't have Homebrew (you should), you can [download](https://julialang.org/downloads/#current_stable_release) the `*.dmg` of the latest current stable release and install Julia as a normal application.
However, after installing it, you need to symlink the binary to some location present in your path (see [here](https://julialang.org/downloads/platform/#macos) for more info). This can be done with
```zsh
sudo ln -s /Applications/Julia-1.8.app/Contents/Resources/julia/bin/julia /usr/local/bin/julia
```

Both of these methods are literally [the same](https://github.com/Homebrew/homebrew-cask/blob/master/Casks/julia.rb).
Whichever you use, make sure you can invoke the Julia REPL by typing `julia` in your terminal without errors.

{{< figure src="images/julia-repl.png" >}}



<!-- ## VS Code

[Julia](https://julialang.org/) support in VS Code is first class, and setting everything up is simple. Ditch that RAM-hogging, proprietary ~~Methlab~~ Matlab, and get ready to fly. -->