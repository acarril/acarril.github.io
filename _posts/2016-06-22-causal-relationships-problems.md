---
layout: post
title:  "Practical problems in causal relationships"
categories: econ
hidden: true
---

One of the fundamental endeavors of economic research is to establish and measure causal relationships from data. The "golden standard" is to do this by performing a randomized control trial, as many of my colleagues at J-PAL do. However, in many cases we have to draw conclusions from observational data.

Using observational data, we must resort to models that will (hopefully) allow us to identify the causal relationships we're investigating. The usefulness these types of models is given by their ability to identify causal relationships in spite of relevant data we leave out of them. If the data we leave out [...]

# Basic framework
Consider a regression like

$$
y = f(X) + \mu,
\tag{1}
$$

where $$y$$ is the outcome vector of interest, $$\mu$$ is a vector of unobservables, $$X$$ is a matrix of covariates and $$f(X)$$ is a vector-valued function.

In order to establish a causal relationship of $$X$$ on $$y$$, we must assume that

$$
E(\mu|X) = 0,
\tag{2}
$$

which is to say that given all the information in $$X$$, the vector of unobservables $$\mu$$ doesn't give any additional information (on average). Conversely (and importantly), this also implies that $$E(y\vert X)=g(X)$$, or that all the information to infer the causal relationship on our outcome variable $$y$$ is contained in some form by the covariates matrix $$X$$.

Without loss of generality, I will assume that $$f(X)$$ is linear from here on.

# Omitted variable bias

Suppose the true model is described by

$$
y = \beta_1 X_1 + \beta_2 X_2 + \mu,
$$

so $$E(\mu\vert X_1,X_2) = 0$$ holds (as discussed on eq. $$(2)$$, above). However, if we fail to include $$X_2$$, we would be trying to estimate

$$
y = \beta_1 X_1 + \epsilon
$$

while assuming that $$E(\epsilon\vert X_1) = 0$$.

If that assumption is true, then we have no problem. However, it will only be true if the information of $$X_2$$ is irrelevant given the inclusion of $$X_1$$, that is, $$ E(X_2 \vert X_1) = 0$$.

To see this, it is useful to write

$$
\begin{align}
E(\mu \vert X_1) &= E(X_2\beta_2 + \mu \vert X_1) \\
&= E(X_2 \vert X_1)\beta_2 + E(\mu \vert X_1) \\
&= E(X_2 \vert X_1)\beta_2.
\end{align}
$$

So we'll have omitted variable bias if $$E(\epsilon \vert X_1) \neq 0$$, which stems from the relationship between the included covariates ($$X_1$$) and the omitted covariates ($$X_2$$).

### Stata simulation

I'll use simulated data to exemplify the omitted variable bias, starting with a basic setup:

```stata
set seed 2206
set obs 10000
local rho = .5
```

Local macro `rho` (or $$\rho$$) is the correlation coefficient. With it, we can create correlated covariates and use them to generate the dependent variable:

```stata
gen X1 = rnormal()
gen X2 = X1*`rho' + rnormal()
gen y = 1 + 3*X1 - 2*X2 + rnormal()
```

Notice that in this artificial dataset we have defined $$\beta_1 = 3$$ and $$\beta_2 = -2$$. However, if we estimate our model *without* $$X_2$$, we get the following output:

```stata
. regress y X1, vce(robust)

Linear regression                               Number of obs     =     10,000
                                                F(1, 9998)        =    8145.75
                                                Prob > F          =     0.0000
                                                R-squared         =     0.4444
                                                Root MSE          =     2.2332

------------------------------------------------------------------------------
             |               Robust
           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
          X1 |   2.005593   .0222217    90.25   0.000     1.962034    2.049152
       _cons |   1.016461   .0223332    45.51   0.000     .9726832    1.060239
------------------------------------------------------------------------------
```

The estimated coefficient for $$X_1$$ is not only wrong, but statistically significant! This can make omitted variable bias very misleading.

# Endogeneity

We'll have endogeneity whenever a covariate is correlated with the error term. Several situations can result in endogeneity, with the two most common being

1. Existance of a causality loop between dependant and independant variables.
2. Existance of an uncontrolled covariate affecting both dependant and independat variables.

Using our defined framework, the $$X_2$$ covariate will be endogenous if we estimate

$$
y = X_1 \beta_1 + X_2 \beta_2 + \mu
$$

assuming that

$$
\begin{align}
E(\mu \vert X_1) = & 0 \\
E(\mu \vert X_2) \neq & 0.
\end{align}
$$

```stata
clear
capture set seed 111
quietly set obs 20000

// Generate correlated unobservable variables
matrix C  = (1, .5\ .5, 1)
drawnorm e v, corr(C)

// Generate exogenous covariate
generate x1  = rnormal()

// Generate endogenous covariate correlated with unobservable
generate x2  = v


// Generate model
generate y = 1 - x1 + x2 + e
```
