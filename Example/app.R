library(shiny)
library(tidyverse)
library(rsconnect)

ui <- fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider, 25 is the default start
              ),
  textInput(inputId = "title", # new Id is title
            label = "Write a title",
            value = "Histogram of Random Normal Values"), # starting title
  # visuals are all going to be in the order they are put so the slider comes before plot
  plotOutput("hist"), # creates space for a plot called hist
  verbatimTextOutput("stats") # create a space for stats
)

server <- function(input, output){
  
  # This takes our data from the tibble above, it is "reacting" to the data
  data <- reactive({
    tibble(x = rnorm(input$num)) # 100 random normal points
  })
  
  output$hist <- renderPlot({ # hist in here is the same as plotOutput("hist")
    
    # {} allows us to put all our R code in one nice chunk
    data <- tibble(x = rnorm(100)) # 100 random normal points
    
    ggplot(data(), aes(x = x)) + # make a histogram using df we described earlier
      geom_histogram() +
      labs(title = input$title) #Add a new title
  }) 
  
  output$stats <- renderPrint({
    summary(data()) # calculate summary stats based on the numbers
  })
}

shinyApp(ui = ui, server = server)