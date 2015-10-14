---
layout: post
title: $p$-value hacking
---
The dubious art of testing different specifications until one gets a $p$-value under .05 (or other [magic number](https://en.wikipedia.org/wiki/Magic_number_%28programming%29#Unnamed_numerical_constants)) is known as "$p$-value hacking" or simply "$p$-hacking".

Suppose there is a control group of size $m$ and a treatment group of size $n$, with $k$ outcome variables.

Assuming i.i.d. Normal characteristics we can use separate [Welch's $t$-tests](https://en.wikipedia.org/wiki/Welch%27s_t_test), which account for different variances and sample sizes. If the statistics of these tests are $w_i$ ($i=1,..., k$), the $p$-value of each one is

$$ p_i = \Pr(|w_i|\geq w(\alpha)|H_0),$$

where $H_0$ is the null hypothesis of equal means of the control and treatment groups.

The above probability can be expressed in terms of the corresponding cumulative distribution function, so $\Pr (\cdot)=1-F( \mid w_i \mid )$ . Therefore we have that

$$F(|w_i|)=1-p_i .$$

The key here is thinking of $p$-values as random variables and, because of the magic of [probability integral transform](https://en.wikipedia.org/wiki/Probability_integral_transform), we know that $(1-p_i)$ is distributes uniformly, and so we have that

$$ p_i\sim U(0,1). $$

Now we have a sample size of $k$ independent uniform distributions. The probability that at least one of them is smaller than a specific value $\overline p$ is equal to the probability that the minimum of them is lower than that threshold:

$$ \Pr(\text{At least one }p_i \leq \overline p) = 1- \Pr (\text{All }p_i > \overline p ) = 1- \prod_{i=1}^k \Pr (p_i > p^*).$$

Since all $p_i$ are identically distributed, we have that