gc()
rm(list = ls())
        b0  <- 0.2316419;
        b1  <- 0.319381530;
        b2  <- -0.356563782;
        b3  <- 1.781477937;
        b4  <- -1.821255978;
        b5  <- 1.330274429;
y1 <- function(x) sin(x)
y2 <- function(x) x
y3 <- function(x) 1-(dnorm(x))*(b1/(1+b0*x)+b2/(1+b0*x)^2+b3/(1+b0*x)^3+b4/(1+b0*x)^4+b5/(1+b0*x)^5)
y4 <- function(x) pnorm(x)
y5 <- function(x) 1-(dnorm(x))*(b1/(1+b0*x)+b2/(1+b0*x)^2+b3/(1+b0*x)^3+b4/(1+b0*x)^4+b5/(1+b0*x)^5)-pnorm(x)

plot(y1, -pi,  3*pi, xlim = c(-0.1, 0.1), ylim = c(-1,1))
curve(y2 ,-pi,  3*pi,col = "blue", add = TRUE)
curve(y3 ,-pi,  3*pi,col = "red", add = TRUE)
curve(y4 ,-pi,  3*pi,col = "green", add = TRUE)
curve(y5 ,-pi,  3*pi,col = "yellow", add = TRUE)
#add 代表在plot上直接增加图像
#xlim 代表绘制图像的x轴刻度区间

