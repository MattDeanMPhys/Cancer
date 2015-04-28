import numpy as np 
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm, colors
import sys
import matplotlib.pyplot as mpl

def find_nearest(array,value):
    idx = (np.abs(array-value)).argmin()
    return idx

X=75
T=15

deltax = 0.5
deltat = 0.005

r = 1.0
D = 1.0

mesh = np.zeros(shape=(int(T/deltat),int(X/deltax)))

# if ((D*deltat)/(deltax**2) < 0.5):
# 	print('Euler forward is stable')
# else:
# 	print('Euler forward is unstable')
# 	sys.exit()

for k in range(0,int(15/deltax)):
	mesh[0][k] = 1.0

for k in range(int(35/deltax),int(45/deltax)):
	mesh[0][k] = 0.25

for i in range(0,(int(T/deltat)-1)):
	for j in range(0,(int(X/deltax)-1)):
		if j == 0:
			mesh[i+1][j] = mesh[i][j] + deltat*( (D*( mesh[i][j+1] - 2*mesh[i][j] + 1)/(deltax*deltax)) + r*mesh[i][j]*(1-mesh[i][j]) )
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

np.savetxt('test.txt', mesh)

# U = 0.01
# N = 100
# vel = np.zeros(N-1)
# for k in range(0,N-1):
# 	vel[k] = (find_nearest(mesh[(k+1)*int(T/deltat)/N,:],U)*deltax - find_nearest(mesh[(k)*int(T/deltat)/N,:],U)*deltax)/(int(T/deltat)/N)

# print("Finished calculating velocities")

# fig = mpl.figure()
# mpl.plot(x[0],mesh[25/deltat,:])
# y = np.exp(-(x[0]-0.002*25)/0.1)
# mpl.plot(x[0],y)
# mpl.show()


fig = mpl.figure()
ax = fig.add_subplot(111, projection='3d')
norm = colors.Normalize()
ax.plot_surface(x,t.T,mesh, rstride = 400, cstride=50, facecolors=cm.jet(mesh), alpha=0.8, linewidth=0, antialiased=True)
ax.set_xlabel('x')
ax.set_ylabel('t')
ax.set_zlabel('u')
ax.set_title('Fisher wave (r=1, D=1)')

# mpl.savefig("plot.pdf", format='pdf')

# mesh2 = np.zeros(shape=(int(T/deltat)-1,int(X/deltax)))
# for i in range(0,(int(T/deltat)-2)):
# 	for j in range(0,(int(X/deltax)-1)):
# 		mesh2[i][j] = (mesh[i+1][j] - mesh[i][j])/(deltat)

# x1 = np.zeros(shape=(int(T/deltat)-1,int(X/deltax)))
# for i in range(0,int(T/deltat)-1): 
# 	x1[i] = x1[i] + np.linspace(1,X,num=(X/deltax))

# t1 = np.zeros(shape=(int(X/deltax),int(T/deltat)-1))
# for j in range(0,int(X/deltax)): 
# 	t1[j] = t1[j] + np.linspace(1,T,num=((T/deltat)-1))

# fig = mpl.figure()
# ax = fig.add_subplot(111, projection='3d')
# ax.plot_surface(x1,t1.T,mesh2, rstride = 400, cstride=50, cmap=cm.jet, alpha=0.8, linewidth=0, antialiased=True)
# ax.set_xlabel('x')
# ax.set_ylabel('t')
# ax.set_zlabel('Velocity')
# ax.set_title('Fisher wave (r=1, D=1)')

# mpl.savefig('plot2.pdf', format='pdf')