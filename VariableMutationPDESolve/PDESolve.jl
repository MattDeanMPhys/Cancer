using MyModule
using ASCIIPlots

#Read in a deltaX value

keyboardInput = readline(STDIN)
deltaX = float(chomp(keyboardInput))


#Set h equal to k. deltaX greater than h (2h usually). Match uhat to the proper mutation rate. 


T = 15.0  #Maximum time value
k = 0.01 #t spacing

#deltaX = 0.1
M = 1  #Number of mutations

h = 0.01 #x spacing
x = [0:h:1]

a = int(T/k) #Time span
b = int(1/h) #x span

println(a)
println(b)

mesh = zeros(a, b) 
mesh[1,1] = 1

#Create three arrays for the mutation landscape

u = MyModule.u(x, M)*1
du = MyModule.du(x, M)*1
du2 = MyModule.d2u(x, M)*1

f = MyModule.f(u, du, du2, k, h, deltaX)

writedlm("f.txt", f)


for i = 1:(a-1)
	for j = 1:b 
		
		if j == 1
			mesh[i+1,j] = (k/h)*u[j] * ( (mesh[i, j+1] * (deltaX/(2*h) - 1)) ) + MyModule.f(u[j], du[j], du2[j], k, h, deltaX) * mesh[i,j]

		elseif j == b
			mesh[i+1,j] = deltaX*(k/h)*u[j] * ( (mesh[i, j-1] / (2*h)) ) + MyModule.f(u[j], du[j], du2[j], k, h, deltaX) * mesh[i,j]

		else	
			mesh[i+1,j] = (k/h)*u[j] * ( (mesh[i, j+1] * (deltaX/(2*h) - 1)) + ((mesh[i, j-1]*deltaX) / (2*h)) ) + MyModule.f(u[j], du[j], du2[j], k, h, deltaX) * mesh[i,j]
		end
	end
end

outputString = join(["mesh", deltaX, "_", "deltaX", ".txt"])

writedlm(outputString, mesh)
