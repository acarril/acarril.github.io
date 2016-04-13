---
layout: post
title:  "Adding column percentages to tabstat"
categories: stata
permalink: /posts/column-percentages-tabstat
---

Tabstat is a very useful command to produce tables of various summary statistics. It also works seamlessly with estout, so this tables can be easily exported.

Suppose we have a dataset with information of 10 different companies over the a range of years.

<pre class="sh_stata">
. use http://www.stata-press.com/data/r14/grunfeld, clear
. tab company
company |      Freq.     Percent        Cum.
--------+-----------------------------------
      1 |         20       10.00       10.00
      2 |         20       10.00       20.00
      3 |         20       10.00       30.00
      4 |         20       10.00       40.00
      5 |         20       10.00       50.00
      6 |         20       10.00       60.00
      7 |         20       10.00       70.00
      8 |         20       10.00       80.00
      9 |         20       10.00       90.00
     10 |         20       10.00      100.00
--------+-----------------------------------
  Total |        200      100.00            
</pre>

We want to produce a table that sums all investments made so far by each firm and then export it. We can easily achieve that combining tabstat with estttab:

<pre class="sh_stata">
. estpost tabstat invest, by(company) stat(sum)
. esttab, cell(sum)
</pre>

Now suppose we want column percentages of those sums. Unfortunately, tabstat doesn't have an option for asking that statistic, but we can manually construct it and add it to our stored estimates using estadd:

<pre class="sh_stata">
. eststo: estpost tabstat invest, by(company) stat(sum)

. matrix colupct = e(sum) // create matrix with sums
. scalar c = colsof(colupct) // create scalar with number of rows of matrix
. matrix colupct = 100*colupct/colupct[1,c] // transorm matrix values to percentages
. estadd matrix colupct = colupct // add matrix 'colupct' to stored estimates

. esttab, cell(sum colupct)
</pre>
