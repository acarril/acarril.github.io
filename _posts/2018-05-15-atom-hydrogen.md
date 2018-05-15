---
layout: post
title: Use Atom + Hydrogen!
draft: true
---

Yes, I know than a year ago I wrote [a long post urging you to use Sublime](/posts/use-st3).
However, [times are a changin'](https://www.youtube.com/watch?v=e7qQ6_RV4VQ), _fast_ (at least for me), as I have matured my coding workflow very much.
So without further ado, let me bring forth to you the ultimate text editor:

![sdasd](/assets/img/atom-banner.png)

My plan is to give a detailed explanation on how to set up Atom for use with (my) furious five:

- **Python**
- **R**
- **Julia**
- Stata
- LaTeX

For this post I'll concentrate on the first three, because they can all be set up to interact with [Hydrogen](https://github.com/nteract/hydrogen), one of the coolest inventions since avocado on toast.

<!--more-->

# Atom installation and basic setup

Head over to [https://atom.io/](https://atom.io/) to download Atom for your operating system, and then install it.
Upon first execution, you should be greeted with something like the following screenshot:

![](/assets/scrshots/atom-welcome.png)

Now we're ready to go!

I suggest you open the Tree View (`View > Toggle Tree View`, or hit `Ctrl+\`), which gives you an overview of the files contained in a folder.
You can now right-click anywhere in that pane and select `Add Project Folder` (or hit `Ctrl+Shift+A`) to open any project folder that contains some scripts (eg. `*.py` files).
After doing so you should see something like the following screenshot:

![](/assets/scrshots/atom-win.png)

You'll notice that the file icons in my Tree View probably look much nicer than yours.
It's not only that they're nice --- it's helpful to be able to tell file types apart at a glance.
We'll fix that now, installing two packages (that I consider) essential:

- [File Icons](https://atom.io/packages/file-icons)
- [Project Manager](https://atom.io/packages/project-manager)

To install any package in Atom just go to `File > Settings` (or hit `Ctrl+Comma`) and select `Install` on the left pane (you can also go directly from the welcome screen, if you have it open).
Search for `file-icons` and install it.
If you had a project folder open in the Tree Viewer, you should inmediatly see icons being updated.

Repeat the process above, this time looking up `project-manager`.


# Python, Julia and R unite under Atom + Hydrogen

One of the main reasons to use Atom is the [Hydrogen package](https://atom.io/packages/hydrogen), which is an interactive coding environment that supports Python, R and Julia kernels.
Put simply, **Hydrogen lets you run code inline and in real time, which is the ideal workflow for rapid developing.**
A gif is worth a thousand words:

![](https://cloud.githubusercontent.com/assets/13285808/20360886/7e03e524-ac03-11e6-9176-37677f226619.gif)

We'll set up Atom+Hydrogen to work with Python, R and Julia.
You can choose a subset of those packages, of course --- the steps involved are pretty much the same for all three of them.

First you should install the software:

### Python

If you don't have Python in your system, I recommend you install [Anaconda Python](https://www.anaconda.com/).
**Anaconda is a Python distribution that comes with Python itself, plus 250+ popular data science and machine learning packages, plus the `conda` package and virtual environment manager.**
Just head over to [https://www.anaconda.com/download](https://www.anaconda.com/download) and download the version that corresponds to your system.
If you're unsure whether you should go with Python 2.x or 3.x, I suggest the latter.

If you have Python in your system (most versions of mac OS and Linux do), I still suggest you install Anaconda, as probably your system comes with Python 2.x, and Anaconda includes `conda`.
If you already have Python installed and know what you're doing, then this section is not for you.

### R
