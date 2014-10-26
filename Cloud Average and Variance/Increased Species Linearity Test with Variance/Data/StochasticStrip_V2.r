StripV2 = function(x) {

maxIndex = which(x[,2] == max(x[,2]))

x = x[1:maxIndex,]

return(x)

}
