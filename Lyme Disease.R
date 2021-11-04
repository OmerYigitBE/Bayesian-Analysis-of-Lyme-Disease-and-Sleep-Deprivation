## 1: ANALYTICAL DERIVATIONS

## Data specification
s <- 12
n <- 100

## Prior specification
alpha <- 3
beta <- 9

## Calculations for posterior distribution
theta <- seq(0, 1, 0.01)
#Scaled likelihood, easy to compare with prior and posterior 
likelihood <- dbeta(theta, s+1, n-s+1)
prior <- dbeta(theta, alpha, beta)
posterior <- dbeta(theta, alpha+s, beta+n-s)

## Plotting likelihood, prior and posterior
plot(theta,likelihood,type="l",ylim=c(0,13),col="blue",ylab="", lty=2)
lines(theta,prior,col="red")
lines(theta,posterior)
legend(0.6,8, c("prior","scaled likelihood","posterior"),
       lty=c(1,2,1), col=c("red","blue","black"))
#The prior is not so informative (small sample size).
#since the likelihood sample size is way larger than prior,
#it dominates the posterior distribution.

## Posterior summary measures
alpha.post<-alpha+s
beta.post<-beta+n-s
posterior_mode <- (alpha.post-1)/(alpha.post+beta.post-2)
posterior_mean <- alpha.post/(alpha.post+beta.post)
posterior_median <- qbeta(0.5,alpha.post,beta.post)
posterior_variance <- alpha.post*beta.post/((alpha.post+beta.post)^2*(alpha.post+beta.post+1))

## Credibility intervals - HPD
hpdbeta <- function(alpha,beta)                 
{
        p2 <- alpha
        q2 <- beta
        f <- function(x,p=p2,q=q2){
                b<-qbeta(pbeta(x,p,q)+0.95,p,q);(dbeta(x,p,q)-dbeta(b,p,q))^2}
        hpdmin <- optimize(f,lower=0,upper=qbeta(0.05,p2,q2),p=p2,q=q2)$minimum
        hpdmax <- qbeta(pbeta(hpdmin,p2,q2)+0.95,p2,q2)
        return(c(hpdmin,hpdmax))
}
hpd.CI<-hpdbeta(alpha.post,beta.post)

## Credibility intervals - equal tail
plot(theta,posterior,type="l",ylim=c(0,13),col="black",ylab="")
Eq.CI<-c(qbeta(0.025,alpha.post,beta.post),qbeta(0.975,alpha.post,beta.post))
abline(v=Eq.CI[1])
abline(v=Eq.CI[2])

## 2. PREDICTONS

## Predictive posterior distribution (page 155)
par(mfrow=c(1,1))
m <- 50
ytilde <- 0:50
#log of combination (m choose ytilde)
term1 <- log(choose(m, ytilde))
#nominator of betabinomial dist
term2 <- lgamma(alpha.post+ytilde)+lgamma(m-ytilde+beta.post)-lgamma(alpha.post+beta.post+m)
#constant part B(alfa,beta) in beta dist = inverse gamma dist. page 78
#calculations here are in log scale
#denominator of betabinomial dist
term3 <- lgamma(alpha.post)+lgamma(beta.post)-lgamma(alpha.post+beta.post)
#everything together
lpart <- term1+term2-term3
#back to original scale 
dytilde <- exp(lpart)

## Plotting PPD
plot(ytilde, dytilde, type="n", xlab="y~", ylab="probability")
lines(ytilde, dytilde, type="h", col="dark red", lwd=3)

## Expectation
expected <- m*alpha.post/(alpha.post+beta.post)

## Prediction for ytilde=4
pred_func<-function(alpha, beta, ytilde, m)
{ 
  term1 <-  log(choose(m, ytilde))
  term2 <- lgamma(alpha+ytilde)+lgamma(m-ytilde+beta)-lgamma(alpha+beta+m)
  term3 <- lgamma(alpha)+lgamma(beta)-lgamma(alpha+beta)
  lpart <- term1+term2-term3
  dytilde <- exp(lpart)
  return(dytilde)
}
pred_func(alpha.post, beta.post, 4, 50)



