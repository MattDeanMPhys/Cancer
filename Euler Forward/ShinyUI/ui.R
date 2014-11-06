library(shiny)
  
  # Application title.
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view. The helpText function is
  # also used to include clarifying text. Most notably, the
  # inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). This is useful if
  # the computations required to render output are inordinately
  # time-consuming.

shinyUI(fluidPage(
  titlePanel("Graph Generator"),
  fluidRow(
    column(3,
      wellPanel(
        h4("Parameters"),
        textInput("base", "Base r/u space:", "1:0.1"),
        numericInput("N", "Number of cells:", 10000),
        numericInput("nummut", "Number of mutations:", 99),        
        numericInput("time", "Total Time:", 1500),        
        textInput("rin", "R param:", ""),
        textInput("uin", "U param:", ""),      
       submitButton("Run Simulation")
      ),
      wellPanel(
        h4("Sliders"),
        sliderInput("timecur", "Time", 0, 1500, value = 1500)
      )
    ),
    column(9,  
      plotOutput('plotD', height='150px'),
      plotOutput('plotR', height='150px'),
      plotOutput('plotU', height='150px'),
      plotOutput('plotV', height='150px'),
      plotOutput('plotA', height='150px'),
      plotOutput('plotVar', height='150px')
      #plotOutput('plotN', height='150px')
    )
  )
))