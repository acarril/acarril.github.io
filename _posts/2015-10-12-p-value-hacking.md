---
layout: post
title: $p$-value hacking
---
Whenever we do regression analysis, we know that there is the chance of getting false positives. Suppose you have $k$ outcome variables and are targeting a $p$-value of $p$. Now, is there a way to compute -ex ante- the exact probability of getting at least one false positive significant result under $p$?

This question arose during a discussion with a J-PAL colleague. Since we were talking about randomized control trials, he also noted we could assume a treatment group of size $t$ and a control group of size $c$.

But does it matter?

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

$$ \Pr(\text{At least one }p_i \leq \overline p) = 1-[1-\Pr(p_i\leq\overline p)]^k = 1-[1-F_U(\overline p)]^k,$$

which is the [cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function) (CDF) of the minimum of $k$ i.i.d. random variables.

Let's say this minimum is $p_{min}$, then the CDF of the minimum of $k$ independent $U(0,1)$ variables is

$$ F_{p_{min}}(p_{min}) = 1- [1-p_{min}]^k.$$

And so we want the probability:

$$ \Pr (p_{min}\leq \overline p) = 1-[1-p_{min}]^k. $$

So it is interesting to note that the probability of getting at least one false positive significant result under $p$ doesn't depend on the size of treatment nor control groups (in an impact evaluation setting), or even on sample size. Because $p$-values are random variables, they are uniformly distributed (0,1) regardless of sample size.*

To get an idea of some typical values of our last formula, here is a table:

![Hola](http://i60.tinypic.com/347b48h.png)

* Of course, the values of $t$ and $c$ do enter the test-statistic. For example, if we assume that the underlying data is normally distributed i.i.d., with mean $\mu$ and variance $\sigma$ for both treatment and control groups, then it can be proven we can get the $t$-statistic

$$t = \frac{\bar {X}_1 - \bar{X}_2}{s_{X_1 X_2} \cdot \sqrt{\frac{1}{n}+\frac{1}{m}}},$$

where

$$s_{X_1X_2} = \sqrt{\frac{(n-1)s_{X_1}^2+(m-1)s_{X_2}^2}{n+m}}.$$
