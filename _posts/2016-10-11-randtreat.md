---
layout: post
title: randtreat &mdash; Random treatment assignment and dealing with misfits
categories: stata econ
permalink: /resources/randtreat
---

In this post I'll try to intuitively explain the **"misfits" problem**, an issue that can arise in random treatment assignment whenever the number of observations is can't be divided by the number of treatments you want to assign (e.g. assign two treatments in a sample with 9 observations). Although the misfits problem basic form is easy to understand, it can get more complex in stratified allocations, or when treatments are not evenly distributed (e.g. 70% control and 30% treated). I'll use extensively my **`randtreat` Stata command**, which lets you handle "complex" assignments with ease and also includes algorithms to assign misfit observations.

# Misfits

**Note:** the misfits problem is an *assignment* problem, independent of whether that assignment is random or not. So for simplicity I'll omit the *random* part and focus on the treatment assignment.

Suppose you have a sample with 10 observations and decide to assign two treatments. This is fairly easy, and can be done as follows:

```
set obs 10
generate treatment = .
replace treatment = 0 if _n <= _N/2
replace treatment = 1 if _n > _N/2
```
