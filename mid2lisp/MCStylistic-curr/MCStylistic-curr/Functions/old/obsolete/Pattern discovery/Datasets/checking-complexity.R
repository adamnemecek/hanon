dataset <- read.csv("/Applications/CCL/Lisp code/Pattern discovery/Datasets/timings.txt", header=FALSE)
plot(dataset[,1],dataset[,2])
curve(x^2*log(x)/100000, add=TRUE)