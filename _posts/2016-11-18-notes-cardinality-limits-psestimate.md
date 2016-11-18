---
layout: post
title:  "Between vs within-subject design: power and sample size"
categories: metrics, stata
---

I've written a Stata program, [psestimate](/resources/psestimate), that implements an algorithm proposed by [Imbens and Rubin](http://jhr.uwpress.org/content/50/2/373) which helps to determine the first or second order polynomial of covariates to use in the  estimation of a propensity score. By its very nature this algorithm is slow and intensive in computational resources, which makes it challenging to code. In this post I share some notes on the strategies I use in `psestimate` to overcome or mitigate those challenges.

# Cardinality of covariates to try

[complete]

## Second stage

We'll explore now hoy many covariates, including their quadratic forms and two-way interactions, the program will need to check in the second stage. We'll build up from the simpler cases into a general form, so bear with me.

If only one covariate `a` was chosen, the program would only need to check `a^2` in the second stage. If covariates `a` and `b` were chosen, the program would need to check

```
a,b :    a^2 + b^2 + a*b
```

We can continue this pattern

```
a,b,c   : a^2 + b^2 + c^2 + a*b + a*c + b*c
a,b,c,d : a^2 + b^2 + c^2 + d^2 + a*b + a*c + a*d + b*c + b*d + c*d
...
```

Suppose the algorithm selected $$l$$ linear terms in the first stage. It is
