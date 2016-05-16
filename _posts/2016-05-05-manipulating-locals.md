---
layout: post
comments: true
title:  "Manipulating locals"
categories: stata
published: true
---

Defining and using locals in Stata is extremely useful, but sometimes we need to go beyond just storing and reusing some values. In this post I explain advanced manipulation of locals via `macro lists`.

# Setup

### Duplicate values

We may have a local with duplicate elements stored within. For example,

```
. local fib 0 1 1 2 3 5
```

We can easily **remove duplicated elements from the local** using

```
. local fib_nodups : list uniq fib
. di "`fib_nodups'"
0 1 2 3 5
```

We could also **extract duplicated elements from the local** using

```
. local fib_dups : list dups fib
. di "`fib_dups'"
1
```

***

After defining a macro, specially inside a program, I have found that oftentimes I need to update its content by eliminating one of its values. In this post I explain how to easily do it.

# Setup

Suppose you define the contents of a local macro `vars` as

```
local vars a b c d e
```

# Solution with macro lists

Now, for some reason, I need to update the contents of `vars` by eliminating the value `c`. The easiest way to do it is using [macro lists](http://www.stata.com/manuals13/pmacrolists.pdf):

```
local not c
local vars: list vars - not
di "`vars'"
```

Cool! No need to [tokenize](http://www.stata.com/manuals13/ptokenize.pdf).
