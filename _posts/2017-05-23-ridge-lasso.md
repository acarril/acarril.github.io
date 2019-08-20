---
layout: post
title: The Ordinary, the Ridge and the Lasso
draft: true
---

![the lasso](http://imageresize.org/Output/209682bb-4d01-4c3a-ab6c-3b2cb7adcd6a.jpg)

We all know and love our good ol' ordinary least squares (OLS) regressions. In this post I will talk about two other methods that slightly modify OLS regression: **ridge regression** and **the lasso**, and how to implement them in R.

# The bias/variance tradeoff

In linear regression we assume the model

$$ y = f(\mathbf{z}) + \epsilon, \qquad \epsilon \sim (0,\sigma^2) $$

and our main goal is to come up with a regression function $$\hat f(\mathbf{z})=\mathbf{z}^\top \hat\beta$$.

Our basic tool to solve this problem is to use the least squares method, that is, to estimate $$\hat\beta_{\text{ols}}$$ such that the sum of the squares of the differences between the observed values and the predicted by our linear function $$y$$ is minimized. In terms of the figure, we're just minimizing the distance between the dots and the line.

![Plot taken from Grolemund and Wickham's DS4R](http://r4ds.had.co.nz/model-basics_files/figure-html/unnamed-chunk-4-1.png)

In order to asses whether our regression function is a good candidate to model the data, we can verify how well it answers two questions:

1. Is $$\hat\beta$$ close to $$\beta$$?
2. Will $$\hat f(\mathbf{z})$$ fit future observations well?

We already know that OLS minimizes the mean squared error. However, OLS regression can be improved if we

## Prediction error

Just because $$\hat f(\mathbf{z})$$ fits our data well, it doesn't mean it will be a good fit for new data.

# The ridge regression

Like OLS, the ridge regression attempts to minimize the residual sum of squares of predictors. However, ridge regression includes and additional "shrinkage" parameter, $$\lambda$$, which controls the amount of regularization applied to the coefficients (i.e. how large can they grow).

1. As $$\lambda \rightarrow 0$$, we obtain the OLS solution
2. As $$\lambda \rightarrow \infty$$, we obtain an intercept-only model ($$\beta^\text{ols}_{\lambda=\infty}=0$$)

Let's prepare a simple setup to play with the ridge regression and check these two claims. We'll use the `datasets::swiss`, which has Swiss fertility and socioeconomic indicators. First we set up a model matrix without its intercept column and create a vector of $$\lambda$$ values:

```R
swiss <- datasets::swiss
x <- model.matrix(Fertility~., swiss)[,-1]
y <- swiss$Fertility
lambda <- 10^seq(10, -2, length = 100)
```

<hr>

# Other

Ridge or lasso are forms of regularized linear regressions. The regularization can also be interpreted as prior in a maximum *a posteriori* estimation method. Under this interpretation, the ridge and the lasso make different assumptions on the class of linear transformation they infer to relate input and output data. In the ridge, the coefficients of the linear transformation are normally distributed and in the lasso they are [Laplace distributed](https://en.wikipedia.org/wiki/Laplace_distribution). In the lasso, this makes it easier for the coefficients to be zero and therefore easier to eliminate some of your input variable as not contributing to the output.

![Plot taken from Grolemund and Wickham's DS4R](http://r4ds.had.co.nz/model-basics_files/figure-html/unnamed-chunk-4-1.png)

There are also some practical considerations. The ridge is a bit easier to implement and faster to compute, which may matter depending on the type of data you have.

If you have both implemented, use subsets of your data to find the ridge and the lasso and compare how well they work on the left out data. The errors should give you an idea of which to use.

Keep in mind that ridge regression can't zero out coefficients; thus, you either end up including all the coefficients in the model, or none of them. In contrast, the LASSO does both parameter shrinkage and variable selection automatically. If some of your covariates are highly correlated, you may want to look at the Elastic Net instead of the LASSO.