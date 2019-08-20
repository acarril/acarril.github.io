---
layout: post
title:  "Loops with progress bars"
categories: stata
---

A few Stata commands (like [`bootstrap`](http://www.stata.com/help.cgi?bootstrap) or my own [psestimate](/resources/psestimate)) have a "progress bar", which is more like a table of dots. Those are very useful for tracking the advancements made in long loops or programs. In this post I explain how to include progress bars in several different situations.

The key lies in using `_dots`, an undocumented Stata command whose only "official" mention (AFAIK) is by [David Harrison (2007)](http://www.stata-journal.com/sjpdf.html?articlenum=pr0030). He outlines two examples in that Stata Tip, which I explain and expand in this post.

# Basic usage

The easiest way to implement this is in a [forvalues loop](http://www.stata.com/help.cgi?forvalues), as Harrison's first example:

```
_dots 0, title(Loop running) reps(75)
forvalues i = 1/75 {
  ...
  _dots `i' 0
}
Loop running (75)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
..................................................    50
.........................
```

The **first call of `_dots`** sets up the graduated header line (`----+--- 1 ---+--- 2`...). Both the `title` and `reps` (repetitions) options are optional. Keep in mind that `reps` only accepts integers as its argument.

**Further calls of `_dots`** (most probably inside a loop, like above) take two arguments:

- The first argument is the *repetition number*, which tracks the number of attempts in progress. In the above example, it is automatically updated by the loop.
- The second argument is the *return code*, which indicates the type of symbol displayed in the current repetition. The usual is to use `0`, which outputs a dot. Return codes are
  - `-1`: outputs a green `s`
  - `0`: outputs a black dot, `.`
  - `1`: outputs a red `x`
  - `2`: outputs a red `e`
  - `3`: outputs a red `n`
  - Any other value used in the return code outputs a red `?`

# Usage in non-numerical loops

It is very straightforward to implement this in loops which are non-numerical by **defining a local macro to act as a counter**. For example, in a [foreach](http://www.stata.com/help.cgi?foreach) loop with a [varlist](http://www.stata.com/help.cgi?varlist):

```
sysuse auto
_dots 0, reps(10)
foreach var of varlist price - gear_ratio {
  ...
  local i = `i'+1
  _dots `i' 0
}
```

### Counting repetitions

The number of repetitions in `rep` is not calculated by `_dots`, so I had to manually count the variables and enter the number. The number of variables  could be counted automatically with the help of the [`list` extended macro function](http://www.stata.com/manuals13/pmacrolists.pdf) `sizeof`.

Expanding the last example, we could write:

```
sysuse auto
unab myvars : price - gear_ratio
local N : list sizeof myvars
_dots 0, reps(`N')
foreach var of varlist `myvars' {
  ...
  local i = `i'+1
  _dots `i' 0
}
```

Notice that I first expanded the variable list with [`unab`](http://www.stata.com/manuals13/punab.pdf), which permits entering an abbreviated `varlist` like `price - gear_ratio` and then have Stata automatically expand the list with all variables in that range.

# Usage in while loops

Now we can think of a more sophisticated implementation in a [`while`](http://www.stata.com/help.cgi?while) loop. Let's look at Harrison's example:

```
_dots 0, title(Looping until 70 successes...)
local rep 1
local nsuccess 0
while `nsuccess' < 70 {
  local fail = uniform() < .2
  local nsuccess = `nsuccess' + (`fail' == 0)
  _dots `rep++' `fail'
}
Looping until 70 successes...
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
xx...x..x...xx...xx....x................x......... 50
.x..............x..x.x.x....x.......
```

It is useful to realize that `nsuccess` just controls the loop, but it's not related to the progress bar. So `nsuccess` is just set to zero and then will is updated with +1 with 80% probability, that is, if `fail` *doesn't* fail, which means it is equal to zero.

Now to the progress bar. The first call of `_dots` is similar to what we've seen. The second call (inside the loop) is trickier:

```stata
_dots `rep++' `fail'
```

The first argument, `rep++`, is just updating the repetitions counter. The `++` part is a [macro expansion operator](http://www.stata.com/manuals13/pmacro.pdf) which is just a shorthand for updating the local macro (it's the same as writing <code>local rep = `rep'+1</code>).

The second argument, `fail`, is the return code. In this example the local macro `fail` equals zero if there is a success, so a dot is passed to the progress bar. In case of failure, `fail` equals 1 and thus the progress bar outputs a red X for that iteration.
