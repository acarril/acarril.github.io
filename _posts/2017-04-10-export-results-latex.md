---
layout: post
title:  Export Stata results as LaTeX macros
categories: stata
---

One of the main advantages of a Stata/LaTeX workflow is the automatic updating of tables and figures in the document. However, this advantage does not extend to specific results mentioned in the text. I usually solve this by exporting results (e.g. coefficients, p-values, etc.) as LaTeX macros to an external file, which I latter call from the document draft. In this post I explain how to do this, both manually and using a new command in Stata I wrote specifically for this function.

# The issue

Say you're analyzing the good old auto dataset, running some paradigm-shifting regressions like the following:

```stata
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

# Proposed solution

So I though about this problem and realized that the advantage of figures and tables is that you call them from your document with a fixed name. For instance, let's suppose you import

# Description

`texresults` is a convenience command to easily store any computed result to a LaTeX macro.
After running an estimation command in Stata, `texresults` can be used to create a new LaTeX macro, which is stored in an external text file.
This file may be called from a LaTeX document in order to use those results.

One of the main advantages of a Stata/LaTeX workflow is the automatic updating of tables and figures.
For instance, if we add a new control variable to a regression, we can correct the do-file that produces a table of coefficients and compile the LaTeX document again to see the updated table.
However, that advantage doesn't extend to in-text mentions of coefficients (or other results).
This leads to documents that contain inconsistent results, which have to be manually checked every time a preliminary result changes. 

This sitation can be remedied by creating an external file with LaTeX macros that store all cited results of an analysis.
Using these macros instead of manually copying results in the text is much less error prone, and we can be certain that results are consistent throughout the document.