---
layout: post
title:  What is bootstrapping and how does it work?
categories: metrics
---

I've used [bootstrapping](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)) many times to estimate errors, but when asked to explain how does it work, I realized I couldn't state it in an intuitive way. The question is simple: is bootstrapping simply a process of resampling from  our sample? How does that help us to learn something new about the *population*?

<!--more-->

When we try to say something about a population, we usually say it by looking at a sample. How well are we going to be able to describe the population using our sample depends on several things, like the structure of the population, the size of our sample, etc. Ideally, we would like to take many samples, and if they tend to describe the population in a consistent way, we can be reasonably confident that the population fits this description.

However, we usually *can't* take multiple samples; we have just the one. So in general we either

1. make some **assumptions** about the population, or
2. use the **information in our sample** to learn about the population

If we don't want to make assumptions about the population, we can just *take our sample and sample from it* instead. This can be done; the sample we have *is* a population, albeit a finite, smaller one. This is justified by the fact that a sample, if taken randomly, will most likely look very similar to the population it came from.

The way bootstrapping usually works is that we first pretend that our sample is a good proxy for our population, which is reasonable if the sample size is "large enough" (this can be quantified more precisely using the [Dvoretzky–Kiefer–Wolfowitz inequality](https://en.wikipedia.org/wiki/Dvoretzky%E2%80%93Kiefer%E2%80%93Wolfowitz_inequality)). Then we do resampling *with replacement*, which is an easy way to treat the sample like it's a population and to sample from it in a way that reflects its shape.

Notice that if we could compute the real parameters of interest from our pretend distribution, we'd prefer to do that. However, that is typically not the case, so we fall back to *estimating* those parameters, which is the reason to having to do resampling. So resampling is not equivalent to bootstrapping; it's just a tool that sometimes is needed for it.
