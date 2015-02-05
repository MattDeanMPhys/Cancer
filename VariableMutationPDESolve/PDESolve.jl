using MyModule
using ASCIIPlots

T = 800.0  #Maximum time value
M = 50.0  #Number of mutations
h = 1.0 #x spacing
k = 1.0 #t spacing

a = int(T/k)
b = int(M/h)

println(a)
println(b)

mesh = zeros(a, b) 
mesh[1,1] = 1

#Create three arrays for the mutation landscape

x = [0:h:M]

u = MyModule.u(x, M)
du = MyModule.du(x, M)
du2 = MyModule.d2u(x, M)

f = MyModule.f(u, du, du2, k, h)

writedlm("f.txt", f)

#Now go through the non-edge nodes and update them based on the formula. TO DO UPDATE THE FORMULA WITH DELTXS AND CORRECT FACTORS OF 2 

for i = 1:(a-1)
	for j = 1:b 
		
		if j == 1
			mesh[i+1,j] = (k/h)*u[j] * ( (mesh[i, j+1] * (1/h - 1)) ) + MyModule.f(u[j], du[j], du2[j], k, h) * mesh[i,j]

		elseif j == b
			mesh[i+1,j] = (k/h)*u[j] * ( (mesh[i, j-1] / h) ) + MyModule.f(u[j], du[j], du2[j], k, h) * mesh[i,j]

		else	
			mesh[i+1,j] = (k/h)*u[j] * ( (mesh[i, j+1] * (1/h - 1)) + (mesh[i, j-1] / h) ) + MyModule.f(u[j], du[j], du2[j], k, h) * mesh[i,j]
		end
	end
end

writedlm("mesh.txt", mesh)
writedlm("mut.txt", u)
writedlm("mutD.txt", du)
writedlm("mutD2.txt", du2)
