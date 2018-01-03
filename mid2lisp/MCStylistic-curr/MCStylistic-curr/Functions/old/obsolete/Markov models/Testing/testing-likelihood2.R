like.profile.template <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-profile-C-41-2.csv", header=FALSE)

like.profile.new <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/likelihood-profile-new.csv", header=FALSE)

like.back.template <- read.csv("/Applications/CCL/Lisp code/Markov models/Testing/like-back-67-3.csv", header=FALSE)

plot(like.profile.template[,1], like.profile.template[,2], type="o", cex=.5, pch=1, xlab="Ontime", ylab="Geometric Mean Likelihood", xlim=c(0,50), ylim=c(0,0.25), axes=F)
axis(1, at=seq(from=0, to=48, by=3))
axis(2, at=seq(from=0, to=0.25, by=0.02))
abline(v=seq(from=0, to=48, by=3), lty=3, col="darkgray")
abline(h=seq(from=0, to=0.25, by=0.02), lty=3, col="darkgray")

lines(like.profile.new[,1], like.profile.new[,2], type="o", cex=.5, pch=2, col="dodgerblue")

plot(like.back.template[,1], like.back.template[,2], type="o", cex=.5, pch=1, xlab="Ontime", ylab="Geometric Mean Likelihood", xlim=c(-3,36), ylim=c(0.02,0.12), axes=F)
axis(1, at=seq(from=-3, to=36, by=3))
axis(2, at=seq(from=0.02, to=0.12, by=0.01))
abline(v=seq(from=-3, to=36, by=3), lty=3, col="darkgray")
abline(h=seq(from=0.02, to=0.12, by=0.01), lty=3, col="darkgray")