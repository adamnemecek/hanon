
P-bar <- as.vector(colMeans(P))
Q <- matrix(, l[n], dim(P)[2])
r <- 1
while (r <= dim(P)[2]){
	Q[,r] <- (P[,r] - P.bar[r])^2
	r <- r + 1
	}