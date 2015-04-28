import numpy as np 
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as mpl
import sys

X=10
T=200

deltax = 1/X

dx = 0.01 
dt = 0.01

u = 0.1

D = u*deltax*deltax/2

print('D=', D)
print('dt=', dt)
print('dx =', dx)
print('deltax=',deltax)

print(D*dt/(dx**2))

if (D*dt/(dx**2)) < 0.5: 
	print('Euler forward is stable')
else:
	print('Euler forward is unstable')

sys.exit("Error message")

mesh = np.zeros(shape=(int(T/dt),int(X/dx)))
mesh[0][0] = 1

for i in range(0,(int(T/dt)-1)):
	if i%10000 == 0: 
		print(i)
	
	for j in range(0,(int(X/dx)-1)):
		if j == 0:
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j+1] - 2*mesh[i][j] )/(dx*dx)) - (u*deltax*(mesh[i][j+1] - mesh[i][j])/dx) )
		elif j == int(X/dx)-1:
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j-1] - 2*mesh[i][j] )/(dx*dx)) + ( u*deltax*(mesh[i][j])/dx) )
		elif (j>0 and j < int(X/dx)-1):
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j+1] - 2*mesh[i][j] + mesh[i][j-1] )/(dx*dx)) - (u*deltax*(mesh[i][j+1] - mesh[i][j])/dx) )
		
print("Finished PDE solver")

x = np.zeros(shape=(int(T/dt),int(X/dx)))
for i in range(0,int(T/dt)): 
	x[i] = x[i] + np.linspace(0,X,num=(X/dx))

t = np.zeros(shape=(int(X/dx),int(T/dt)))
for j in range(0,int(X/dx)): 
	t[j] = t[j] + np.linspace(0,T,num=(T/dt))

print("Finished meshing")

execfile('constrconstu_plot.py')

# for i in range(0,100): 
# 	mpl.plot(t[0],mesh[:,i/dx])

# mpl.show()

# fig = mpl.figure()
# ax = fig.add_subplot(111, projection='3d')
# ax.plot_surface(x,t.T,mesh, rstride = 400, cstride=50, alpha=0.8, linewidth=0, antialiased=True)
# ax.set_xlabel('x')
# ax.set_ylabel('t')
# ax.set_zlabel('Concentration')
# ax.set_title('Cancer wave')

# mpl.savefig('plot.pdf', format='pdf')


