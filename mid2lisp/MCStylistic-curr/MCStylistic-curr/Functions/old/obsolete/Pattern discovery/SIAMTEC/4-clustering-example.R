# 8/12/2009 Tom Collins

# Example code and functions for the clustering stage of the algorithm. The code works but perhaps the parameter space is too large as it takes a while to compute which combination of parameters is closest to the target.

# Load the unseparated patterns and their respective lengths.
A <- as.matrix(read.csv("//Applications/CCL/Lisp code/Pattern discovery/Write to files/L 1 (1 1 1 1 0) commas 1.txt", header=FALSE))
colnames(A) <- c("ontime", "MNN", "MPN", "duration")
l <- as.matrix(read.csv("//Applications/CCL/Lisp code/Pattern discovery/Write to files/L 1 (1 1 1 1 0) lengths 1.txt", header=FALSE))
# Load the parameter `space'.
theta <- read.csv("//Applications/CCL/Lisp code/Pattern discovery/parameters2.csv", header=TRUE)

max.pat.return <- 196878
alpha <- 1e-3
target <- round(alpha*max.pat.return)

system.time(i <- row.closest2target(A, l, theta, target))
# 81.635 seconds.
# i is 5.

B <- kmeans.patterns(A, l, theta[i,2:4])
C <- critical.region.members(B, theta[i,1])
# lambda <- l[C[,1]+1]
# lambda gives us the cardinalities of the selected patterns. The `+1' term is because in kmeans.patterns, 1 is subtracted for compliancy with Lisp.

write(C[,1], file = "//Applications/CCL/Lisp code/Pattern discovery/Write to files/L 1 (1 1 1 1 0) R-out 1.txt", ncolumns = 1)

