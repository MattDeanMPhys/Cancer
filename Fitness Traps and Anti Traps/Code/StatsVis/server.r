library(ggplot2)
library(reshape2)
source("TrapDrawer.r")


theme_set(theme_bw())

themeBase = theme_bw() + theme(axis.text.y = element_blank(), axis.ticks = element_blank())

shinyServer(function(input, output){


	output$Displacement <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")
		
		importantPoint = input$integer

		pointExtract = data.frame(x =  data$Time[importantPoint], y = data$Displacement[importantPoint])

		graphDisp = ggplot(data, aes(Time, Displacement)) + geom_line() + themeBase 
		graphDisp = graphDisp + geom_point( data = pointExtract, aes(x, y), colour = "red")

		graphDisp
	})
	output$Velocity <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")

		importantPoint = input$integer
		pointExtract = data.frame(x =  data$Time[importantPoint], y = data$Velocity[importantPoint])

		graphVelocity = ggplot(data, aes(Time, Velocity)) + geom_smooth(se=F, colour="black") + themeBase 
		graphVelocity = graphVelocity + geom_point(data = pointExtract, aes(x,y), colour = "red")

		graphVelocity
	})

	output$Variance <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")

		importantPoint = input$integer
		pointExtract = data.frame(x =  data$Time[importantPoint], y = data$Variance[importantPoint])

		graphVariance = ggplot(data, aes(Time, Variance)) + geom_line() + themeBase 
		graphVariance = graphVariance + geom_point(data = pointExtract, aes(x,y), colour = "red")
		graphVariance
	})

	output$Populations <- renderPlot({
		
		populationsFileName = paste(input$dataSet, "_Populations.txt", sep="")
		data = read.csv(populationsFileName, sep = "\t", head = F)

		importantPoint = input$integer
		rowData = data[importantPoint,]
		rowData = rowData[-1]
		rowData = rowData[-ncol(rowData)]
		rowData = rowData 
		rowData = melt(rowData)
		colnames(rowData) = c("CellType", "Population")		

		graphPopulations = ggplot(rowData, aes(CellType, Population, group = 1)) + geom_point() + geom_line() + geom_area() + themeBase 
		graphPopulations = graphPopulations + theme(axis.text.x = element_blank()) + scale_x_discrete(expand=c(0,0)) + theme(panel.grid.major= element_blank(), panel.grid.minor=element_blank()) 

		graphPopulations

	})

	output$FitnessLandscape <- renderPlot({

		parametersFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		data = read.csv(parametersFileName, sep = "\t", head = F, stringsAsFactors = F, strip.white = T)

		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		dataStats = read.csv(statsFileName, sep = "\t")




		landscapeFit = TrapDrawer(data, "F")

		CoM = dataStats$Displacement[input$integer]
		CoM_Y = which(round(CoM)==landscapeFit$CellType)

		pointExtract = data.frame(x =  CoM, y = landscapeFit$Value[CoM_Y])

		graphLandscape = ggplot(landscapeFit, aes(CellType, Value)) + themeBase + theme(panel.grid.major= element_blank(), panel.grid.minor=element_blank()) + geom_line()
		graphLandscape = graphLandscape + ylab("Fitness") + geom_point(data = pointExtract, aes(x,y), colour='red') + scale_x_continuous(expand=c(0,0))
		graphLandscape


	})

	output$MutationLandscape <- renderPlot({

		parametersFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		data = read.csv(parametersFileName, sep = "\t", head = F, stringsAsFactors = F, strip.white = T)

		landscapeMut = TrapDrawer(data, "M")

		graphLandscape = ggplot(landscapeMut, aes(CellType, Value)) + themeBase + geom_line() + theme(panel.grid.major= element_blank(), panel.grid.minor=element_blank()) 
		graphLandscape = graphLandscape + ylab("Mutation") + scale_x_continuous(expand=c(0,0))
		graphLandscape

	})

output$Parameters <- renderTable( {

		paramsFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		params = read.csv(paramsFileName, sep = "\t", head = F)
		names(params) = c("Parameters", "Value")		

		params }, options = list(paging=FALSE, searching = FALSE)
	)

})
