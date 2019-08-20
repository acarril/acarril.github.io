---
layout: post
comments: true
title:  "Adding column percentages of sums to tabstat"
categories: stata
permalink: /posts/column-percentages-tabstat
---

Tabstat is a very useful command to produce tables of various summary statistics. It also works seamlessly with estout, so this tables can be easily exported.

Suppose we have a dataset with information of 10 different companies over the a range of years. You can load this (fake) dataset using

<pre class="sh_stata">
. use http://www.stata-press.com/data/r14/grunfeld, clear
</pre>

We want to produce a table that sums all investments made so far by each firm and then export it. We can easily achieve that combining tabstat with estttab, producing the following result:

<pre class="sh_stata">
. estpost tabstat invest, by(company) stat(sum)
. esttab, cell(sum)
-------------------------
                      (1)
                      sum
-------------------------
1                 12160.4
2                  8209.5
3                  2045.8
4                 1722.47
5                 1236.05
6                 1108.22
7                  951.91
8                  857.83
9                  837.78
10                  61.69
Total            29191.65
-------------------------
N                     200
-------------------------
</pre>

Now suppose we want column percentages of those sums. Unfortunately, tabstat doesn't have an option for asking that statistic, but we can manually construct it and add it to our stored estimates using estadd:

<pre class="sh_stata">
. eststo: estpost tabstat invest, by(company) stat(sum)

. matrix colupct = e(sum) // create matrix with sums
. scalar c = colsof(colupct) // create scalar with number of rows of matrix
. matrix colupct = 100*colupct/colupct[1,c] // transorm matrix values to percentages
. estadd matrix colupct = colupct // add matrix 'colupct' to stored estimates

. esttab, cell(sum colupct)
-------------------------
                      (1)

              sum/colupct
-------------------------
1                 12160.4
                 41.65712
2                  8209.5
                 28.12277
3                  2045.8
                 7.008168
4                 1722.47
                 5.900557
5                 1236.05
                 4.234259
6                 1108.22
                  3.79636
7                  951.91
                 3.260898
8                  857.83
                 2.938614
9                  837.78
                  2.86993
10                  61.69
                 .2113276
Total            29191.65
                      100
-------------------------
N                     200
-------------------------
</pre>

Finally, it is probably nicer to present those percentages with only one decimal and inside parenthesis. We can do this by adding the necessary options to esttab:

<pre class="sh_stata">
. eststo clear // clear previously stored estimates
. esttab, cell(sum colupct(fmt(1) par))
-------------------------
                      (1)

              sum/colupct
-------------------------
1                 12160.4
                   (41.7)
2                  8209.5
                   (28.1)
3                  2045.8
                    (7.0)
4                 1722.47
                    (5.9)
5                 1236.05
                    (4.2)
6                 1108.22
                    (3.8)
7                  951.91
                    (3.3)
8                  857.83
                    (2.9)
9                  837.78
                    (2.9)
10                  61.69
                    (0.2)
Total            29191.65
                  (100.0)
-------------------------
N                     200
-------------------------
</pre>
