

trapdata = read.csv("trapdata.txt", header=T, sep="\t")
trapdata = read.csv("antitrapdata.txt", header=T, sep="\t")
flatdata = read.csv("data.txt", header=T, sep="\t")

ggplot(trapdata, aes(Time, Displacement)) + geom_line() + geom_line(data = flatdata, aes(Time, Displacement), linetype='dashed')

ggplot(trapdata, aes(Time, Variance)) + geom_line() + geom_line(data = flatdata, aes(Time, Variance), linetype='dashed')

ggplot(antitrapdata, aes(Time, Displacement)) + geom_line() + geom_line(data = flatdata, aes(Time, Displacement), linetype='dashed')

ggplot(antitrapdata, aes(Time, Variance)) + geom_line() + geom_line(data = flatdata, aes(Time, Variance), linetype='dashed')
