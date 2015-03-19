import numpy as np 

X = 50
T = 25

deltax = 0.5 
deltat = 0.005

r = 1.0
D = 1.0

mesh = np.zeros(shape=(int(T/deltat),int(X/deltax)))

#for k in range(0,int(1/deltax)):
#	mesh[0][k] = 1.0

#for k in range(int(2/deltax),int(3/deltax)):
#	mesh[0][k] = 1.0

mesh[0][1] = 1 
mesh[0][0] = 1 
mesh[0][2] = 1 
mesh[0][3] = 1 
mesh[0][4] = 1 

# for k in range(0,int(10/deltax)):
# 	mesh[0][k] = 0.5

for i in range(0,(int(T/deltat)-1)):
	for j in range(0,(int(X/deltax)-1)):
		if j == 0:
			mesh[i+1][j] = mesh[i][j] + deltat*( (D*( mesh[i][j+1] - 2*mesh[i][j] )/(deltax*deltax)) + r*mesh[i][j]*(1-mesh[i][j]) )
		elif j == int(X/deltax)-1:
			mesh[i+1][j] = mesh[i][j] + deltat*( (D*( mesh[i][j-1] - 2*mesh[i][j] )/(deltax*deltax)) + r*mesh[i][j]*(1-mesh[i][j]) )
		elif (j>0 and j < int(X/deltax)-1):
			mesh[i+1][j] = mesh[i][j] + deltat*( (D*( mesh[i][j+1] - 2*mesh[i][j] + mesh[i][j-1] )/(deltax*deltax)) + r*mesh[i][j]*(1-mesh[i][j]) )
		
print("Finished PDE solver")

np.savetxt("meshDean.txt", mesh, delimiter="\t")
