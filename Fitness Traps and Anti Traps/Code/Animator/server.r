library(ggplot2)
library(reshape2)
source("TrapDrawer.r")


theme_set(theme_bw())

themeBase = theme_bw() + theme(axis.text.y = element_blank(), axis.ticks = element_blank())

shinyServer(function(input, output){


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
		graphPopulations = ggplot(rowData, aes(CellType, Population, group = 1)) + geom_point() + geom_line()+ themeBase
		graphPopulations = graphPopulations + theme(axis.text.x = element_blank()) + scale_y_continuous(limits=c(0,1000))
		graphPopulations

	})

	output$FitnessLandscape <- renderPlot({

		parametersFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		data = read.csv(parametersFileName, sep = "\t", head = F, stringsAsFactors = F, strip.white = T)

		landscapeFit = TrapDrawer(data, "F")

		graphLandscape = ggplot(landscapeFit, aes(CellType, Value)) + themeBase + geom_line()
		graphLandscape = graphLandscape + ylab("Fitness") + scale_x_continuous(limits=c(0,50), expand=c(0,0))
		graphLandscape

	})

	output$MutationLandscape <- renderPlot({

		parametersFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		data = read.csv(parametersFileName, sep = "\t", head = F, stringsAsFactors = F, strip.white = T)

		landscapeMut = TrapDrawer(data, "M")

		graphLandscape = ggplot(landscapeMut, aes(CellType, Value)) + themeBase + geom_line()
		graphLandscape = graphLandscape + ylab("Mutation") + scale_x_continuous(limits=c(0,50), expand=c(0,0))
		graphLandscape

	})

output$Parameters <- renderTable( {

		paramsFileName = paste(input$dataSet, "_Parameters.txt", sep="")
		params = read.csv(paramsFileName, sep = "\t", head = F)
		names(params) = c("Parameters", "Value")		

		params }, options = list(paging=FALSE, searching = FALSE)
	)

})
