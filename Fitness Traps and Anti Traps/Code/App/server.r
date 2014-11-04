library(ggplot2)
library(reshape2)


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
		parametersFileName =  paste(input$dataSet, "_Parameters.txt", sep="")
		
		params = read.csv(parametersFileName, sep = "\t")
		muts = params[2,]
		
		data = read.csv(populationsFileName, sep = "\t", head = F)
			
		importantPoint = input$integer
		rowData = data[importantPoint,]
		rowData = rowData[-1]
		rowData = rowData[-ncol(rowData)]
		rowData = rowData 
		rowData = melt(rowData)
	
		graphPopulations = ggplot(rowData, aes(variable, value, group = 1)) + geom_point() + geom_line()+ themeBase
		graphPopulations = graphPopulations + theme(axis.text.x = element_blank())
		graphPopulations

	})


output$Parameters <- renderTable( {

		paramsFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		params = read.csv(paramsFileName, sep = "\t", head = F)
		names(params) = c("Parameters", "Value")		

		params }, options = list(paging=FALSE, searching = FALSE)
	)

})
