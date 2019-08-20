---
layout: post
title: Atom + Stata
---

![](/assets/img/atom-stata.png)

By popular demand, in this post I'll explain how to use Stata with Atom in Linux, Mac and Windows.
This is possible because my colleague and friend [Kyle Barron](https://github.com/kylebarron) wrote two plugins:

- [`language-stata`](https://github.com/kylebarron/language-stata), which provides syntax highlighting
- [`stata-exec`](https://github.com/kylebarron/stata-exec), which sends the code to be executed in Stata

Kyle has already written a good readme file on how to install and use these plugins, so this is more than anything a promotial post (as if this humble blog could promote anything).
<!-- I'll do my best to explain clearly how to install and use these plugins in every OS, as it is a bit different in each one. -->
Also, I will discuss the current limitations of these programs, and how you can bug Kyle to address them ;)

<!--more-->

# Atom

[Atom](https://atom.io/) is a flexible, slick-looking text editor with many great features.
If you aren't familiar with it, I give a more detailed introduction in a [post on using Atom with Hydrogen](/posts/atom-hydrogen) to work with Python, R and Julia.
In this post I'll assume you have Atom itself already up and running, which is a matter of simply going to https://atom.io/ to download and install it.

By the end of this post you will be able to edit Stata `do` files (or `ado` files) in Atom, and send the code to Stata from Atom:

![run-command](https://raw.githubusercontent.com/kylebarron/stata-exec/master/img/run_command.gif)


# `language-stata`

The first thing we need to turn Atom into a proper Stata editor is getting syntax highlighting, i.e. getting Atom to display the code in different colors and fonts according to the category of terms:

![](/assets/img/language-stata-screenshot.png)

To get this feature working, you need to install [`language-stata`](https://github.com/kylebarron/language-stata) by going to `File > Settings` (or hit `Ctrl/Cmd+Comma`) and selecting `Install` on the left pane.
Search for `language-stata` and install it.

If you have a file with the `.do` (or `.ado`) extension open, you should immediately see it change.
If it doesn't work, try restarting Atom with `Ctrl/Cmd+Shift+F5` (or simply closing and re-opening it).


# `stata-exec`

Now for the fun part, we need to be able to send this pretty code over to Stata.
The process is different whether you are on Windows, Linux or Mac, so I suggest you follow the [steps in the installation section of the `stata-exec` repository](https://github.com/kylebarron/stata-exec#installation).
Also, make sure you correctly [configure it](https://github.com/kylebarron/stata-exec#configuration).

I know it's a bit lazy not to write the steps myself, but given that Kyle has done a great job already, I see no reason to do it.
Maybe I'll update this section if it proves too complicated (specially for Windows).

# Usage and limitations

Again, Kyle has written a well-detailed section on how to use `stata-exec` in the [project's readme file](https://github.com/kylebarron/stata-exec/blob/master/README.md#usage).
I recommend you check that out.

One of the nicest features of `stata-exec` is that it can send Stata code to a remote instance (e.g. X-windowed Stata over SSH).
In order to make it possible, the plugin is programmed such that each line of code is copied, pasted and executed in the Stata instance (be it local or remote) --- that is, it doesn't create a temporary file with the code chunk, as Stata itself does.
However, the main drawback of this approach is that currently even if one of the lines sent for execution fails, the code keeps running.
For me this is one of the biggest drawbacks of using `stata-exec` right now.
I have raised this concern in the repository (see [issue #30](https://github.com/kylebarron/stata-exec/issues/31)).
