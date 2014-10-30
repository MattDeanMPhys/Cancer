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

	output$text1 <- renderText({
		paste(input$dataSet)
	})

	output$Parameters <- renderDataTable( {

		paramsFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		params = read.csv(paramsFileName, sep = "\t", head = F)

		params }, options = list(paging=FALSE, searching = FALSE)
	)

})
