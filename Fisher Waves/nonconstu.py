import numpy as np 
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as mpl
from matplotlib.backends.backend_pdf import PdfPages

X=75
T=30

deltax = 0.1 
deltat = 0.001

r = 1.0
D = 1.0

mesh = np.zeros(shape=(int(T/deltat),int(X/deltax)))

for k in range(0,int(15/deltax)):
	mesh[0][k] = 1.0

for k in range(int(25/deltax),int(35/deltax)):
	mesh[0][k] = 1.0
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

x = np.zeros(shape=(int(T/deltat),int(X/deltax)))
for i in range(0,int(T/deltat)): 
	x[i] = x[i] + np.linspace(1,X,num=(X/deltax))

t = np.zeros(shape=(int(X/deltax),int(T/deltat)))
for j in range(0,int(X/deltax)): 
	t[j] = t[j] + np.linspace(1,T,num=(T/deltat))

print(x)
print(t.T)
print("Finished meshing")

fig = mpl.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x,t.T,mesh, rstride = 400, cstride=50, cmap=Blues(mesh) , alpha=0.8, linewidth=0, antialiased=True)
ax.set_xlabel('x')
ax.set_ylabel('t')
ax.set_zlabel('u')
ax.set_title('Fisher wave (r=1, D=1)')

mpl.savefig('plot.pdf', format='pdf')


