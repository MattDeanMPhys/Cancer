MAX = 10000
grd = zeros(MAX,10)

u = 0.01
deltaX = 0.1

uTilde = u*deltaX
h = 0.1
k = 0.1 

alpha = uTilde * k * h 
beta = (k*uTilde*deltaX/ (2* h^2))

for i = 1:MAX-1
	grd[i,1] = exp(- u  *(i-1)) 
end

for j=1:MAX-1
	for i=2:9
		grd[j+1, i] = (1 + alpha + beta)*grd[j,i] + (beta - alpha)*grd[j,i+1] + beta*grd[j, i-1]
	end
end
fl = open("pdesolve.txt", "w+")

writedlm(fl, grd)
