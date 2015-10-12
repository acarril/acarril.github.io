---
layout: post
title: $p$-value hacking
---
The dubious art of testing different specifications until one gets a $p$-value under .05 (or other [magic number](https://en.wikipedia.org/wiki/Magic_number_%28programming%29#Unnamed_numerical_constants)) is known as "$p$-value hacking" or simply "$p$-hacking".

Suppose there is a control group of size $m$ and a treatment group of size $n$, with $k$ outcome variables.

Assuming i.i.d. Normal characteristics we can use separate [Welch's $t$-tests](https://en.wikipedia.org/wiki/Welch%27s_t_test), which account for different variances and sample sizes. If the statistics of these tests are $w_i$ ($i=1,..., k$), the $p$-value of each one is

$$ p_i = \Pr(|w_i|\geq w(\alpha)|H_0),$$
where $H_0$ is the null hypothesis of equal means of the control and treatment groups.

The above probability can be expressed in terms of the corresponding cumulative distribution function, so $\Pr(\cdot)=1-F(|w_i|)$. Therefore we have that

$$ F(|w_i|)=1-p_i .$$