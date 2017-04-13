# PART 1

# Input data
y <- c(4, 1, 10)
x <- c(1, -1, 3) 
exampledata <- data.frame(y,x)

# Fit the model
lm(y ~ x, data = exampledata)

# PART 2

# The true parameters
beta <- 2
sigma2 <- 1

# Generate dataset
set.seed(123)
data   <- data.frame(x = runif(100, 1, 10))
data$y <- beta*data$x + rnorm(100, 0, sigma2)
plot(data$x, data$y, xlab="x", ylab="y")

# Log-likelihood function
linear.lik <- function(theta, y, X){
  n      <- nrow(X)
  k      <- ncol(X)
  beta   <- theta[1:k]
  sigma2 <- theta[k+1]
  e      <- y - X%*%beta
  logl   <- -.5*n*log(2*pi) - .5*n*log(sigma2) - ((t(e) %*% e) / (2*sigma2))
  return(-logl)
}

# Plot of log-likelihood function for different values of beta and sigma2
surface <- list()
k <- 0
for(beta in seq(0, 3, 0.1)){
  for(sigma2 in seq(0, 3, 0.1)){
    k <- k + 1
    logL <- linear.lik(theta = c(0, beta, sigma2), y = data$y, X = cbind(1, data$x))
    surface[[k]] <- data.frame(beta = beta, sigma2 = sigma2, logL = -logL)
  }
}
surface <- do.call(rbind, surface)
library(lattice)
wireframe(logL ~ beta*sigma2,
          surface,
          colorkey=FALSE,
          drape=TRUE,
          scales = list(arrows = FALSE, z = list(arrows=TRUE)),
          col.regions = rainbow(100, s = 1, v = 1, start = 0, end = max(1,100 - 1)/100, alpha = 1))

# Find maximization points
linear.MLE <- nlm(f=linear.lik, p=c(1,1,1), hessian=TRUE, y=data$y, X=cbind(1, data$x))
linear.MLE$estimate
## [1] 0.001049617 1.990013519 0.920734469

summary(lm(y ~ x, data))
