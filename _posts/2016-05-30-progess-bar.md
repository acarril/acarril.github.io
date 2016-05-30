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

The first call of `_dots` sets up the graduated header line (`----+--- 1 ---+--- 2`...). Both the `title` and `reps` (repetitions) options are optional and bear in mind that `reps` only accepts integers as its argument.

Further calls of `_dots` (like inside the loop) take two arguments:

- The first argument is the *repetition number*, which tracks the number of attempts in progress. In the above example, it is automatically updated by the loop.
- The second argument is the *return code*, which indicates the type of symbol displayed in the current repetition. The usual is to use `0`, which outputs a dot. Return codes are
  - -1:
  - 0: 
  - 1:
  - 2:
  - 3:

When collapsing a dataset with the [`collapse`](http://www.stata.com/help.cgi?collapse) command, all variable [labels](http://www.stata.com/help.cgi?label) are replaced by <code>(stat) <i>varname</i></code>. This short post describes how to preserve variable labels and restore them after collapsing.

First we **save all variable labels in locals**. I create locals for variables which don't have label in order to avoid pasting empty labels later on.

```stata
foreach v of var * {
  local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}
}
```

After collapsing the data, we need to **restore variable labels** using

```
foreach v of var * {
	label var `v' "`l`v''"
}
```
