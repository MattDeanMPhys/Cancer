import matplotlib.pyplot as plt

a = [1, 4, 5, 2, 8, 9, 4, 6, 1, 0, 6]
b = [4, 7, 8, 3, 0, 9, 6, 2, 3, 6, 7]
c = [9, 0, 7, 6, 5, 6, 3, 4, 1, 2, 2]

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(a,b,c=c, s=50)

plt.show()