---
layout: post
title:  What exactly is the confidence interval?
categories: metrics
---

Interpreting a simple 95% [confidence interval](https://en.wikipedia.org/wiki/Confidence_interval) (CI) is trickier than it seems. Many people think of the interval as a range that contains the parameter of interest (e.g. the mean) with a probability of 95%, but that's (kind of) wrong.

From a [frequentist](https://en.wikipedia.org/wiki/Frequentist_inference) standpoint, the definition of confidence interval refers to a fictitious population of experiments, rather than about the particular data you actually have. It answers the following question:

> *What is the interval that will bracket the true value of the parameter in $$(100 \cdot p)\% $$ of the instances of an experiment that is carried out a large number of times?*

<!--more-->

Suppose the parameter of interest is $$\theta$$ and your data is $$D$$. Let $$x_1$$ and $$x_2$$ be two points drawn independently from the following distribution:

$$
p(x \vert \theta) =
\begin{cases}
1/2 &\text{ if } x=\theta \\
1/2 &\text{ if } x=\theta + 1 \\
0 &\text{ otherwise.}
\end{cases}
$$

Suppose $$\theta = 0$$. If that is the case, you can expect to draw the points $$0$$ or $$1$$ with equal probability, by definition of $$p(x \vert \theta)$$. So we could expect to see the datasets $$(0,0)$$, $$(0,1)$$, $$(1,0)$$ and $$(1,1)$$ each with probability $$1/4$$.

Now consider the confidence interval

$$
CI = [ \theta_\min(D), \theta_\max(D) ] = [ \min(x_1,x_2), \max(x_1,x_2) ],
$$

which is a 75% CI interval. To see why, notice that for each dataset we may observe we can construct the confidence interval and check if it contains $$\theta$$:

- $$D=(0,0) \implies CI=[0,0]$$, so the CI contains $$\theta$$.
- $$D=(0,1) \implies CI=[0,1]$$, so the CI contains $$\theta$$.
- $$D=(1,0) \implies CI=[0,1]$$, so the CI contains $$\theta$$.
- $$D=(1,1) \implies CI=[1,1]$$, so the CI *doesn't* contain $$\theta$$.

So if we resample our data many times, the constructed confidence interval will contain the true value of the parameter 75% of the times.

### The credible interval

Under a Bayesian framework, the [credible interval](https://en.wikipedia.org/wiki/Credible_interval) answers the question

> *What is the interval that will bracket the true value of the parameter with probability $$p$$ in the data I have?*

This is what sometimes people tend to confuse with the frequentist *confidence* interval.

To understand their difference, say we observe $$D=(1,1)$$, but we don't know if $$\theta$$ is equal to $$0$$ or $$1$$. We already know that our 75% convidence interval is [1,1]. However, from a Bayesian point of view we say that there is no reason to believe that $$1$$ is any more likely than $$0$$ as the true parameter, so the *a posteriori probability* is $$p(\theta=0 \vert D) = p(\theta=1 \vert D) = 1/2$$. **So our 75% confidence interval is clearly not a 75% credible interval as there is only a 50% probability that such interval contains the true value of $$\theta$$, *given what we can infer about $$\theta$$ from the observed data*.**

In general, the **frequentist approach** is to assume that the world is one way (i.e. a parameter has one particular true value) and then try to conduct experiments whose conclusion will be correct with at least some minimum probability. So the way a frequentist expresses his uncertainty regarding those conclusions is through the confidence interval, which is a range of values designed to include the true value of the parameter with some minimum probability (e.g. 75%). In other words, the interval is defined in such a way that out of 100 experiments, at least 75 of their corresponding confidence intervals include the true value of the parameter.

The **Bayesian approach** is to think that the parameter's value is fixed but chosen from a probability distribution, which is refered as the *prior probability distribution*. The prior migth be known (e.g. trying to estimate average score of a standardized math test of a sample and you already have overall score distribution of the population from the education ministry), or it may be assumed. So you collect your data and calculate the probability of the parameter *given the observed data* (this is similar to what I did in a [previous post](/posts/probability-likelihood)). This probability distribution is *a posteriori*, and a Bayesian would summarize his uncertainty by giving a range of values of this distribution that includes 75% of the probability, that is, the 75% credible interval.

Evidently both intervals don't always coincide, as we have seen.
