# The true parameters
beta <- 1.5
sigma2 <- 0.5

# Generate dataset
data   <- data.frame(x = runif(300, 1, 10))
data$y <- 0 + 0.5*beta*data$x + rnorm(300, 0, sigma2)
plot(data$x, data$y)

# Log-likelihood function
linear.lik <- function(theta, y, X){
  n      <- nrow(X)
  k      <- ncol(X)
  beta   <- theta[1:k]
  sigma2 <- theta[k+1]
  e      <- y - X%*%beta
  logl   <- -.5*n*log(2*pi)-.5*n*log(sigma2) - ( (t(e) %*% e)/ (2*sigma2) )
  return(-logl)
}

# Plot of log-likelihood function for different values of beta and sigma2
surface <- list()
k <- 0
for(beta in seq(0, 2, 0.1)){
  for(sigma2 in seq(0, 2, 0.1)){
    k <- k + 1
    logL <- linear.lik(theta = c(0, beta, sigma2), y = data$y, X = cbind(1, data$x))
    surface[[k]] <- data.frame(beta = beta, sigma2 = sigma2, logL = -logL)
  }
}
surface <- do.call(rbind, surface)
library(lattice)
wireframe(logL ~ beta*sigma2,
          surface,
          colorkey=T,
          drape=TRUE,
          scales = list(arrows = FALSE, z = list(arrows=T)),
          col.regions = rainbow(100, s = 1, v = 1, start = 0, end = max(1,100 - 1)/100, alpha = 1)
          trellis.par.set(background = list(col = "transparent"))
          )

linear.MLE <- nlm(f=linear.lik, p=c(1,1,1), hessian=TRUE, y=data$y, X=cbind(1, data$x))
linear.MLE$estimate

## [1] -0.04481  2.70841  1.71870

summary(lm(y ~ x, data))
