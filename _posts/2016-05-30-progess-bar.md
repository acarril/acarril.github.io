---
layout: post
title:  "Loops with progress bars"
categories: stata
---

A few Stata commands (like [`bootstrap`](http://www.stata.com/help.cgi?bootstrap)) have a "progress bar", which is more like a table of dots. Nevertheless, it is very useful for tracking the advancements made in long loops or programs. In this post I explain how to include progress bars in several different situations.

The key lies in using `_dots`, an undocumented Stata command whose only "official" mention is by [David Harrison (2007)](http://www.stata-journal.com/sjpdf.html?articlenum=pr0030). He outlines two examples in that Stata Tip, which I explain and expand in this post.

# Basic usage

The easiest way to implement this is in a [forvalues loop](http://www.stata.com/help.cgi?forvalues), as Harrison's first example:

<pre>
_dots 0, title(Loop running) reps(75)
forvalues i = 1/75 {
  <i>some commands...</i>
  _dots `i' 0
}
Loop running (75)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
..................................................    50
.........................
</pre>

The **first call of `_dots`** sets up the graduated header line (`----+--- 1 ---+--- 2`...). Both the `title` and `reps` (repetitions) options are optional and keep in mind that `reps` only accepts integers as its argument.

**Further calls of `_dots`** (like inside the loop) take two arguments:

- The first argument is the *repetition number*, which tracks the number of attempts in progress. In the above example, it is automatically updated by the loop.
- The second argument is the *return code*, which indicates the type of symbol displayed in the current repetition. The usual is to use `0`, which outputs a dot. Return codes are
  - `-1`: outputs a green `s`
  - `0`: outputs a black dot, `.`
  - `1`: outputs a red `x`
  - `2`: outputs a red `e`
  - `3`: outputs a red `n`
  - Any other value used in the return code outputs a red `?`

# Usage in non-numerical Loops

It is very straightforward to implement this in loops which are non-numerical by **defining a local macro to act as a counter**. For example, in a [foreach](http://www.stata.com/help.cgi?foreach) loop with a [varlist](http://www.stata.com/help.cgi?varlist):

<pre>
sysuse auto
_dots 0, title(Loop running) reps(10)
foreach var of varlist price - gear_ratio {
  <i>some commands...</i>
  local i = `i'+1
  _dots `i' 0
}
</pre>

The number of repetitions is not guessed by `_dots` and I had to manually count the variables and enter the number. The number of variables  could be counted automatically with the help of the [`list` extended macro](http://www.stata.com/manuals13/pmacrolists.pdf) function `sizeof`. For example,

<pre>
sysuse auto
unab myvars : price - gear_ratio
local N : list sizeof myvars
_dots 0, title(Loop running) reps(`N')
foreach var of varlist `myvars' {
  local i = `i'+1
  _dots `i' 0
}
</pre>

Notice that I first expanded the variable list with [`unab`](http://www.stata.com/manuals13/punab.pdf).
