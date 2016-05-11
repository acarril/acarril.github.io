---
layout: post
comments: true
title: psestimate -- Estimate the propensity score proposed by Imbens and Rubin (2015)
hidden: true
permalink: /resources/psestimate
---

Imbens and Rubin (2015) proposed a procedure for estimating the propensity score, with an algorithm for selecting the underlying function further outlined by Imbens (2015). The **psestimate** command implements that algorithm and estimates the propensity score.

# Some context

I've been working for a few months now in an project of professors [Dina Pomeranz](http://www.hbs.edu/faculty/Pages/profile.aspx?facId=603214) and [Gabriel Zucman](http://gabriel-zucman.eu/). They're analyzing a law reform on multinational transfer pricing enacted in 2011 in Chile and how it impacted transfers made by affiliates of multinationals.

# References
Imbens, Guido W. and Donald B. Rubin. 2015.  *Causal Inference in Statistics, Social,
        and Biomedical Sciences*.  New York: Cambridge University Press.

Imbens, Guido W. 2015.  "Matching Methods in Practice: Three Examples".  *Journal of
        Human Resources* 50(2): 373-419.
