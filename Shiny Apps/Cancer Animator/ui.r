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
titlePanel("Cancer Populations Animator by Dean Markwick 2014"),
	  sidebarLayout(
	   sidebarPanel( 
		selectInput("dataSet", label = "Choose data set", choices = uIDs, width = '250px'),
		tableOutput('Parameters'),

		width = 3,

		sliderInput("integer", "Time", min = 1, max = 1000, value = 1, step = 1, animate=animationOptions(interval=300)),
	
		a("Dean Markwick", href = "http://dm13450.github.io")
	   ),

	mainPanel(
			plotOutput("Populations", height = 250, width = 500),
			plotOutput("FitnessLandscape", height = 100, width = 500),
			plotOutput("MutationLandscape", height = 100, width = 500)	
	
		 )
	 
	)

	



)
)
