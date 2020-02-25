---
layout: post
title: Using multiple Julia kernels in Hydrogen for Atom
---

[Hydrogen](https://github.com/nteract/hydrogen) for Atom remains one of my favorite ways to write Julia code.
However, I couldn't find documentation on how to easily switch between different Julia kernels on the fly.
This might be convenient if you want to stick to, for instance, LTS releases for some work while also being able to try out features in the newest version.
{: .fs-6 .fw-300 }

# The problem

At the time of writing this, I did most of my Julia coding under version 1.0.5, the Long Term Support (LTS) release.
However, I also wanted to try out Julia's [composable multi-threaded parallelism](https://julialang.org/blog/2019/07/multithreading/), which was shipped on version 1.3.0.
Therefore, I wanted to be able to switch between both kernels easily.
Here I explain how I did it.

# Fetching the Julia binaries


### Via package managers

At the time of writing this, some Arch, Debian and Ubuntu Linux distributions are starting to include their own builds of Julia in their respective package repositories.
Hence, you can simply type
```bash
sudo pacman -S julia
sudo apt install julia
```
to install the latest version.
However, the point here is that we're trying to have different versions in our system, and for that we'll need to manually download the binaries.


### Direct download

In my case, I prefer tu install Julia manually, downloading the official binaries directly from [julialang.org](https://julialang.org/downloads/).
I keep all current binaries that I'm using inside a `~/Julia/` folder that I've previously created, so the directory structure looks like the following:

```
~/Julia
    |---- julia-1.0.5
    |---- julia-1.3.1
```

If you haven't created that folder, you can do so with
```bash
mkdir ~/Julia
```
Download the appropiate binaries from [julialang.org](https://julialang.org/downloads/) and into the newly created Julia folder.
In Linux, these files will come in `.tar.gz` format, which you can unpack with `tar -xf <file>`.
For example, to unpack Julia 1.0.5 and 1.3.1 you need to navigate to the folder where you downloaded them (here I'm assuming it's `~/Julia`) and unpack them, which is done with
```bash
cd ~/Julia
tar -xvf julia-1.0.5-linux-x86_64.tar.gz
tar -xvf julia-1.3.1-linux-x86_64.tar.gz
```

# Symlinks to Julia binaries

In order to be able to execute Julia from the terminal by simply typing `julia`, you need to locate the executable in your path.
There are many ways of doing this, but my preferred method is to symlink the binaries in `~/Julia/julia-x.x.x` to `/usr/local/bin`, which *should* be on your path (you can check it by looking at the output of `echo $PATH`).
Basically, what we are doing is creating a "shortcut" (symlink) to the executable `~/Julia/julia-x.x.x/bin/julia` and locating that symlIink in a path that the system will search for.

What I like to do is to have a symlink that's called simply `julia`, which executes the latest version (eg. 1.3.1), while also having `julia-lts` for the latest LTS release.
This can be easily accomplished by running
```bash
ln -s ~/Julia/julia-1.0.5/bin/julia /usr/local/bin/julia-lts
ln -s ~/Julia/julia-1.3.1/bin/julia /usr/local/bin/julia
```
At this point you should be able to type `julia-lts` and get into Julia 1.0.5, while typing `julia` will get you into Julia 1.3.1.

![](/assets/screenshots/julia_julia-lts_symlinks.png)


# Adding Julia kernels

Kernels for both installed versions can be registered simply by adding the `IJulia` package in the appropriate version.
This can be done either via Julia's package manager or with the `Pkg` library.
For instance, the latter method would be
```julia
using Pkg
Pkg.add("IJulia")
```
**Remember to do this in both Julia versions separately.**

Now, inside Atom (and assuming you have already installed Hydrogen), you can use the control panel to select the `Hydrogen: Update Kernels` option, or simply restart Atom.

Now, once you run a Julia file, Hydrogen should prompt you to choose between the kernels you have just made available.

![](/assets/screenshots/atom-hydrogen-select-kernel.png)

Finally, if you want to customize how the names are displayed on the list (I added LTS in parenthesis next to 1.0.5), you can directly edit the appropriate `kernel.json` file, which are located in `.local/share/jupyter/kernels/julia-1.x/kernel.json`.