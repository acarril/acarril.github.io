---
layout: post
title:  What exactly is the confidence interval?
categories: metrics
---

Interpreting a simple 95% [confidence interval](https://en.wikipedia.org/wiki/Confidence_interval) (CI) is trickier than it seems. Many people think of the interval as a range that contains the mean with a probability of 95%, but that's (kind of) wrong.

From a [frequentist](https://en.wikipedia.org/wiki/Frequentist_inference) standpoint, the definition of CI refers to a fictitious population of experiments, rather than about the particular data you actually have. The CI answers the following question:

> What is the interval that will bracket the true value of the parameter in $$(100 \cdot p)\% $$ of the instances of an experiment that is carried out a large number of times?

Suppose the parameter of interest is $\theta$ and your data is $D$. Let $$x_1$$ and $$x_2$$ be two points drain independently from the following distribution:

$$
p(x \vert \theta) =
\begin{cases}
1/2 \\
1/2
\end{cases}
$$
