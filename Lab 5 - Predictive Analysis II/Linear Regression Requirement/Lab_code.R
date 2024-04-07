rm(list=ls()) # clear the R environment by removing all objects from the workspace
n <- 100
nosim <- 1000
x1 <- rnorm(n)
x2<-rnorm(n)
y <- x1 + rnorm(n, sd = .3)

fit1<-lm(y~x1)
summary(fit1)
plot(x1, fit1$residuals); abline(a=0,b=0,col="red")


fit2<-lm(y~x2)
summary(fit2)
plot(x2,fit2$residuals); abline(a=0,b=0,col="blue")


fit1<-lm(y~x1-1)
summary(fit1)
plot(x1, fit1$residuals); abline(a=0,b=0,col="green")


n <- 100; nosim <- 1000
x1 <- rnorm(n); 
x2 <- rnorm(n); 
x3 <- rnorm(n);
y <- x1 + x2+ rnorm(n, sd = .3)

fit1<-lm(y~x1)
fit2<-lm(y~x2)
fit3<-lm(y~x3)
fit12<-lm(y~x1+x2)
fit13<-lm(y~x1+x3)
fit123<-lm(y~x1+x2+x3)

# Data exploration
pairs(y~x1+x2+x3)

# Model Evaluation
summary(fit1)
summary(fit12)
summary(fit123)
anova(fit1,fit12,fit123)




