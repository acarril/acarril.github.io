---
layout: post
title:  Export Stata results as LaTeX macros
categories: stata
---

One of the main advantages of a Stata/LaTeX workflow is the automatic updating of tables and figures in the document. However, this advantage does not extend to specific results mentioned in the text. I usually solve this by exporting results (e.g. coefficients, p-values, etc.) as LaTeX macros to an external file, which I latter call from the document draft. In this post I explain how to do this, both manually and using a new command in Stata I wrote specifically for this purpose.

## The issue

Say you're analyzing the good old `auto` dataset, running some paradigm-shifting regressions like the following:

```
. sysuse auto
. reg mpg trunk weight foreign

      Source |       SS           df       MS      Number of obs   =        74
-------------+----------------------------------   F(3, 70)        =     46.28
       Model |  1624.42351         3  541.474502   Prob > F        =    0.0000
    Residual |  819.035953        70  11.7005136   R-squared       =    0.6648
-------------+----------------------------------   Adj R-squared   =    0.6504
       Total |  2443.45946        73  33.4720474   Root MSE        =    3.4206

------------------------------------------------------------------------------
         mpg |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       trunk |  -.0839366   .1266921    -0.66   0.510    -.3366161    .1687428
      weight |  -.0062609    .000808    -7.75   0.000    -.0078723   -.0046494
     foreign |  -1.603031   1.082598    -1.48   0.143    -3.762204    .5561418
       _cons |   41.83298   2.186429    19.13   0.000     37.47228    46.19367
------------------------------------------------------------------------------
```

Later, you could use [`estout`](http://repec.org/bocode/e/estout/esttab.html) to export a table of regression results to be included in your LaTeX document. One of the advantages of doing so is that if you later make some adjustments to the regression that produced those results, the document's table will be automatically updated (after rerunning the do-file and compiling the TeX file, clearly).

However, suppose you want to mention the `foreign` coefficient in your text. It is very likely that you will just copy the number, approximate it and paste it in your document. The problem with this approach is that if your coefficient changes as a result of modifying the regression, you'll have to hunt down all of its mentions in the draft.

<!--more-->

## Proposed solution

I though about this problem and realized that the advantage of figures and tables is that you call them from our documents with a fixed name. For instance, let's suppose you export the table above as `basic_reg.tex`. In your document, you just call it and it will be updated automatically.

**So the solution is to call individual results with fixed names, in a way that's analogous to figures and tables.** The way to achieve this is to export all individual result's (e.g. coefficients, $$p$$-values, etc.) as LaTeX macros that *contain* the numeric result. These macros are all stored in one text file which is called in the document preamble, allowing you to call these results as macros within the text.

For example, instead of copying and pasting the `foreign` coefficient we could save it in a local, rounding it down to a reasonable number of decimal figures:

```stata
local foreign = round(_b[foreign], 0.1)
```

Now we can use the [`file`](http://www.stata.com/manuals14/pfile.pdf) command to create a text file with a new LaTeX macro containing our stored coefficient:

```stata
capture: file close myfile
file open myfile using "results.tex", write replace
file write myfile "\newcommand{\foreign}{$`foreign'$}" _n
file close myfile
```

Notice that I saved the coefficient inside inline math delimiters ($...$), to get nice numbers in LaTeX. I also finished the line with  `_n` in order to add a new line, which will be useful if we store additional macros in the same file.
Now we just need to go to our LaTeX document and use this result! A minimal working example would look like this:

```TeX
\documentclass{article}
\input{results.tex}
\begin{document}
Our main result is \foreign.
\end{document}
```

### Stata command

I took this approach, added some other nice details and wrapped it up into **`texresults`**, a Stata program available for download at the SSC. To get it, just execute

```stata
ssc install texresults
```

The command allows you to achieve the same result as before with just one line. For instance, to save the foreign coefficient you would execute the following line after estimation:

```stata
texresults using results.txt, texmacro(mainresult) coef(foreign)
```

Besides saving us lines of code, `texresults` allows us to easily extract other regression results. For instance, we could append `foreign`'s $$t$$-stat to the macros file using

```stata
texresults using results.txt, texmacro(trunkT) tstat(trunk) append
```

Other nice capabilities of `texresults` include:

- Option to automatically add a zero to the units digit if it is missing (i.e. store $0.12$ instead of $.12$)
- Automatic rounding of results, with ability to modify number of significant digits
- Option to define commands using xspace, which is a nicer way of dealing with space after LaTeX macros; see [this question](http://tex.stackexchange.com/questions/31091/space-after-latex-commands) for more info.
