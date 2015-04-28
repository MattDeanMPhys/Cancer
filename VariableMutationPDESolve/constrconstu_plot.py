import operator as op

tt=75

func = np.sqrt( ( 1 )/( 2*np.pi*deltax*deltax*u*tt ) ) * np.exp( -( ( u*deltax*tt - x[0] )**2 )/( 2*deltax*deltax*u*tt ) )

pde_max_index, pde_max_value = max(enumerate(mesh[tt/dt,:]), key=op.itemgetter(1))
ana_max_index, ana_max_value = max(enumerate(func), key=op.itemgetter(1))

mpl.subplot(2,1,1)
mpl.plot((pde_max_index*dx, pde_max_index*dx), (0, 0.01), 'r-')
mpl.plot(x[0], mesh[(tt)/dt]*350)
mpl.plot(x[0], func)

# max_diff = np.zeros(shape=(1,int(T/dt)))

# for i in range(1,int(T/dt)):
# 	tt = i*dt 
# 	func = np.sqrt( ( 1 )/( 2*np.pi*deltax*deltax*u*tt ) ) * np.exp( -( ( u*deltax*tt - x[0] )**2 )/( 2*deltax*deltax*u*tt ) )
# 	pde_max_index, pde_max_value = max(enumerate(mesh[tt/dt,:]), key=op.itemgetter(1))
# 	ana_max_index, ana_max_value = max(enumerate(func), key=op.itemgetter(1))
# 	max_diff[0][i] = pde_max_value*dx - ana_max_value*dx

# mpl.subplot(2,1,2)
# mpl.plot(t[0], max_diff[0])

mpl.show()



#45