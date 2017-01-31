install.packages('relaimpo')
library(relaimpo)


x1 <- 1:100 - 50
x2 <- rep(c(1,2), length.out = 100)

y <- ifelse(test = x2 == 1, yes = x1^2 + rnorm(50), no = rnorm(50))
plot(x1, y)


m1 <- lm(y ~ x1 + x2)
points(predict(m1), x = x1, pch = 20, col = 'grey')

m2 <- lm(y ~ x1 * x2)
points(predict(m2), x = x1, col = 'red', pch = 20)


m3 <- lm(y ~ x1 * x2 + I(x1^2)*x2 )
points(predict(m3), x = x1, col = 'blue', pch = 20)

plot(calc.relimp(m1, rela = TRUE))

plot(calc.relimp(m2, rela = FALSE))

plot(calc.relimp(m3, rela = FALSE))

aa <- calc.relimp(m3, rela = FALSE)
str(aa)

sum(aa@lmg)
