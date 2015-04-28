import numpy as np 
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as mpl
from matplotlib.backends.backend_pdf import PdfPages

X=100
T=300

deltax = 1

dx = 0.01 
dt = 0.00001

u = 0.5

D = u*deltax*deltax/2

mesh = np.zeros(shape=(int(T/dt),int(X/dx)))
mesh[0][0] = 1

for i in range(0,(int(T/dt)-1)):
	if i%100000 == 0: 
		print("We got another 100000")
	
	for j in range(0,(int(X/dx)-1)):
		if j == 0:
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j+1] - 2*mesh[i][j] )/(dx*dx)) - u*deltax*(mesh[i][j+1] - mesh[i][j])/dx )
		elif j == int(X/dx)-1:
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j-1] - 2*mesh[i][j] )/(dx*dx)) - u*deltax*(mesh[i][j+1] - mesh[i][j])/dx )
		elif (j>0 and j < int(X/dx)-1):
			mesh[i+1][j] = mesh[i][j] + dt*( (D*( mesh[i][j+1] - 2*mesh[i][j] + mesh[i][j-1] )/(dx*dx)) - u*deltax*(mesh[i][j+1] - mesh[i][j])/dx )
		
print("Finished PDE solver")

x = np.zeros(shape=(int(T/dt),int(X/dx)))
for i in range(0,int(T/dt)): 
	x[i] = x[i] + np.linspace(1,X,num=(X/dx))

t = np.zeros(shape=(int(X/dx),int(T/dt)))
for j in range(0,int(X/dx)): 
	t[j] = t[j] + np.linspace(1,T,num=(T/dt))

print(x)
print(t.T)
print("Finished meshing")

fig = mpl.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x,t.T,mesh, rstride = 400, cstride=50, alpha=0.8, linewidth=0, antialiased=True)
ax.set_xlabel('x')
ax.set_ylabel('t')
ax.set_zlabel('Concentration')
ax.set_title('Cancer wave')

mpl.savefig('plot.pdf', format='pdf')


