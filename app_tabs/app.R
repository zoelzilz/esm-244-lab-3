library(shiny)
library(tidyverse)

# Things we're adding this week: 
# Multiple tabs

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         radioButtons("color",
                      "Pick a color:",
                      choices = c("red",
                                  "blue",
                                  "purple"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          type = "tab",
          tabPanel("Distribution",
                   plotOutput("distPlot")),
          tabPanel("Scatterplot",
                   plotOutput("scatterplot"))
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   output$scatterplot <- renderPlot({
     ggplot(faithful, aes(x = eruptions, y = waiting)) +
     geom_point(color = input$color)
   })
     
}

# Run the application 
shinyApp(ui = ui, server = server)

