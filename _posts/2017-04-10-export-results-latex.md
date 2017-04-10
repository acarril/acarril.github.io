---
layout: post
title:  Export Stata results as LaTeX macros
categories: stata
---

One of the main advantages of a Stata/LaTeX workflow is the automatic updating of tables and figures in the draft. However, this advantage does not extend to specific results mentioned in the document text. I usually solve this by exporting results (e.g. coefficients, p-values, etc.) as LaTeX macros to an external file, which I latter call from the document draft. In this post I explain how to do this, both manually and using a new command in Stata I wrote specifically for this function.

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