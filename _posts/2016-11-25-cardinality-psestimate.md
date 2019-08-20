---
layout: post
title:  "Understanding the cardinality of <code>psestimate</code>"
categories: metrics stata
---

I've written a Stata program, [`psestimate`](/resources/psestimate), that implements an algorithm proposed by [Imbens and Rubin](http://jhr.uwpress.org/content/50/2/373) which helps to determine the first or second order polynomial of covariates to use in the  estimation of a propensity score. By its very nature this algorithm is slow and intensive in computational resources, which makes it slow to run. In this post I go over the number of models the program needs to fit, given some initial parameters.

This post complements the "main explanation" of `psestimate`, which can be found [here](/resources/psestimate). If you're not familiar with the command, I suggest you read that page first or download it from SSC and read its help file. Of course, Imbens and Rubin's (2015) original article is also recommended.

<!--more-->

# Dataset and base setup

For this post we'll use the **LaLonde data** (LaLonde, 1986), focusing on the Dehejia-Wahba sample that can be downloaded [here](http://economics.mit.edu/faculty/angrist/data1/mhe/dehejia) (the filename is nswre74.dta). This dataset is also included with `psestimate` as an ancillary file.

As a running example, we'll use `psestimate` to find the polynomial of covariates that better predict the treatment variable (`treat`). We'll include the education variable `ed` as a **baseline term**, which means the algorithm is going to automatically include it in the base model. Additionally, we'll specify that the **candidate variables** for the program are age, and dummies for being black, hispanic and not having a degree. All this can be done as follows:

```
. psestimate treat ed, totry(age black hisp nodeg)
```

This means that the base model first fitted is `logit treat ed`.

# 1. First stage (linear terms)

In the first stage the program will attempt to choose *additional* linear terms to include in the base model. This will be done in a stepwise process with several iterations. In the first iteration, the program will choose among four variables specified in `totry()`. To do this, it will first run the base logit model (`logit treat ed`) and then it will fit 4 models:

```
logit treat ed age
logit treat ed black
logit treat ed hisp
logit treat ed nodeg
```

After each of these estimations, it will perform a likelihood ratio test against the base model.
Whichever of these 4 models yields the highest LR test statistic indicates which covariate is chosen, unless none of these statistics is higher than the threshold established in `clin()`.

After the first iteration (and assuming one term was chosen), the program will add the chosen term to the base model and then fit one additional logit model for each of the remaining covariates. So if `nodeg` was chosen, the base model will now be `logit treat ed nodeg` in this iteration the program will fit

```
logit treat ed nodeg age
logit treat ed nodeg black
logit treat ed nodeg hisp
```

I hope you see the pattern. In general, if the number of covariates to try is $$C$$, then the program could theoretically fit as much as $$\sum^C$$ logits for the first stage. In our example with 4 candidates, this means up to 10 logits could be fitted. We can see this in the first part of the output:

```
. psestimate treat ed, totry(age black hisp nodeg)
Selecting first order covariates... (10)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
...s..s..
Selected first order covariates are: nodeg hisp
```

At the end, we see that out of the 4 candidate variables only `nodeg` and `hisp` were chosen, after fitting 9 logit models. ¿Why not 10? Because once `nodeg` and `hisp` were included in the base model (after two full iterations, fitting 7 logits), neither the inclusion of `age` nor `black` improved upon the LR test statistic, so no further models needed to be tested.

# 2. Second stage (quadratic terms)

The second stage demands a bit more attention, because the number of terms to try is not immediately obvious.
We'll explore first hoy many terms, including quadratic forms and two-way interactions, the program will need to check in the second stage.

### Number of squared terms and two-way interactions

If only one covariate $$a$$ was chosen, the program would only need to check $$a^2$$ in the second stage. If covariates $$a$$ and $$b$$ were chosen, the program would need to check

```
a,b :    (a^2 + b^2) + (a*b)
```

We can continue this pattern

```
a,b,c   : (a^2, b^2, c^2), (a*b, a*c, b*c)
a,b,c,d : (a^2, b^2, c^2, d^2), (a*b, a*c, a*d, b*c, b*d, c*d)
...
```

In general, if the number of linear terms (including baseline covariates) is $$L$$, it should be readily apparent that the number of squared terms to try in the second stage is also $$L$$, while the number of unique two-way interactions is going to be equal to $$\sum^{L-1}$$. Taken together, both simply amount to the sum over $$L$$.

So if we let $$Q$$ be the total number of second order terms to try, we have that

$$
Q = \sum_{l=1}^L l = \frac{L(L+1)}{2}.
$$

In our example we know that $$L=3$$ (`ed`, `nodeg`, `hisp`), so the total number of second order terms to try $$Q$$ is 6.

### Number of iterations in the second stage

The number of logit models to fit in the second stage is analogous to those of the first stage. However, we need to take into account the actual number of terms to try, $$Q$$, which we know is 6. The actual terms are

```
ed^2, nodeg^2, hisp^2, ed*nodeg, ed*hisp, nodeg*hisp
```

In this stage, the theoretical maximum number of logits the program is going to estimate is equal to the sum over $$Q$$, which is 21. Again, we can see this in the second part of the output:

```
. psestimate treat ed, totry(age black hisp nodeg)
Selecting first order covariates... (10)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
...s..s..
Selected first order covariates are: nodeg hisp
Selecting second order covariates... (21)
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
.....s.....
Selected second order covariates are: c.nodeg#c.ed
Final model is: ed nodeg hisp c.nodeg#c.ed
```

In the first iteration (6 logits), the program selected the term `c.nodeg#c.ed`. After the second iteration (5 logits), no other quadratic term improved the fit, so the program halts.

# References

Imbens, Guido W. 2015. “Matching Methods in Practice: Three Examples.” *Journal of Human Resources* 50 (2): 373–419.

LaLonde, Robert J. 1986. “Evaluating the Econometric Evaluations of Training Programs with Experimental Data.” *The American Economic Review* 76 (4): 604–20.
