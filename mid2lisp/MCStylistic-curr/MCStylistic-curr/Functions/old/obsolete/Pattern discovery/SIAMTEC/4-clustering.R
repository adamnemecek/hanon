# 8/12/2009 Tom Collins

# Example code and functions for the clustering stage of the algorithm. The code works but perhaps the parameter space is too large as it takes a while to compute which combination of parameters is closest to the target.

# Load the unseparated patterns and their respective lengths.
A <- as.matrix(read.csv("//Applications/CCL/Lisp code/Pattern discovery/Write to files/Fantasia (1 1) commas.txt", header=FALSE))
colnames(A) <- c("ontime", "morphetic pitch number")
l <- as.matrix(read.csv("//Applications/CCL/Lisp code/Pattern discovery/Write to files/Fantasia (1 1) lengths.txt", header=FALSE))
# Load the parameter `space'.
theta <- read.csv("//Applications/CCL/Lisp code/Pattern discovery/parameters2.csv", header=TRUE)

# This is the definition for the `logistic' function. It's called collins.cdf because it defines a probability distribution and I invented it (as far as I know!).
collins.cdf <- function(x,a) {
	if (x >= 0 && x <= 1 && a > 0) {
		if (x <= 1/2) {
			result <- 2^(a-1)*x^a
		} else {
			result <- -2^(a-1)*(1-x)^a + 1
		}
	} else {
		result <- "Unexpected arguments"
		}
	return(result)
}
# Applicable to a vector.
collins.cdfs <- function(x,a) {
	if (is.vector(x)) {
		n <- length(x)
		result <- vector("numeric", n)
		i <- 1
		while (i <= n) {
			result[i] <- collins.cdf(x[i],a)
			i <- i + 1
		}
	} else {
			result <- "x is not a vector"
	}
	return(result)
}
# Some plots to show what the function looks like for different values of a.
# curve(collins.cdfs(x,1), 0, 1, col="1", ylab="collins.cdf(x,a)")
# curve(collins.cdfs(x,2), 0, 1, col="2", add=TRUE)
# curve(collins.cdfs(x,3), 0, 1, col="3", add=TRUE)
# curve(collins.cdfs(x,4), 0, 1, col="4", add=TRUE)
# curve(collins.cdfs(x,5), 0, 1, col="5", add=TRUE)

# This function takes a matrix consisting of patterns (as in A), the lengths l of those patterns, and a vector of parameters (beta). The k-means clustering algorithm is applied to each pattern, and a matrix B is created. The first column of B contains the index of the pattern from A. The second column contains its length. The third column is the statistic of interest: the minimum cluster centre sum of squares.

# 8/12/2009. In need of testing!
kmeans.patterns <- function(A, l, beta) {
	i <- 1 # Beginning of pattern in A.
	j <- l[1] # End of pattern in A.
	k <- 2 # Incrementing over back-end of l.
	m <- 1 # Incrementing over B.
	n <- 1 # Incrementing over l.
	N <- length(l)
	B <- matrix(, N, 3)
	while (n <= N){
		if (l[n] >= beta[1]){
			# Pattern contains enough notes.
			P <- A[i:j,] # The pattern.
			if (l[n] < beta[2]){
				# P gets one cluster centre.
				# plot(x, col = cl$cluster)
				# points(cl$centers, col = 1:2, pch = 8, cex=2)
				B[m,1] <- n-1 # Index of pattern.
				B[m,2] <- l[n] # Cardinality of pattern.
				P.bar <- as.vector(colMeans(P))
				Q <- matrix(, l[n], dim(P)[2])
				r <- 1
				while (r <= dim(P)[2]){
					Q[,r] <- (P[,r] - P.bar[r])^2
					r <- r + 1
				}
				B[m,3] <- mean(rowSums(Q)) # MMCCSS defaults to mean sum of squares from centroid.
			} else {
				if (l[n] < beta[3]){
					# P gets two cluster centres.
					cl <- kmeans(P, rbind(P[1,], P[l[n],])) # Clustering.
					# plot(P, col = cl$cluster)
					# points(cl$centers, col = 1:2, pch = 8, cex=2)
					B[m,1] <- n-1 # Index of pattern.
					B[m,2] <- l[n] # Cardinality of pattern.
					B[m,3] <- min(cl$withinss/cl$size) # Minimum cluster centre sum of squares.
				} else {
					# P gets three cluster centres.
					mid <- ceiling((dim(P)[1]+1)/2)
					cl <- kmeans(P, rbind(P[1,], P[mid,], P[l[n],])) # Clustering.
					# plot(P, col = cl$cluster)
					# points(cl$centers, col = 1:3, pch = 8, cex=2)
					B[m,1] <- n-1 # Index of pattern compliant with Lisp.
					B[m,2] <- l[n] # Cardinality of pattern.
					B[m,3] <- min(cl$withinss/cl$size) # Minimum mean cluster centre sum of squares.
				}
			}
			m <- m + 1
		}
		i <- j + 1
		j <- j + l[k]
		k <- k + 1
		n <- n + 1
	}
	B <- B[1:m-1,]
	# plot(B[,2],B[,3]) is a plot of the MMCCSS stat against cardinality.
	return(B)
}

# This function takes a matrix consisting indices, lengths and MMCCSS stats of patterns (as in B), and a parameter (a). It returns a matrix C each row of which corresponds to a pattern. A pattern is included in C if, in a plot of normalised MMCCSS against normalised cardinality, the point pertaining to the pattern lies on or below Collins' cdf with parameter a.
critical.region.members <- function(B, a) {
	n <- dim(B)[1]
	X <- matrix(, n, 3) # The next ten lines normalise cardinality and MMCCSS.
	length.min <- min(B[,2])
	length.max <- max(B[,2])
	mmccss.min <- min(B[,3])
	mmccss.max <- max(B[,3])
	length.range <- length.max - length.min
	mmccss.range <- mmccss.max - mmccss.min
	X[,1] <- B[,1]
	X[,2] <- (B[,2] - length.min)/length.range
	X[,3] <- (B[,3] - mmccss.min)/mmccss.range
	# plot(X[,2], X[,3], xlab="cardinality", ylab="MMCCSS")
	# curve(collins.cdfs(x,2), 0, 1, add=TRUE)
	C <- matrix(, n, 3)
	i <- 1 # Increment over X.
	j <- 1 # Increment over C.
	while (i <= n){
		if (collins.cdf(X[i,2],a) >= X[i,3]){
			C[j,] <- X[i,]
			j <- j + 1
		}
		i <- i + 1
	}
	C <- matrix(C[1:j-1,], j-1, 3)
	# plot(C[,2], C[,3], ylim = c(0,1)) # Shows the pattern points that have been selected.
	return(C)
}
	
# This function takes A, l, and theta as described above, and a target number of patterns. The clustering-logistic functions are applied for each row of theta, to determine which values of theta return the number of patterns closest to the target.
row.closest2target <- function(A, l, theta, target) {
	n <- dim(theta)[1]
	D <- vector("numeric", n) # Vector of absolute differences.
	i <- 1 # Increment over D.
	while (i <= n){
		D[i] <- abs(
				  target - 
		         dim(
		          critical.region.members(
		           kmeans.patterns(A, l, theta[i,2:4]), theta[i,1])
		           )[1])
		i <- i + 1
	}
	return(which.min(D))
}


