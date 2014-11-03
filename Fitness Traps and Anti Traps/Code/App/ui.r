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

	titlePanel("Cancer Visulisations"),

	sidebarLayout(

	sidebarPanel( 
		selectInput("dataSet", label = "Choose data set", choices = uIDs, width = '250px'),

		tableOutput('Parameters'),

		width = 3 	
	
	),

	mainPanel(
			plotOutput("Displacement", height = 200, width = 600), 
			plotOutput("Velocity", height = 200, width = 600),
			plotOutput("Variance", height = 200, width = 600),	
			plotOutput("Populations", height = 200, width = 600)	
		)

	)

	)
)
