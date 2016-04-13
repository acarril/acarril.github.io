---
layout: post
title:  "Adding column percentages to tabstat"
categories: stata
permalink: /posts/column-percentages-tabstat
---

Tabstat is a very useful command to produce tables of various summary statistics. It also works seamlessly with estout, so this tables can be easily exported.

Suppose we want to produce

<pre class="sh_stata">
. use http://www.stata-press.com/data/r14/grunfeld, clear
. tab company
company |      Freq.     Percent        Cum.
------------+-----------------------------------
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
------------+-----------------------------------
  Total |        200      100.00
</pre>
