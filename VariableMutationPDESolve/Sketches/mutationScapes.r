rm(list=ls())

M = 1000
delta = 0.1
x = c(0:M)

y1 = ((x-M/2)/M)^2 + delta
y2 = -y1 + 0.45
y3 = 0.9*cos(2*pi*x/(M))^2+0.1
y4 = 0.5*tanh((x-M/2)/(M*0.3)) + 0.5

par(mfrow=c(2,2))

plot(x, y1, type="l")
plot(x, y2, type = "l")
plot(x, y3, type = "l")
plot(x, y4, type = "l")
