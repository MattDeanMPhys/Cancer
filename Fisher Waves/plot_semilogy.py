from matplotlib2tikz import save as tikz_save

xmin = 0
xmax = 70

xd = x[0,xmin/deltax : xmax/deltax]
yd = np.log(mesh[25/deltat, xmin/deltax : xmax/deltax])

# # sort the data
# reorder = sorted(range(len(xd)), key = lambda ii: xd[ii])
# xd = [xd[ii] for ii in reorder]
# yd = [yd[ii] for ii in reorder]

# make the scatter plot
mpl.scatter(xd, yd, s=20, alpha=0.15, marker='o')

# determine best fit line
par = np.polyfit(xd, yd, 1, full=True)

slope=par[0][0]
intercept=par[0][1]
xl = [min(xd), max(xd)]
yl = [slope*xx + intercept  for xx in xl]

# # coefficient of determination, plot text
# variance = np.var(yd)
# residuals = np.var([(slope*xx + intercept - yy)  for xx,yy in zip(xd,yd)])
# Rsqr = np.round(1-residuals/variance, decimals=2)
# mpl.text(.9*max(xd)+.1*min(xd),.9*max(yd)+.1*min(yd),'$R^2 = %0.2f$'% Rsqr, fontsize=30)

# mpl.xlabel("X Description")
# mpl.ylabel("Y Description")

# # error bounds
# yerr = [abs(slope*xx + intercept - yy)  for xx,yy in zip(xd,yd)]
# par = np.polyfit(xd, yerr, 2, full=True)

# yerrUpper = [(xx*slope+intercept)+(par[0][0]*xx**2 + par[0][1]*xx + par[0][2]) for xx,yy in zip(xd,yd)]
# yerrLower = [(xx*slope+intercept)-(par[0][0]*xx**2 + par[0][1]*xx + par[0][2]) for xx,yy in zip(xd,yd)]

mpl.plot(xl, yl, '-r')
# mpl.plot(xd, yerrLower, '--r')
# mpl.plot(xd, yerrUpper, '--r')

# mpl.show()
tikz_save( 'myfile.tikz' );
