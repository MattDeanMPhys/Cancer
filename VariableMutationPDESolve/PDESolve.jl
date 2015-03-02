using MyModule
using ASCIIPlots

#Read in a deltaX value

#keyboardInput = readline(STDIN)
#deltaX = float(chomp(keyboardInput))

#Set h equal to k. deltaX greater than h (2h usually). Match uhat to the proper mutation rate. 

T = 200.0  #Maximum time value
k = 0.01 #t spacing

deltaX = 0.1
M = 1  #Number of mutations

h = 0.010 #x spacing
x = [0:h:1]

a = int(T/k) #Time span
b = int(1/h) #x span

println(a)
println(b)

mesh = zeros(a, b) 
mesh[1,1] = 1

#Create three arrays for the mutation landscape

uHat = MyModule.u(x, M)*deltaX
duHat = MyModule.du(x, M)*deltaX
du2Hat = MyModule.d2u(x, M)*deltaX

alpha = uHat *(k/h)

for i = 1:(a-1)
	for j = 1:b 
		if j == 1
			mesh[i+1,j] = mesh[i,j] * ( 1 + alpha[j] * ( 1 - (deltaX/h) ) -	k*(duHat[j] + (deltaX/2) * du2Hat[j] ) ) +  mesh[i, j+1] * alpha[j] * ( deltaX/(2 *h) - 1 )

		elseif j == b
			mesh[i+1,j] = mesh[i,j] * ( 1 + alpha[j] * ( 1 - (deltaX/h) ) -	k*(duHat[j] + (deltaX/2) * du2Hat[j] ) ) + mesh[i, j-1] *( (alpha[j] * deltaX) / (2 * h) ) 
		else	

			mesh[i+1,j] = mesh[i,j] * ( 1 + alpha[j] * ( 1 - (deltaX/h) ) -	k*(duHat[j] + (deltaX/2) * du2Hat[j] ) ) + mesh[i, j-1] *( (alpha[j] * deltaX) / (2 * h) ) + mesh[i, j+1] * alpha[j] * ( deltaX/(2 *h) - 1 )

		end
	end
end

outputString = join([h, "_", "hTEST","mesh", deltaX, "_", "deltaX", ".txt"])

writedlm(outputString, mesh)
