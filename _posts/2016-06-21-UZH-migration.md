---
layout: post
comments: true
title: Quick guide for UZH data migration
hidden: true
categories: stata econ
permalink: /resources/UZH-migration
---

This is a quick guide for securely migrating your project data to the new servers at [Universität Zürich (UZH)](http://www.uzh.ch/en.html).

# Level 3 security requirements

In order to store Level 3 security level according to [Harvard guidelines](http://policy.security.harvard.edu/level-3), the computer that holds the data

1. Must be **secured in a way that only the appropriate people can access it**. For computers, this means that it is secured with a username and password which is not shared and that a password protected screensaver engages when the device is not in use.

2. Must be **encrypted**.

3. Must be running **anti-virus and firewall software**, and this software must be kept up to date.

4. Must have it's operating system and applications **kept up to date**.

<img src="https://i.imgflip.com/167a47.jpg" alt="Say what" height="300" width="300">

# The Imbens-Rubin propensity score

The proposed estimator for the propensity score, $$e(x)$$, is based on a logistic model and estimated by maximum likelihood. The estimated propensity score is

$$
\hat{e}(x\vert\boldsymbol{W},\boldsymbol{X}) = \frac{\exp{(h(x)'\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}))}}{1+\exp{(h(x)'\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}))}},
\tag{1}
$$

where $$\boldsymbol{W}$$ indicates treatment(s), $$\boldsymbol{X}$$ are covariates, $$h(x)$$ is the function of covariates to include and $$\gamma$$ is just a parameter vector for those variables, estimated by

$$
\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}) = \arg \underset{\gamma}{\max} L(\gamma \vert \boldsymbol{W},\boldsymbol{X}).
\tag{2}
$$

<img src="https://s-media-cache-ak0.pinimg.com/736x/07/0f/d2/070fd27702c5aef90ed0e0bb01c865dd.jpg" alt="Say what" height="150" width="150">

Equation $$(1)$$ is the [inverse-logit](https://en.wikipedia.org/wiki/Logit) or logistic distribution used to estimate the propensity score, which generically has the following form:

$$
\text{logit}^{-1} (\alpha) = \frac{\exp{\alpha}}{1+\exp{\alpha}}.
$$

So in eq. $$(1)$$, $$\alpha$$ is comprised of $$h(x)$$, which is a function of covariates with linear (and possibly higher) order terms, and $$\gamma$$, the vector of unknown parameters. Equation $$(2)$$ just tells us that we're going to estimate those parameters by [maximum likelihood](https://en.wikipedia.org/wiki/Maximum_likelihood).

**So to get the proposed propensity score we just have to choose $$h(x)$$, estimate its coefficients with a logit model by maximum likelihood and use those coefficients to predict the probability of being treated.**

### Selecting $$h(x)$$

[Imbens (2015)](http://jhr.uwpress.org/content/50/2/373.refs) has an appendix with the algorithm for defining $$h(x)$$. Some notation:

- $$X_b$$ are basic covariates included explicitely in $$h(x)$$, because you think they are relevant regardless of what the algorithm selects. It can be empty.
- $$X_l$$ and $$X_q$$ are the selected linear and quadratic terms, respectively. Obviously, they are empty at the beginning.
- $$C_l$$ and $$C_q$$ are the selected thresholds for selecting terms to the linear and quadratic parts of the model, respectively.

I paraphrase Imben and Rubin's algorithm below, but I've compressed it to only 6 steps. I also added a running example with relevant Stata commands, hoping it makes the implementation clearer.

All estimations are logit regressions estimated by maximum likelihood, where the dependent variable is the treatment indicator, `treatvar` in this example. Also, I'll assume a dataset with ten covariates, creatively named `var1`, `var2`, ..., `var10`.

1. Estimate base model with basic covariates $$ X_b $$. If no covariates are chosen for $$ X_b $$, then this is just the model with the intercept. Save this estimation result for comparison. Notice that I arbitrarily chose to include `var1` and `var2` in the base model, so they're in $$X_b$$.

        logit treatvar var1 var2
        estimates store base

2. Estimate one additional model for every covariate in $$X$$ not included in $$X_b$$ (i.e. `var3`, `var4`, ..., `var10`). Each of these estimations includes the base covariates plus *one* additional covariate. For each estimated model perform a [likelihood ratio test](http://www.stata.com/manuals13/rlrtest.pdf) for the null hypothesis that the included covariate's coefficient is equal to zero. Results are stored in local macros.

        foreach v of varlist var3-var10 {
          logit treatvar var1 var2 `v'
          lrtest base .
          local llrt_`v' = `r(chi2)'
        }

3. If the largest LLR result (stored now in <code>llrt_`v'</code>) is equal or larger than $$C_l$$, then the covariate associated with it is added to the linear part of the model and Step 2 is repeated, now including this covariate. This process is looped until the maximum LRT is lower than $$C_l$$ (i.e. there are no covariates that would improve the model) or you run out of covariates to add.

4. By now the linear part of the model is selected. This includes our basic covariates $$X_b$$ (i.e. `var1` and `var2`) plus any covariates selected by the algorithm for the linear part $$X_l$$ (suppose it selected `var5` and `var8`). For the selection of quadratic (or "second order") terms the algorithm uses only covariates in $$X_b$$ and $$X_l$$, now testing the inclusion of their interactions or quadratic forms. In terms of our example, that means we have to test for the inclusion of `(var1)^2`, `var1 * var2`, `var1 * var5`, etc.

5. Estimate one model for every second order candidate. Each estimation includes terms in $$X_b$$ and $$X_l$$ plus *one* additional quadratic or interactive covariate. For each estimated model perform a [likelihood ratio test](http://www.stata.com/manuals13/rlrtest.pdf) for the null hypothesis that the included covariate's coefficient is equal to zero. Results are stored in local macros, analogue to Step 2.

6. If the largest LLR result of this additional second order terms is equal or larger than $$C_q$$, then the term associated with it is added to the quadratic part of the model and Step 5 is repeated, now including this term. This process is looped until the maximum LRT is lower than $$C_q$$ (i.e. there are no second order terms that would improve the model) or you run out of terms to add.

# Some context

I've been working for a few months now in an project of professors [Dina Pomeranz](http://www.hbs.edu/faculty/Pages/profile.aspx?facId=603214) and [Gabriel Zucman](http://gabriel-zucman.eu/). They're analyzing a law reform on multinational transfer pricing enacted in 2011 in Chile and how it impacted transfers made by affiliates of multinationals.

# References
Imbens, Guido W. and Donald B. Rubin. 2015.  *Causal Inference in Statistics, Social,
        and Biomedical Sciences*.  New York: Cambridge University Press.

Imbens, Guido W. 2015.  "Matching Methods in Practice: Three Examples".  *Journal of
        Human Resources* 50(2): 373-419.

<!-- http://www.bristol.ac.uk/media-library/sites/cmm/migrated/documents/prop-scores.pdf -->
