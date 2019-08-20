---
layout: post
title: <code>randtreat</code> &mdash; Random treatment assignment and dealing with misfits
categories: stata econ
---

In this post I'll try to intuitively explain the **<i>misfits</i> problem**, an issue that can arise in random treatment assignment whenever the number of observations can't be divided among the treatments you want to assign (e.g. assigning two treatments *evenly* in a sample with 9 observations).
Although the basics of this problem are easy to understand, it can get more complex in stratified allocations, or when treatments are not evenly distributed (e.g. 70% control and 30% treated).
This post analyzes both simple and complex setups, and is a "friendlier" introduction to what's already discussed in depth on my [misfits paper](https://www.researchgate.net/publication/292091060_Dealing_with_misfits_in_random_treatment_assignment).

I'll use extensively my [`randtreat` Stata command](https://ideas.repec.org/c/boc/bocode/s458106.html) (introduced in said paper), which lets you handle "complex" assignments with ease and also includes algorithms to deal with misfit observations.
It can be downloaded from the SSC repository as usual:

```
ssc install randtreat, replace
```

# So what are *misfits*?

Suppose you have a sample with 10 observations and decide to randomly assign two treatments. No problem: just randomly sort the sample, divide it two and assign a different treatment status to each half. In Stata this can be done as follows:

```
// generate sample:
set obs 10
generate id = _n

// random assignment:
generate treatment = .
replace treatment = 0 if _n <= _N/2
replace treatment = 1 if _n > _N/2
```

However, **what if you had 11 observations?** There are two issues:

1. It is not evident to which group you should assign this 11th observation (a.k.a. the misfit)
2. It is not easy carry out the assignment in a way that *automatically* marks the misfit

[to be continued...]

**Note:** the misfits problem is an *assignment* problem, independent of whether that assignment is random or not. So for simplicity I'll omit the *random* part and focus on the treatment assignment.
