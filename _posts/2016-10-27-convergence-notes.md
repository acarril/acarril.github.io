---
layout: post
title:  "Some notes on the convergence of maximum likelihood functions"
categories: stata
draft: true
---

We've all read the dreaded `convergence not achieved` message, punctuated by `r(430);`, after waiting for a long maximization process. These situations are most commonly encountered when estimating logit, probit or any kind of maximum-likelihood model, but in general they arise whenever you're asking it to perform iterative maximization. In this post I'll share some practical advice on how to deal with slow or non-convergent maximization processes.

### A bit of theory to understand the problem

## A bit of theory to understand the problem

# A bit of theory to understand the problem

We know that the maximization problem is

$$ L(\hat{\boldsymbol{\theta}};\boldsymbol{Z}) = \max_{\boldsymbol{t}\in\Theta} L(\boldsymbol{t};\boldsymbol{Z}) $$

which simply means we are maximizing

# References
William Gould, Jeffrey Pitblado, and Brian Poi. 2010.  *Maximum Likelihood Estimation with Stata*, Fourth Edition. Stata Press.
