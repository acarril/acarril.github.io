---
layout: post
title:  "Practical difficulties and limitations of <code>psestimate</code>"
categories: metrics stata
---

I've written a Stata program, [`psestimate`](/resources/psestimate), that implements an algorithm proposed by [Imbens and Rubin](http://jhr.uwpress.org/content/50/2/373) which helps to determine the first or second order polynomial of covariates to use in the  estimation of a propensity score. By its very nature this algorithm is slow and intensive in computational resources, which makes it challenging to code. In this post I share some notes on the strategies I use in `psestimate` to overcome or mitigate those challenges.

# Cardinality of covariates to try

[complete]

## Second stage

We'll explore now hoy many covariates, including their quadratic forms and two-way interactions, the program will need to check in the second stage. We'll build up from the simpler cases into a general form, so bear with me.

If only one covariate $$a$$ was chosen, the program would only need to check $$a^2$$ in the second stage. If covariates $$a$$ and $$b$$ were chosen, the program would need to check

```
a,b :    (a^2 + b^2) + (a*b)
```

We can continue this pattern

```
a,b,c   : (a^2 + b^2 + c^2) + (a*b + a*c + b*c)
a,b,c,d : (a^2 + b^2 + c^2 + d^2) + (a*b + a*c + a*d + b*c + b*d + c*d)
...
```

It should be readily apparent that for any number of linear covariates $$l$$, the number of squared terms to try in the second stage is also $$l$$, while the number of unique two-way interactions is going to be equal to $$\sum^{l-1}$$. Taken together, both simply amount to the sum over $$l$$.

Given that Stata imposes a [limit of 300 stored estimation results](http://www.stata.com/help.cgi?limits) in memory, we need this sum to be less than that limit:

$$
\sum^l = \frac{l(l+1)}{2} < 300
$$

Solving that inequality for positive values of $$l$$ tells us that $$l<24$$. This means that if the total number of linear terms chosen in the first stage is equal or greater than 24, the program is not going to be able to store all the estimates needed for the first loop in the second stage.
