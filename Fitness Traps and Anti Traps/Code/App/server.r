library(ggplot2)


theme_set(theme_bw())

themeBase = theme_bw() + theme(axis.text.y = element_blank(), axis.ticks = element_blank())

shinyServer(function(input, output){

	output$Displacement <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")

		graphDisp = ggplot(data, aes(Time, Displacement)) + geom_line() + themeBase 
		graphDisp
	})
	output$Velocity <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")

		graphVelocity = ggplot(data, aes(Time, Velocity)) + geom_smooth(se=F, colour="black") + themeBase 
		graphVelocity
	})

	output$Variance <- renderPlot({
		
		statsFileName = paste(input$dataSet, "_StatisticOutput.txt", sep="")
		data = read.csv(statsFileName, sep = "\t")

		graphVariance = ggplot(data, aes(Time, Variance)) + geom_line() + themeBase 
		graphVariance
	})

	output$Populations <- renderPlot({
		
		populationsFileName = paste(input$dataSet, "_Populations.txt", sep="")
		data = read.csv(populationsFileName, sep = "\t", head = F)

		rowData = data[1,]
			
#		graphPopulations = ggplot(rowData) + geom_bar() + themeBase
		graphPopulations = barplot(rowData)		
		graphPopulations

	})


output$Parameters <- renderTable( {

		paramsFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		params = read.csv(paramsFileName, sep = "\t", head = F)
		names(params) = c("Parameters", "Value")		

		params }, options = list(paging=FALSE, searching = FALSE)
	)

})
