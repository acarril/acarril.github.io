---
layout: post
title:  "Some notes on the convergence of maximum likelihood functions"
categories: stata
hidden: true
---

We've all read the dreaded `convergence not achieved` message, punctuated by `r(430);`, after waiting for a long maximization process. These situations are most commonly encountered when estimating logit, probit or any kind of maximum-likelihood model, but in general they arise whenever you're asking it to perform iterative maximization. In this post I'll share some practical advice on how to deal with slow or non-convergent maximization processes.

# A bit of intuition on maximum likelihood

You have some data and are willing (?) to assume that it is generated from some distribution. Say you assume it comes from a normal (Gaussian) distribution. That's fine, but there are infinitely many possible parameters (i.e. means, variances) that "source" distribution may have:

![Possible normal distributions](/files/convergence_notes-gaussian_dists.png "Which distribution is producing my data?")

The idea behind MLE is to pick the distribution that is "most consistent" with the data. That is, MLE finds the most likely function that explains the observed data.

<!--more-->

## How can you choose parameters which are "most consistent" with the data?

Say you've got a variable `y=4,1,10`. The most consistent parameters would be to choose a mean equal to 5 and a variance of 14. Yes, some other Gaussian distribution may have produced those values in `y`, but the key is that the probability of getting those particular values of is maximized with the chosen mean and variance.

In a regression framework the mean is simply a linear function of the data. Consider the same vector `y` as before and a new variable `x=1,-1,3`. The mean is the fitted regression model $$X' \hat\beta$$, with $$\hat\beta=[2.75, 2.25]$$. You can easily check this in Stata:

```
set obs 3

gen y = .
replace y = 4 in 1
replace y = 1 in 2
replace y = 10 in 3

gen x = .
replace x = 1 in 1
replace x = -1 in 2
replace x = 3 in 3

reg y x
```

## The likelihood function maximization

Let's now expand our example to something a bit more sophisticated. The basic idea still is that we have some points in `x` and `y`, and we want to know the parameters $$\mu$$ and $$\sigma$$ that most likely fit the data. We're going to start by cheating and generating the data with known parameters:

```
set obs 200

gen x = runiform(1,10)
gen y = `beta'*x + rnormal(0,`sigma2')
```

continues...

![Plot of likelihood function](/files/mle_max_plot.png "There is a maximum somewhere")

# A bit of math
We know that the maximization problem is

$$ L(\hat{\boldsymbol{\theta}};\boldsymbol{Z}) = \max_{\boldsymbol{t}\in\Theta} L(\boldsymbol{t};\boldsymbol{Z}) $$

which simply means we are maximizing ...

# References
William Gould, Jeffrey Pitblado, and Brian Poi. 2010.  *Maximum Likelihood Estimation with Stata*, Fourth Edition. Stata Press.
