mesh2 = np.zeros(shape=(int(T/deltat)-1,int(X/deltax)))
for i in range(0,(int(T/deltat)-2)):
	for j in range(0,(int(X/deltax)-1)):
		mesh2[i][j] = (mesh[i+1][j] - mesh[i][j])/(deltat)

x1 = np.zeros(shape=(int(T/deltat)-1,int(X/deltax)))
for i in range(0,int(T/deltat)-1): 
	x1[i] = x1[i] + np.linspace(1,X,num=(X/deltax))

t1 = np.zeros(shape=(int(X/deltax),int(T/deltat)-1))
for j in range(0,int(X/deltax)): 
	t1[j] = t1[j] + np.linspace(1,T,num=((T/deltat)-1))

fig = mpl.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x1,t1.T,mesh2, rstride = 400, cstride=50, cmap=cm.jet, alpha=0.8, linewidth=0, antialiased=True)
ax.set_xlabel('x')
ax.set_ylabel('t')
ax.set_zlabel('Velocity')
ax.set_title('Fisher wave (r=1, D=1)')

mpl.savefig('plot2.pdf', format='pdf')