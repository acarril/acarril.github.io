---
layout: post
comments: true
title:  "Deleting values from macro"
categories: stata
published: true
---

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
