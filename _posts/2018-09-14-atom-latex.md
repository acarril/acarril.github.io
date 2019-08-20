---
layout: post
title: Atom + LaTeX
---

![](https://ctan.org/lion/files/ctan_lion_600.png)

It's been a while since I updated my series on `Atom + <something>`, but here comes a good one: **how to set up Atom as a LaTeX editor**.
When I first migrated to Atom, I found that LaTeX support was a bit subpar, at least when compared to [Sublime's](https://www.sublimetext.com/).
However, I've tried lots of packages and configurations, and I believe the combination described below makes Atom a solid LaTeX editor.

<!--more-->

# Atom

I'm assuming you already have [Atom](https://atom.io/) up and running.
If you haven't, go to https://atom.io/ to download and install it.

Atom, like other text editors, works in such a way that it provides a lean, solid foundation to build on top of.
This means that it doesn't come with LaTeX support out-of-the-box, which has to be added by us, in the form of packages.
Each package (typically) adds one additional feature: syntax highlighting, compiling, PDF preview, etc.
The good news is that it is very easy to add these, and while there are several options for each feature, I've tested (almost?) all of them.

### Installing a package

In what follows we will install several packages.
To find and download a package within Atom, go to the **Settings View** with `Ctrl+Comma` (or under `Edit > Preferences`).
Look for the `Install` tab in the left, and in there just search for the package in question (wording has to be exact to get the intended package as first result).


# Syntax highlighting

The first thing we'll want to do is to have syntax highlighting for `.tex` files.
If you open a LaTeX document right now, it should look like plain text, ie. the left panel in the image below.
We want to have something like the right panel.

![](/assets/scrshots/atom-latex-syntaxhighlighting.png)

We'll use [`language-latex`](https://atom.io/packages/language-latex), which works great out of the box.
To install it, open the Settings View with `Ctrl+Comma` and in the `Install` tab look for `language-latex`.
It should start working right away.
If it doesn't, double check that the document you have open is recognized as a LaTeX file (it should say 'Latex' on the bottom right corner).
You can also explicitly set a language for any open document with `Ctrl+Shift+l` (or `Cmd+Shift+l` on a Mac).

Writing LaTeX is slightly different from normal coding, so for this specific language I like to turn on [soft wrapping](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap).
To do so, just go to the Settings View with `Ctrl+Comma` and in the 'Packages' tab look for our newly installed package, `language-latex`.
Open its settings and make sure the 'Soft Wrap' option is checked.

### Soft wrap and other tweaks

![](/assets/img/wrap.png)

*WTF is soft wrap?*, you may ask.
**Soft wrap** basically breaks very long lines into multiple ones, without actually inserting a real line break.
Since in LaTeX you're basically writing text, lines tend to be longer than your average Python statement, so if you want to avoid vertical scrolling this is what's best.
A  ~~stolen~~ GIF is worth a thousand images:

![](https://i.imgur.com/3qkEqvy.gif)

I also like to be able to **scroll past the end of the document**, so I'm not permanently focusing on the very bottom of the screen.
This feature can be activated for LaTeX in the `language-latex` configuration page, but I actually like this feature for *all* my documents, so if you also prefer that, you have to check the option in the in the 'Editor' tab of the general Settings View.


# Compile

So here is where you have most options, but after some testing I've decided that the [`latex`](https://atom.io/packages/latex) package is what works best (for me).
After installing, it *should* work out of the box if you've installed TeXLive (or MacTeX in Mac) or MiKTeX (although I tend to [avoid MiKTeX](https://tex.stackexchange.com/questions/20036/what-are-the-advantages-of-tex-live-over-miktex), and it is also less tested with this package).

To test it out, you can create a new file like `test.tex` with something like

```latex
\documentclass{article}
\begin{document}
Hello world!
\end{document}
```

The easiest way to compile (build) is by using `Ctrl+Shift+B`.
If no errors are found, it should automatically open the resulting PDF in your system's default PDF viewer (more on that below).
We will also tweak some settings after installing `pdf-view` (below).

# PDF preview

After a successful build, the `latex` package should automatically invoke your default PDF viewer for preview in a separate window.
In some situations this is fine, but when I want a preview I usually prefer it side by side inside the editor itself.
This behavior can be easily achieved by installing the [`pdf-view`](https://atom.io/packages/pdf-view) package.

![](/assets/scrshots/atom-latex-pdf-view.png)

If it doesn't work for you after installing, go to `latex` package settings and be sure to select `pdf-view` as Opener.
You can find these settings by opening the 'Settings View' with `Ctrl+Comma` and then selecting the 'Packages' tab on the left.
Look for the `latex` package and click on the 'Settings' button.
The 'Opener' option is near the end.

Now that you have the `latex` settings open, I would also recommend to check the `Enable SyncTeX` option.
Take this opportunity to further customize the settings.
For instance, you can build on each save, change the default logging levels (I would advice against changing the default though) and enable shell escape, if you need to do so.


## Spell check

Finally, since my native language is not english, I usually prefer to write documents with a spell checker.
Unfortunately, spell check is one of the most poorly developed LaTeX tools in Atom.
For the time being I went with the basic [`spell-check`](https://atom.io/packages/spell-check), which comes by default with Atom.
Make sure the package is installed (it should) and enabled.
Then go to the package's settings and add `text.tex.latex` at the end of the list of Grammars, like in the bottom right of the screenshot below.

![](/assets/scrshots/atom-latex-spellcheck-grammar.png)

After doing this, you should get spell checking in your LaTeX document.
However, something that annoyed me is that you also get corrections for obviously-LaTeXy commands, like `\documentclass`.
I discovered you can exclude certain parts of the document with the 'Exlude Scopes' option, and I added these scopes to that list.
You can add each scope in `spell-check` settings as comma separated names, or you can paste the following code directly in your `config.cson` file (`Edit > Config...`):

```json
"spell-check":
  excludedScopes: [
    "support.function.tex"
    "meta.preamble.latex"
    "support.type.function.latex"
    "comment.line.percentage.tex"
    "storage.type.function.latex"
    "support.function.latex"
    "string.other.math.tex"
    "string.other.math.block.environment.latex"
    "variable.parameter.function.latex"
    "constant.other.reference.latex"
  ]
```
