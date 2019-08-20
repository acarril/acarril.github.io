---
layout: post
title:  "Data transformations and the (natural) logarithm"
categories: metrics
hidden: true
---

In statistics it is common practice to apply some [transformation to the data](https://en.wikipedia.org/wiki/Data_transformation_(statistics)). This is (or should be) done so that the data more closely meet the assumptions the statistical inference procedure to be applied, but is also helps to interpret and visualize it better. In this post I go into detail of when (and when not) to transform your data. I also go into the specifics of log-transforms, which are widely used in economic analysis.

# Good reasons to transform your data

There are many possible transformations that can be applied to data, such as logarithms, reciprocals or roots. Below I explain some *general* situations in which it is desirable to apply some non-linear re-expression of the dependent variable.

### Residuals

First, the [residuals of your model](https://en.wikipedia.org/wiki/Errors_and_residuals) can have a **skewed distribution**. The idea behind the transformation should be to obtain residuals that are more symmetrically distributed about zero.

Residuals can also present **heteroskedasticity**, which is simply a systematic change in their spread with different values of the independent variables. Analogously, the idea behind the transformation should be to remove that systematic change in spread.

### Linearize relationships

There are models which relationships are not linear, like for example the Cobb-Doublas production function:

$$
Y = A L^\alpha K^{1-\alpha}
$$

You may have **theoretical reasons** to choose that model to fit into your data, so in order to use OLS for instance you have to apply some sort of transformation to your data. Additionally, linear relationships usually can **make estimation easier**, simplify the number or complexity of interaction terms, etc.

## Bad reasons to transform your data

While the reasons detailed above are valid from a data-driven perspective, sometimes data scientists use re-expressions for reasons that are not scientifically sound. These include

- **Getting rid of outliers**. Outliers are data points that don't fit a parsimonious, simplified description of the data (a.k.a our model). The presence of outliers should not dictate how we will choose to describe the rest of our data.
- **Getting nicer results**. Don't use it to make "bad" data look well-behaved or show you those pretty significance stars. This is related to the previous point and of course it is not the way to conduct rigorous scientific research.
- **Plotting the data**. If you need a transformation to plot your data, it may be a sign of one of the *good* reasons already mentioned. Or sometimes you just want to show a specific plot with the transformed data, which is fine if it doesn't translate to the actual analysis.
- **Because all the values are positive**. This may call for a different transformation. For instance, [root-transform is known to work best with count data](https://www.r-bloggers.com/do-not-log-transform-count-data-bitches/).

# Why use *logarithmic* transformations?

The general situations described above call for a transformation to better fit your model. But when are *natuaral logarithms* preferred?

### Residuals

As John Tukey mentions in his [EDA](https://en.wikipedia.org/wiki/Exploratory_data_analysis) book, logarithms are preferred when residuals show a "strong" positively skewed distribution. He also details methods to estimate the appropriate transformation. The bottom line is that if applying natural logarithm makes the distribution of the residuals symmetrical, then it is probably the right transformation.

Related to the above, it is also recommended to apply natural logarithm when the standard deviation of the residuals is directly proportional to the fitted values, and not to a *power* of them.

Additionally, if residuals indicate the presence of multiplicatively accumulating errors.

You really want a model in which marginal changes in the explanatory variables are interpreted in terms of multiplicative (percentage) changes in the dependent variable.

### Is it that a *natural* logarithm?

Yes it is!

It baffles me that we economists keep saying "take the logarithm of household income" and keep writing $$\log{y}$$, when what we really mean is to take the *natural* logarithm of household income, $$\ln{y}$$. I honestly don't know why this has happened, but in this post (and in general) I will always refer to natural logarithms by their full name and correct notation.

# Is there a reason for preferring natural logarithms in econometrics?

Yes, but the reasons are not extremely strong.

The most commonly cited advantage is that coefficients on the natural-log scale are *directly* interpretable as approximate proportional differences: with a coefficient of 0.07, a difference of 1 in $$x$$ corresponds to an approximate 7% difference in $$y$$ (Gelman and Hill, 2007).

Another advantage of natural logs of regular ones is that their first differential is simpler:

$$
\begin{align}
\frac{\ln x}{\partial x} &= \frac{1}{x} \\
\frac{\log x}{\partial x} &= \frac{1}{x\ln{10}}
\end{align}
$$

The emphasis is on *directly* interpretable, because we could take logarithms in a different base and still get similar results.

## Percentage change

Recall that for any variable $$z$$, the derivative of its natural logarithm is

$$
\frac{\partial \ln{z}}{\partial z} = \frac{1}{z}.
$$

Natural logarithm are usually interpreted as percentage changes because one can take that last equation and restate it as

$$
\partial \ln{z} = \frac{\partial z}{z}, \tag{1}
$$

which if multiplied by 100 gives you the percent change in $$z$$.

In a plain vanilla regression model like

$$
y = \alpha + \beta x + \epsilon
$$

one can choose to take the (natural) logarithm of the dependent and independent variables ($$y$$ and $$x$$). Notice that in that transformed model you'll have

$$
\beta = \frac{\partial \log{y}}{\partial \log{x}}
$$

# References

Andrew Gelman and Jennifer Hill (2007). Data Analysis using Regression and Multilevel/Hierarchical Models. Cambridge University Press: Cambridge; New York.

John W. Tukey (1977). Exploratory Data Analysis. Addison Wesley.
