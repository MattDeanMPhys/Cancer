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

p

shinyUI(fluidPage(

	titlePanel("Cancer Visulisations"),

	sidebarLayout(

	sidebarPanel( 
		selectInput("dataSet", label = "Choose data set", choices = uIDs, width = '250px'),

		tableOutput('Parameters'),

		width = 3,


		numericInput("integer", "Time", min = 1, max = 100, value = 1, step = 1)
	
	),

	mainPanel(

		fluidRow(
		 column(4,
			plotOutput("Displacement", height = 150, width = 300), 
			plotOutput("Velocity", height = 150, width = 300),
			plotOutput("Variance", height = 150, width = 300)
		       ),
		column(3, offset =1,	
			plotOutput("Populations", height = 300, width = 500),
			plotOutput("FitnessLandscape", height = 150, width = 500)	
		      )
		)
	)

	)

	)
)
