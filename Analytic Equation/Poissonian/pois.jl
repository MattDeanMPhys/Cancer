function pois(n,t,u)

	((u*t)^n * exp(-u*t))/factorial(n)
end


a = [1,2,3]

println( pois(1,1,a))
