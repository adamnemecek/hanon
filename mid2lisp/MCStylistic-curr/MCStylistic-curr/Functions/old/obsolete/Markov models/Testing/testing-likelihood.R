like.curve <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-curve-c-41-2.csv", header=FALSE)

like.curve2 <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-curve2-c-41-2.csv", header=FALSE)

like.curve3 <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-curve3-c-41-2.csv", header=FALSE)

like.curve.C.41.3 <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-curve-c-41-3.csv", header=FALSE)

like.curve.C.50.1 <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-curve-c-50-1.csv", header=FALSE)

like.profile <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-profile-C-41-2.csv", header=FALSE)

plot(like.curve[,1], log(like.curve[,2]), type="o", cex=.5, pch=1, xlab="ontime", ylab="log likelihood", xlim=c(0,50), ylim=c(-18,0), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=-18, to=0, by=3))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=-18, to=0, by=3), lty=3, col="darkgray")

plot(like.curve2[,1], log(like.curve2[,2]), type="o", cex=.5, pch=1, xlab="ontime", ylab="log likelihood", xlim=c(0,50), ylim=c(-18,0), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=-18, to=0, by=3))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=-18, to=0, by=3), lty=3, col="darkgray")

plot(like.curve3[,1], log(like.curve3[,2]), type="o", cex=.5, pch=1, xlab="ontime", ylab="log likelihood", xlim=c(0,50), ylim=c(-4,-1.5), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=-4, to=-1.5, by=.5))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=-4, to=-1.5, by=.5), lty=3, col="darkgray")

plot(like.curve3[,1], like.curve3[,2], type="o", cex=.5, pch=1, xlab="ontime", ylab="geom mean likelihood", xlim=c(0,50), ylim=c(0,0.2), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=0, to=0.2, by=.02))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=0, to=0.2, by=.02), lty=3, col="darkgray")

plot(like.curve.C.41.3[,1], like.curve.C.41.3[,2], type="o", cex=.5, pch=1, xlab="ontime", ylab="geom mean likelihood", xlim=c(0,63), ylim=c(0,0.2), axes=F)
axis(1, at=seq(from=0, to=63, by=3))
axis(2, at=seq(from=0, to=0.2, by=.02))
abline(v=seq(from=0, to=63, by=3), lty=3, col="darkgray")
abline(h=seq(from=0, to=0.2, by=.02), lty=3, col="darkgray")

plot(like.curve.C.50.1[,1], like.curve.C.50.1[,2], type="o", cex=.5, pch=1, xlab="ontime", ylab="geom mean likelihood", xlim=c(0,48), ylim=c(0,0.2), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=0, to=0.2, by=.02))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=0, to=0.2, by=.02), lty=3, col="darkgray")

plot(like.profile[,1], like.profile[,2], type="o", cex=.5, pch=1, xlab="ontime", ylab="geom mean likelihood"), xlim=c(0,48), ylim=c(0,0.2), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=0, to=0.2, by=.02))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=0, to=0.2, by=.02), lty=3, col="darkgray")
