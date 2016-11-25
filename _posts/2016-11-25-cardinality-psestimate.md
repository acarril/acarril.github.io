---
layout: post
title:  "Understanding the cardinality behind <code>psestimate</code>"
categories: metrics stata
hidden: true
---

I've written a Stata program, [`psestimate`](/resources/psestimate), that implements an algorithm proposed by [Imbens and Rubin](http://jhr.uwpress.org/content/50/2/373) which helps to determine the first or second order polynomial of covariates to use in the  estimation of a propensity score. By its very nature this algorithm is slow and intensive in computational resources, which makes it challenging to code. In this post I share some notes on the strategies I use in `psestimate` to overcome or mitigate those challenges.

# Cardinality of covariates to try

For this post I'll use the **LaLonde data** (LaLonde, 1986), focusing on the Dehejia-Wahba sample that can be downloaded [here](http://economics.mit.edu/faculty/angrist/data1/mhe/dehejia) (the filename is nswre74.dta). This ancillary file is also included with `psestimate`.

As a running example, we'll use `psestimate` to find the polynomial of covariates that better predict the treatment variable (`treat`). We'll include the education variable `ed` as a baseline term, which means the algorithm is going to automatically include it in the base model. Additionally, we'll specify that the candidate variables for the program are age, and dummies for being black, hispanic and not having a degree. All this can be done as follows:

```
. psestimate treat ed, totry(age black hisp nodeg)
```

This means that the base model to fit is `logit treat ed`.

## First stage (linear terms)

In the first stage `psestimate` will choose other linear terms to include in the base model. This will be done in a stepwise process with several iterations. In the first iteration, the program will choose among four variables specified in `totry()`. To do this, it will first run the base logit model (`logit treat ed`) and then it will fit 4 models:

```
logit treat ed age
logit treat ed black
logit treat ed hisp
logit treat ed nodeg
```

After each of these estimations, it will perform a likelihood ratio test against the base model.
Whichever of these 4 models yields the highest LR test statistic indicates which covariate is chosen, unless none of these statistics is higher than the threshold established in `clin()`.

In general, if the number of covariates to try is $$c=1,\ldots,C$$, then `psestimate` could fit as much as $$\sum^C$$ logits for the linear part of the specification.

So in our example with 4 candidates, up to $$\sum_{c=1}^4 = 10 $$ logits could be fitted. We see this in the first part of the output:

```
. psestimate treat ed, totry(age black hisp nodeg)
Selecting first order covariates... (10)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
...s..s..
Selected first order covariates are: nodeg hisp
```

Out of the 4 candidate variables, only `nodeg` and `hisp` were chosen, after fitting 9 logit models. ¿Why not 10? Because once `nodeg` and `hisp` were included in the base model (after 7 iterations), neither the inclusion of `age` nor `black` improved upon the LR test statistic, so no further models needed to be tested.

## Second stage (quadratic terms)

The second stage demands a bit more attention, because the number of terms to try is not immediately obvious.

### Number of squared terms and two-way interactions

We'll explore first hoy many terms, including quadratic forms and two-way interactions, the program will need to check in the second stage. If only one covariate $$a$$ was chosen, the program would only need to check $$a^2$$ in the second stage. If covariates $$a$$ and $$b$$ were chosen, the program would need to check

```
a,b :    (a^2 + b^2) + (a*b)
```

We can continue this pattern

```
a,b,c   : (a^2 + b^2 + c^2) + (a*b + a*c + b*c)
a,b,c,d : (a^2 + b^2 + c^2 + d^2) + (a*b + a*c + a*d + b*c + b*d + c*d)
...
```

Let the number of chosen covariates for the first stage (including baseline covariates) be indexed by $$l=1,\ldots,L$$.
Then it should be readily apparent that for any number $$L$$, the number of squared terms to try in the second stage is also $$L$$, while the number of unique two-way interactions is going to be equal to $$\sum^{L-1}$$. Taken together, both simply amount to the sum over $$L$$.

### Number of iterations in the second stage



# References

LaLonde, R. J. (1986). Evaluating the Econometric Evaluations of Training Programs with Experimental Data. The American Economic Review, 76(4), 604–620.
