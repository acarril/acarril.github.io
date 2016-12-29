---
layout: post
title:  What exactly is the confidence interval?
categories: metrics
---

Interpreting a simple 95% [confidence interval](https://en.wikipedia.org/wiki/Confidence_interval) (CI) is trickier than it seems. Many people think of the interval as a range that contains the mean with a probability of 95%, but that's (kind of) wrong.

From a [frequentist](https://en.wikipedia.org/wiki/Frequentist_inference) standpoint, the definition of CI refers to a fictitious population of experiments, rather than about the particular data you actually have. The CI answers the following question:

> *What is the interval that will bracket the true value of the parameter in $$(100 \cdot p)\% $$ of the instances of an experiment that is carried out a large number of times?*

Suppose the parameter of interest is $$\theta$$ and your data is $$D$$. Let $$x_1$$ and $$x_2$$ be two points drawn independently from the following distribution:

$$
p(x \vert \theta) =
\begin{cases}
1/2 &\text{ if } x=\theta \\
1/2 &\text{ if } x=\theta + 1 \\
0 &\text{ otherwise}
\end{cases}
$$

Suppose $$\theta = 0$$. If that is the case, you can expect to draw the points $$0$$ or $$1$$ with equal probability, by definition of $$p(x \vert \theta)$$. So we could expect to see the datasets $$(0,0)$$, $$(0,1)$$, $$(1,0)$$ and $$(1,1)$$ with equal probability of $$1/4$$.

Now consider the confidence interval
$$
[ \theta_\min(D), \theta_\max(D) ] = [ \min(x_1,x_2), \max(x_1,x_2) ],
$$
which is a 75% CI interval. To see why, notice that for each dataset we may observe we can construct the CI and check if it contains $$\theta$$:

- $$D=(0,0) \iif CI=[0,0]$$, so the CI contains $$\theta$$.
- $$D=(0,1) \iif CI=[0,1]$$, so the CI contains $$\theta$$.
- $$D=(1,0) \iif CI=[0,1]$$, so the CI contains $$\theta$$.
- $$D=(1,1) \iif CI=[1,1]$$, so the CI *doesn't* contain $$\theta$$.

So we see that in general if we resample our data many times, the CI constructed  would contain the true value of the parameter 75% of the times.

# The credible interval

Under a Bayesian framework, the [credible interval](https://en.wikipedia.org/wiki/Credible_interval) answers the question

> *What is the interval that will bracket the true value of the parameter with probability $$p$$ in the data I have?*

So we need to redefine our definition of what a probability is, using the Bayesian definition. Consider $$D=(5,5)$$. If we construct a 75% CI as before, we'd have $$CI=[5,5]$$ and this would mean that
