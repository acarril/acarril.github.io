+++
author = "Álvaro Carril"
title = "Julia"
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

### Windows

``` html
<h1>Hello, World!</h1>
```


```python
#!/usr/bin/env python
"""Test file for Python syntax highlighting in editors / IDEs.
Meant to cover a wide range of different types of statements and expressions.
Not necessarily sensical or comprehensive (assume that if one exception is
highlighted that all are, for instance).
Extraneous trailing whitespace can't be tested because of svn pre-commit hook
checks for such things.
"""
# Comment
# OPTIONAL: XXX catch your attention
# TODO(me): next big thing
# FIXME: this does not work

# Statements
from __future__ import with_statement  # Import
from sys import path as thing

print(thing)

assert True  # keyword


def foo():  # function definition
    return []


class Bar(object):  # Class definition
    def __enter__(self):
        pass

    def __exit__(self, *args):
        pass

foo()  # UNCOLOURED: function call
while False:  # 'while'
    continue
for x in foo():  # 'for'
    break
with Bar() as stuff:
    pass
if False:
    pass  # 'if'
elif False:
    pass
else:
    pass

# Constants
'single-quote', u'unicode'  # Strings of all kinds; prefixes not highlighted
"double-quote"
"""triple double-quote"""
'''triple single-quote'''
r'raw'
ur'unicode raw'
'escape\n'
'\04'  # octal
'\xFF'  # hex
'\u1111'  # unicode character
1  # Integral
1L
1.0  # Float
.1
1+2j  # Complex

# Expressions
1 and 2 or 3  # Boolean operators
2 < 3  # UNCOLOURED: comparison operators
spam = 42  # UNCOLOURED: assignment
2 + 3  # UNCOLOURED: number operators
[]  # UNCOLOURED: list
{}  # UNCOLOURED: dict
(1,)  # UNCOLOURED: tuple
all  # Built-in functions
GeneratorExit  # Exceptions
```


## VS Code

[Julia](https://julialang.org/) support in VS Code is first class, and setting everything up is simple. Ditch that RAM-hogging, proprietary ~~Methlab~~ Matlab, and get ready to fly.