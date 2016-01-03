# to set random distances between all cities
genDist <- function(ncities) {
  dist <- matrix(data = sample(1:((ncities^2)*10), ncities^2), nrow = ncities, ncol = ncities)
  
  for (i in 1:ncities) {
    for (j in i:ncities) {
      dist[i,j] = dist[j,i];
    }
    dist[i,i] = 0
  }
  
  return (dist)
}

# compute the total distance given the ordering of the cities in the path
distance <- function(order) {
  total_distance <- 0
  
  for (i in 1:(length(order)-1)) {
    total_distance <- total_distance + dist[order[i], order[i+1]]
  }
  
  total_distance <- total_distance + dist[order[length(order)], order[1]]
  return (total_distance)
}

# swap two randomly picked cities in the ordering
swap <- function(order) {
  indices <- sample(1:length(order), 2)
  temp = order[indices[1]]
  order[indices[1]] = order[indices[2]]
  order[indices[2]] = temp
  return(order)
}

# returns the probability with which a solution should be accepted
accptFun <- function(delE, t) {
  return(1/(1+exp(delE/t)))
}

# Initialization
t = 1e5
ncities <- 10
dist <- genDist(ncities = ncities)
order <- sample(x = 1:ncities)
E <- distance(order = order)
iter <- 1
Error <- c(E)

startTime <- proc.time()
while(proc.time() - startTime < 1) {
  newOrder <- swap(order = order)
  newE <- distance(order = newOrder)
  
  rand <- runif(1, min = 0, max = 1)
  acpt <- accptFun(newE - E, t)
  
  if(rand <= acpt) {
    delE <- newE - E
    
    cat("Iteration: ", iter, ", Time: ", proc.time() - startTime, "Temperature: ", t, "\n")
    cat("Order: ", order, ", New Order: ", newOrder, "\n")
    cat("Total Distance: ", E, "Del E: ", delE, ", New Total Distance: ", newE, "\n")
    cat("\n\n")
    
    E <- newE
    order <- newOrder
    t <- t * 0.9
    iter <- iter + 1
    Error[iter] = E
  }
}

plot(1:iter, Error, xlab = "Iterations", ylab = "Total Distance", type = "l")
