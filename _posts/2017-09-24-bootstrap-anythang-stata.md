---
layout: post
title: "Bootstrap anythang in Stata"
draft: true
---

![](https://i.pinimg.com/736x/44/07/2b/44072bf336a3f893f5c9889bc2d01eb3--bootstrap-components-business-inspiration.jpg)

If I could bring only one statistical technique to a deserted island, it would probably be the bootstrap. Less than a year ago I made [a post explaining what is it and how does it work](/posts/bootstrapping). In this post I want to share methods to create your own bootstrap-anythang program in Stata.

### What is the bootstrap, tl;dr version

For every estimate we compute (eg. the sample mean), we also need a measure of its precision, which is given by the standard error. For something like the sample mean it is relatively easy to derive an expression for the standard error. However, **with a non-standard estimator it may be too difficult to come up with an analytical expression for its standard error**. The bootstrap is basically a resampling method in which we compute our estimator several times, each time with a different subsample of our full sample. We then use the sample standard deviation of these estimates as an estimate of the standard error.

<!--more-->

