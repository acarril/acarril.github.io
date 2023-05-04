+++
author = "Álvaro Carril"
title = "Terminal & Shell"
date = "2022-12-16"
lastmod = "2022-12-23"
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
series = ["my-setup"]
aliases = ["migrate-from-jekyl"]
+++

This guide covers macOS exclusively, because it's what I use the most these days.
However, everything related to [ZSH](#zsh) is applicable to Linux.

{{< toc >}}

## iTerm2

[Terminal](https://en.wikipedia.org/wiki/List_of_macOS_built-in_apps#Terminal), the creatively named terminal emulator that comes with macOS, sucks.

{{< figure src="images/terminal-osx.png" >}}

Well, not really... but we can do much better. There are many alternatives out there, but for me nothing beats [iTerm2](https://iterm2.com/).
Download it from its website, and let's get configuring.

{{< figure src="images/iterm-neofetch.png" >}}

### Hotkey Window

A feature that seems to be standard in Linux and that I really miss in macOS is the ability to invoke a terminal window anytime with a key combo (e.g. `Super + T` in [pop_OS](https://support.system76.com/articles/pop-keyboard-shortcuts)).
We can configure iTerm2 to achieve the same result.
Go to Preferences > Profiles > Keys, then Configure Hotkey Window, where you can configure a Hotkey.
I personally like `Ctrl + \`, but you do you.

{{< figure src="images/iterm-hotkey.gif" >}}

### Word-by-word movement

I like being able to traverse a line word-by-word, which is easily enabled by going to Preferences > Profiles > Keys > Key Mappings, and selecting Natural Text Editing under Presets.
This allows you to move with between words using `Option + Right/Left` (e.g. ⌥← moves backwards).
More info [here](https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm).

{{< figure src="images/iterm-natural-editing.gif" >}}

### Color scheme

I'm a big fan of [Atom's One Dark](https://github.com/atom/atom/tree/master/packages/one-dark-syntax) color scheme, which has outlived the editor.
These are the colors in all the screenshots here.
Installation instructions for iTerm2 can be found in https://github.com/one-dark/iterm-one-dark-theme.

## ZSH

Getting the terminal working is half of the fun—now we turn to the shell.
In recent versions of macOS, [ZSH](https://www.zsh.org/) has become the system's default, which I like.
However, a lot more can be done to make it prettier and more functional.

Make sure your shell is indeed ZSH by running
```zsh
echo $SHELL
```
The output should be something like `/bin/zsh` (or any string that includes `zsh`).
If ZSH is not installed or not your default, follow [these steps](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#zsh) to correct it.

### Oh My ZSH

> Oh My Zsh will not make you a 10x developer...but you may feel like one!

That works for me!
Go to https://ohmyz.sh/ for install instructions, which boil down to one line:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Prompt

I like the [pure prompt](https://github.com/sindresorhus/pure) a lot, and I find that I'm satisfied with all of its defaults. It looks like this:

{{< figure src="https://github.com/sindresorhus/pure/raw/main/screenshot.png" >}}

Installation with Homebrew is very simple, as usual.

```zsh
brew install pure
```
After installing it, add the following lines to the end of your `~/.zshrc` file.
```zsh
fpath+=("$(brew --prefix)/share/zsh/site-functions")    # If you *didn't* install ZSH via Homebrew
autoload -U promptinit; promptinit
prompt pure
```


### Autosuggestions

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) is a plugin that automatically suggests the continuation of a command based on your terminal history.
Just typing → accepts the whole suggestion, or [word-by-word](#word-by-word-movement) with ⌥→.

{{< figure src="images/zsh-autosuggestions.gif" >}}

With Homebrew:
```zsh
brew install zsh-autosuggestions
```

Then, at the end of your `~/.zshrc` file:
```zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

### Syntax Highlighting

Adding [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) to the shell allows you to validate on-the-fly if a command is installed and in your path, as well as catching syntax errors, and making the overall output nicer.

With Homebrew:
```zsh
brew install zsh-syntax-highlighting
```

Then, at the end of your `~/.zshrc` file:
```zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```