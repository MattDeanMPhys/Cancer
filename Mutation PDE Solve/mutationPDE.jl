using ASCIIPlots
C = -1
h = 0.01
deltaX = 1/100

x = zeros(10)

x[1] = 0.5
x[2] = x[1] * ( deltaX/h^2 + C + 1/h) * ( deltaX/(2*h^2) + 1/h )^(-1) 

i = 2 
while i < length(x)

	a = x[i] * ( deltaX/h^2 + C + 1/h) * ( deltaX/(2*h^2) + 1/h )^(-1) - x[i-1] * deltaX/2h^2 * ( deltaX/(2*h^2) + 1/h )^(-1) 

	x[i+1] = a 
	
	i = i + 1
end


x2 = [1:10]

println(length(x))
println(length(x2))

println(lineplot(x2, x))

