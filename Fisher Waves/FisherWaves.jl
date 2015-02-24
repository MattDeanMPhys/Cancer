h = 0.50 
x = [0:h:10]

k = 1.00 
t = [0:k:500]

r = 0.001 
D = 0.01 

mesh = zeros(size(t)[1], size(x)[1])
mesh[1,1] = 1.00 
mesh[1,2] = 1.0

println(size(x)[1])
println(size(t)[1])

for i = 1:size(t)[1]-1 

	println("Time: ", i )	

	for j = 1:size(x)[1]

		println("Space: ", j)

		if j==1
			mesh[i+1, j] = mesh[i, j] + k * ( r*mesh[i,j]*(1 - mesh[i,j]) + (D / h^2) * (mesh[i, j+1] - 2*mesh[i,j]   ))

		elseif j == size(x)[1]
			mesh[i+1, j] = mesh[i, j] + k * ( r*mesh[i,j]*(1 - mesh[i,j]) + (D / h^2) * (  2*mesh[i,j] + mesh[i, j-1] ))

		else 
			mesh[i+1, j] = mesh[i, j] + k * ( r*mesh[i,j]*(1 - mesh[i,j]) + (D / h^2) * (mesh[i, j+1] - 2*mesh[i,j] + mesh[i, j-1] ))
		end
	end

	println("Space Done")
end


writedlm("mesh.txt", mesh)
