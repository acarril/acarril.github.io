---
layout: post
title:  The difference between probability and likelihood using coins
categories: metrics, R
---

The distinction between probability and likelihood is extremely important, though often misunderstood. I like to remember that probability refers to possible *results*, whereas likelihood refers to *hypotheses*.

# The experiment

Suppose an experiment where a person has to predict the outcome of each of 10 coin tosses. After carrying out the test, you could observe that the person has 0 correct predictions or up to 10 correct predictions, which amounts to *11 possible results for the experiment*. These 11 results are mutually exclusive (i.e. he can't get 5 and 7 correct predictions) and exhaustive (i.e. 0 to 11 correct predictions cover all possible results).

Hypotheses, on the other hand, are neither mutually exclusive nor exhaustive. Suppose that the person correctly predicted 9 outcomes. Your hypothesis could be that he just guessed and got lucky. My hypothesis could be that he's a magician that may had controlled the toss to his favor. Both hypotheses are not mutually exclusive: he *could* be a seasoned magician with a slight edge who also happened to got lucky. You could in turn hypothesize that he is a machine with almost perfect accuracy and that the observed result actually  underestimates the probability that his next prediction will be correct. There is no bound to the hypotheses we may entertain, and so they will never be exhaustive.

Given that we may never be sure that we have dreamt up *all* possible hypotheses, our concern will only be to estimate the extent to which the experimental results affect affect the **relative likelihood** of the hypotheses considered. The likelihoods attached to any given hypothesis have no meaning unto themselves, but their ratios do.

# Lets plot!

The difference between probability and likelihood became very clear to me when playing with probability distribution function in a statistical software (yeah, I've played with those). In this post I'll use `R` and its `dbinom` function for binomial distributions. We are interested in three inputs: the number of successes, the number of tries and the probability of success.

If we compute probabilities, we assume that the number of tries and the probability of success are given, which is to say, they are parameters of the distribution. What we vary is the number of successes, and as we do this we attach probabilities to each of those results. We can plot the binomial probability distribution function with this parameters in R:

```R
barplot(
  dbinom(x = 0:10, size = 10, prob = 0.5),
  names.arg = 0:10,
  ylab="Probability",
  xlab="Number of successes"
)
```

![Probability](/files/prob_10success.png "Binomial probability distribution function with p=0.5 and 10 tries")

On the other hand, if we compute the likelihood function, we take the number of successes (e.g. 8) as given, as well as the number of tries. In other words, the given result is now treated as parameter of the function. Instead of varying the possible results, we vary the probability of success in order to get the binomial likelihood function plotted below.

```R
curve(
  dbinom(8,10,x), xlim = c(0,1),
  ylab="Likelihood",
  xlab=expression(paste("Binomial ", rho)),
)
```

![Likelihood](/files/likelihood_8_10_sucess.png "Binomial likelihood function given 8 successes in 10 tries")

The information plotted in this last figure is extremely handy. It is telling us that if we observed 8 successes in 10 tries, the probability parameter of the binomial distribution from which we are drawing (i.e. the distribution of successful predictions of our test guy) is very unlikely to be, say, 0.4. It is much more likely to be 0.8, although 0.7 or 0.9 are also likely.
The hypothesis that the long-term success rate is 0.8 is almost three times as likely as the hypothesis that the long-term success rate is 0.6.
