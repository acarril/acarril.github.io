---
layout: post
title:  The difference between probability and likelihood using coins
categories: metrics R
---

The distinction between probability and likelihood is extremely important, though often misunderstood. I like to remember that probability refers to possible *results*, whereas likelihood refers to *hypotheses*.

<!--more-->

# The experiment

Suppose an experiment where a person has to predict the outcome of each of 10 coin tosses. After carrying out the test, you could observe that the person has 0 correct predictions or up to 10 correct predictions, which amounts to *11 possible results for the experiment*. These 11 **results are mutually exclusive** (i.e. he can't get 5 and 7 correct predictions) **and exhaustive** (i.e. 0 to 11 correct predictions cover all possible results).

On the other hand, **hypotheses are neither mutually exclusive nor exhaustive**. Suppose that the person correctly predicted 8 outcomes. Your hypothesis could be that he just guessed and got lucky. My hypothesis could be that he's a magician that may had controlled the toss to his favor. Both hypotheses are not mutually exclusive: he *could* be a seasoned magician with a slight edge who also happened to got lucky. You could in turn hypothesize that he is a machine with almost perfect accuracy and that the observed result actually  underestimates the probability that his next prediction will be correct. There is no bound to the hypotheses we may entertain, and so they will never be exhaustive.

Given that we may never be sure that we have dreamt up *all* possible hypotheses, our concern will only be to estimate the extent to which the experimental results affect affect the **relative likelihood** of the hypotheses considered. The likelihoods attached to any given hypothesis have no meaning unto themselves, but their ratios do.

# Plotting each function

The difference between probability and likelihood became very clear to me when playing with probability distribution function in a statistical software (yeah, I've played with those). In this post I'll use `R` and its `dbinom` function for [binomial distributions](https://en.wikipedia.org/wiki/Binomial_distribution). We are interested in three inputs: the **number of successes**, the **number of tries** and the **probability of success**.

If we compute **probabilities**, we assume that the number of tries and the probability of success are given, which is to say, they are parameters of the distribution. What we vary is the number of successes, and as we do this we attach probabilities to each of those results. We can plot the binomial probability distribution function with this parameters in R:

```R
barplot(
  dbinom(x = 0:10, size = 10, prob = 0.5),
  names.arg = 0:10,
  ylab="Probability",
  xlab="Number of successes"
)
```

![Probability](/files/prob_10success.png "Binomial probability distribution function with p=0.5 and 10 tries")

If we compute the **[likelihood function](https://en.wikipedia.org/wiki/Likelihood_function)**, *we take the number of successes as given* (e.g. 8), as well as the number of tries. In other words, the given result is now treated as parameter of the function. Instead of varying the possible results, we vary the probability of success in order to get the binomial likelihood function plotted below.

```R
curve(
  dbinom(8,10,x), xlim = c(0,1),
  ylab="Likelihood",
  xlab=expression(paste("Binomial ", rho)),
)
```

![Likelihood](/files/likelihood_8_10_sucess.png "Binomial likelihood function given 8 successes in 10 tries")

Take a moment to understand this last figure. It is telling us that if we observed 8 successes in 10 tries, the probability parameter of the binomial distribution from which we are drawing (i.e. the distribution of successful predictions of our test guy) is very unlikely to be, say, 0.4. It is much more likely to be 0.8, although 0.7 or 0.9 are also likely. The hypothesis that the long-term success rate is 0.8 is almost three times as likely as the hypothesis that the long-term success rate is 0.6.

# Formalizing the intuition

We have a stochastic process that takes discrete values (i.e. outcomes of tossing a coin 10 times). We calculated the probability of observing a particular set of outcomes (8 correct predictions) by making assumptions about the underlying stochastic process, that is, the probability that our test subject can correctly predict the outcome of the coin toss is $$p$$ (e.g. 0.8). We also assumed implicitly that the coin tosses are independent.

Let $$O$$ be the set of observed outcomes and $$\theta$$ be the set of parameters that describe the stochastic process. So when we speak about probability we actually compute $$P(O \vert \theta)$$: given specific values for $$\theta$$, $$P(O \vert \theta)$$ is the probability that we would observe the outcomes in $$O$$.

When we model a real life stochastic process we don't know $$\theta$$; we simply observe $$O$$. Our goal is then to have an estimate for $$\theta$$ that would be a plausible choice given the observed outcomes $$O$$. We know that given a value of $$\theta$$ the probability of observing $$O$$ is $$P(O \vert \theta)$$. So it makes sense to choose the value of $$\theta$$ that would maximize the probability that we would actually observe $$O$$. In other words, we find the parameter values $$\theta$$ that maximize

$$ \mathcal{L}(\theta \vert O) = P(O \vert \theta) $$

where $$\mathcal{L}(\theta \vert O)$$ is the likelihood function, which I talked about in [a post about maximum likelihood estimation](/posts/mle-notes). Notice that by definition the likelihood function is conditioned on the observed $$O$$ and that it is a function of the unknown parameters $$\theta$$.

### Extension to continuous random variables

The situation is similar, but obviously we can no longer talk about the probability that we observed $$O$$ given $$\theta$$ because in the continuous case $$P(O \vert \theta) = 0$$. So know we let $$f(O \vert \theta)$$ be the [probability density function](https://en.wikipedia.org/wiki/Probability_density_function) (PDF) associated with the outcomes $$O$$. In the continuous case we estimate $$\theta$$ given observed outcomes $$O$$ by maximizing

$$\mathcal{L}(\theta \vert O) = f(O \vert \theta)$$

Note that in this situation we can't assert that we are finding the parameter value that maximizes the probability that we observe $$O$$, as we maximize the PDF *associated* with the observed outcomes $$O$$. Go [here](http://stats.stackexchange.com/questions/31238/what-is-the-reason-that-a-likelihood-function-is-not-a-pdf) for more information on why $$\mathcal{L}$$ is *not* a PDF.
