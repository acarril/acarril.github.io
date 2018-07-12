---
layout: post
title: Use Atom + Hydrogen!
draft: false
---

Less than a year ago I wrote a [long post praising Sublime](/posts/use-st3).
However, [times are a changin'](https://www.youtube.com/watch?v=e7qQ6_RV4VQ), and during this time I've reconsidered my choice of text editor.
So without further ado, let me bring forth to you what I believe is the ultimate one:

![](/assets/img/atom-banner.png)

I will give a detailed explanation on how to set up [Atom](https://atom.io/) for use with (my) furious five:

- **Python**
- **R**
- **Julia**
- Stata
- LaTeX

In this post I'll concentrate on the first three, because they can all be set up to interact with [Hydrogen](https://github.com/nteract/hydrogen), one of the coolest inventions since avocado on toast.

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
If you had a project folder open in the Tree Viewer, you should immediately see icons being updated.

Repeat the process above, this time looking up `project-manager`.


# Python, Julia and R with Atom + Hydrogen

One of the main reasons to use Atom is the [Hydrogen package](https://atom.io/packages/hydrogen), which is an interactive coding environment that supports Python, R and Julia kernels.
Put simply, **Hydrogen lets you run code inline and in real time, which is the ideal workflow for rapid developing.**
A gif is worth a thousand words:

![](https://cloud.githubusercontent.com/assets/13285808/20360886/7e03e524-ac03-11e6-9176-37677f226619.gif)

We'll set up Atom+Hydrogen to work with Python, R and Julia.
You can choose a subset of those packages, of course --- the steps involved are pretty much the same for all three of them.

First you should install the software. **Bear in mind that Python is pretty much a prerequisite for using Hydrogen with R and Julia (and other languages), because [Jupyter](http://jupyter.org/install) itself depends on Python.**
R and Julia are optional.

### Install Anaconda Python

If you don't have [Python](https://www.python.org/about/) in your system, I recommend you install [Anaconda Python](https://www.anaconda.com/).
**Anaconda is a Python distribution that comes with Python itself, plus 250+ popular data science and machine learning packages, plus the `conda` package and virtual environment manager.**
Importantly for us, it already comes bundled with [IPython](https://ipython.org/index.html) and its dependencies.
Just head over to [https://www.anaconda.com/download](https://www.anaconda.com/download) and download the version that corresponds to your system.
If you're unsure whether you should go with Python 2.x or 3.x, I suggest the latter.

If you have Python in your system (most versions of mac OS and Linux do), I still suggest you install Anaconda, as probably your system comes with Python 2.x, and Anaconda includes `conda` and [IPython](https://ipython.org/index.html).
If you already have Python and IPython installed and you know what you're doing, then this section is not for you.

### R

[R](https://www.r-project.org/about.html) is a venerable programming language for statistical computing.
You can download and install R by choosing a CRAN mirror [here](https://cran.r-project.org/mirrors.html) (for Windows you have to choose the `base` distribution).

You'll now need [IRkernel](https://github.com/IRkernel/IRkernel), which is a native R kernel for Jupyter.
Assuming you have already installed Anaconda Python (see [above](#install-python)), you'll just need to follow the steps outlined [here](https://github.com/IRkernel/IRkernel#installation) in order to finish.

### Julia

[Julia](https://julialang.org/) is an up-and-coming programming language for numerical analysis and computational science.
Head over to [https://julialang.org/downloads/](https://julialang.org/downloads/) to download the appropriate version for your operating system.

Finally, after installing Julia itself you need to add the [`IJulia`](https://github.com/JuliaLang/IJulia.jl) package.
To do so, just start a Julia interpreter (you should see a line starting with `julia>`) and type

```julia
Pkg.add("IJulia")
```

# Atom + Hydrogen

Once we have [Anaconda Python installed](#install-python) (or any Python distribution + Jupyter), we can now install Hydrogen itself.
In Atom, go to `Settings` (`Ctrl+Comma`) and in the `Install` pane look for `hydrogen` and install it.

Now we're ready for interactive coding! Create a new file with a `.py` (or `.R` or `.jl`) extension and write some code. For instance, you could create a new file called `test.py` with the following lines:

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Simple tests
print('Hello world!')
17+25

# Print dataframe
pd.DataFrame({'col1': [1, 2], 'col2': [3, 4]})

# Show plot
N = 50
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
area = (30 * np.random.rand(N))**2  # 0 to 15 point radii
plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt.show()
```

If you hit `Ctrl+Enter` in any line, Hydrogen should evaluate it in the appropriate kernel (Python, in this case) and output the result inline.
You can also evaluate multiple lines by selecting them, or the full script with `Ctrl+Shift+Alt+Enter`.
I suggest you read [Hydrogen's documentation](https://nteract.gitbooks.io/hydrogen/docs/Usage/GettingStarted.html) to see what you can do with it.
Below I demonstrate how to evaluate the code above.

![](/assets/gifs/hydrogen-demo.gif)
