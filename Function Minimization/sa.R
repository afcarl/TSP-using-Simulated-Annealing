objFun <- function(x) {
  return (x^2 + 9 * x + 8)
}

genFun <- function(t) {
  return (rnorm(1, sd = abs(t)))
}

accptFun <- function(delE, t) {
  return(1/(1 + exp(delE / t)))
}

x <- rnorm(1, sd = 10)
t <- 100
E <- objFun(x)
iter <- 1
Error <- c(E)
Temp <- c(t)
delE <- 1000

while(abs(delE) > 0.01){
  delx <- genFun(t)
  newX <- x + delx
  newE <- objFun(newX)
  
  rand <- runif(1, min = 0, max = 1)
  acpt <- accptFun(newE - E, t)
  #cat("Rand: ", rand, ", Acpt: ", acpt, "\n")
  
  if(rand <= acpt) {
    delE <- newE - E
    
    cat("Iteration: ", iter, "Temp: ", t, "\n")
    cat("X: ", x, "Del X: ", delx, ", New X: ", newX, "\n")
    cat("E: ", E, "Del E: ", delE, ", New E: ", newE, "\n")
    cat("\n\n")
    
    E <- newE
    x <- newX
  }
  
  t <- t * 0.9
  iter <- iter + 1
  Error[iter] = E
  Temp[iter] = t
}

plot(1:iter, Error, ylim = c(-15,100), xlab = "Iterations", ylab = "Objective Function", type = "l")
lines(1:iter, Temp, col="red")
