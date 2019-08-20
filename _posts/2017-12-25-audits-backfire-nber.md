---
layout: post
title: NBER working paper with <code>rddsga</code> application is out in the wild
---

![](assets/img/acme-coyote.jpg)

[Maria Paula Gerardino](http://www.nber.org/people/maria_paula_gerardino), [Stephan Litschig](http://www3.grips.ac.jp/~s-litschig/) and [Dina Pomeranz](https://www.econ.uzh.ch/en/people/faculty/pomeranz.html) have recently-ish published a [new NBER working paper](http://www.nber.org/papers/w23978), "Can Audits Backfire? Evidence from Public Procurement in Chile".
It deals with the problem that while audits are intended to monitor compliance of tax rules, they can also generate unintended incentives.
From the abstract:

> This paper investigates the effects of procurement audits on public entities' choice of purchase procedures in Chile. While the national procurement legislation tries to promote the use of more transparent and competitive auctions rather than discretionary direct contracts for selection of suppliers, auctions are significantly more complex and the audit protocol mechanically leads to more scrutiny and a higher probability of further investigation for auctions than for direct contracts. Using a regression discontinuity design based on a scoring rule of the National Comptroller Agency, we find that audits lead to a decrease in the use of auctions and a corresponding increase in the use of direct contracts.

One important observation is noticing that while public entities shift purchases to less transparent methods (e.g. direct negotiations) during temporary decreases in audit probability, there is heterogeneity across these entities in who determines the purchasing method.
This is when `rddsga` comes in, as it allows us to correctly analyze treatment effects while isolating differences due to other observables.
You can read more about `rddsga` in a [previous post](/posts/rddsga-intro), and it is also available at the SSC repo, so it can be downloaded directly within Stata:

```stata
ssc install rddsga
```

The help file includes a more detailed explanation and examples using a synthetic dataset. Merry Discontinuities to everyone!
