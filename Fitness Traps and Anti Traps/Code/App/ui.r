library(shiny)

fileList = list.files()
dfiles = grep("[^a-z]{5}", fileList, value= T)
IDs = sub("_FixationTimes.txt", "", dfiles)
IDs = sub("_Populations.txt", "", IDs)
IDs = sub("_StatisticOutput.txt", "", IDs)
IDs = sub("_Parameters.txt", "", IDs)
uIDs = unique(IDs)

statfileList = list.files()[grep("Stat", list.files())]
paramfileList =  list.files()[grep("Param", list.files())]

shinyUI(fluidPage(

	titlePanel("Hello World"),

	sidebarLayout(

	sidebarPanel( 
		selectInput("dataSet", label = "Choose data set", choices = uIDs, width = '400px'),

		dataTableOutput('Parameters')	
	
	),

	mainPanel(

		plotOutput("Displacement")

	)

	)
))
