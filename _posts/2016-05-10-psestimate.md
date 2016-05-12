---
layout: post
comments: true
title: psestimate &mdash; Estimate the propensity score proposed by Imbens and Rubin (2015)
hidden: true
permalink: /resources/psestimate
---

[Imbens and Rubin (2015)](http://www.cambridge.org/zw/academic/subjects/statistics-probability/statistical-theory-and-methods/causal-inference-statistics-social-and-biomedical-sciences-introduction) proposed a procedure for estimating the propensity score, with an algorithm for selecting the covariates function further outlined by [Imbens (2015)](http://jhr.uwpress.org/content/50/2/373.refs). I've written the **psestimate** command, which implements that algorithm and estimates the propensity score in Stata.

# Propensity score estimation

In order to estimate the propensity scores, two choices have to be made:

1. **Functional form**, which corresponds to the discrete choice model selected. Usually probit or logit models are used.
2. **Covariates to include** in the propensity score model.

In **psestimate**, the functional form is a [logit model](https://en.wikipedia.org/wiki/Logistic_regression) and the covariates are included based on the algorithm proposed by [Imbens and Rubin (2015)](http://www.cambridge.org/zw/academic/subjects/statistics-probability/statistical-theory-and-methods/causal-inference-statistics-social-and-biomedical-sciences-introduction).

# The Imbens-Rubin propensity score

The proposed estimator for the propensity score, $$e(x)$$, is based on a logistic model and estimated by maximum likelihood. The estimated propensity score is

$$
\hat{e}(x|\boldsymbol{W},\boldsymbol{X}) = \frac{\exp{(h(x)'\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}))}}{1+\exp{(h(x)'\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}))}},
\tag{1}
$$

where $$\boldsymbol{W}$$ indicates treatment(s), $$\boldsymbol{X}$$ are covariates, $$h(x)$$ is the function of covariates to include and $$\gamma$$ is just a parameter vector for those variables, estimated by

$$
\hat{\gamma}_{ml}(\boldsymbol{W},\boldsymbol{X}) = \arg \underset{\gamma}{\max} L(\gamma | \boldsymbol{W},\boldsymbol{X}).
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
- $$K_l$$ and $$K_q$$ are the selected linear and quadratic terms, respectively. Obviously, they are empty at the beginning.

I paraphrase the algorithm below, adding the relevant Stata commands. All estimations are logit regressions estimated by maximum likelihood, where the dependent variable is the treatment indicator, `treatvar` in this example.

1. Estimate base model with basic covariates $$X_b$$. If no covariates are chosen for $$X_b$$, then this is just the model with the intercept. Save this estimation results for comparison.
<pre class="sh_stata">
logit treatvar [K_b]
estimates store base
</pre>
2. Estimate one additional model for every covariate in $$X$$ not included in $$X_b$$. Eeach of this estimations includes the base covariates plus the additional covariate. For each estimated model perform a [likelihood ratio test](http://www.stata.com/manuals13/rlrtest.pdf) against the

# Some context

I've been working for a few months now in an project of professors [Dina Pomeranz](http://www.hbs.edu/faculty/Pages/profile.aspx?facId=603214) and [Gabriel Zucman](http://gabriel-zucman.eu/). They're analyzing a law reform on multinational transfer pricing enacted in 2011 in Chile and how it impacted transfers made by affiliates of multinationals.

# References
Imbens, Guido W. and Donald B. Rubin. 2015.  *Causal Inference in Statistics, Social,
        and Biomedical Sciences*.  New York: Cambridge University Press.

Imbens, Guido W. 2015.  "Matching Methods in Practice: Three Examples".  *Journal of
        Human Resources* 50(2): 373-419.

<!-- http://www.bristol.ac.uk/media-library/sites/cmm/migrated/documents/prop-scores.pdf -->
