library(tidyverse)
library(shiny)
library(DT)
library(plotly)

#####create some data to interact with in the application
####could import data with read_csv or a similar function here if you wanted.

cities = c("Hong Kong","Macau","Dubai")

city1 <- data.frame("city"=rep(cities[1],5),
                    "year"=as.integer(seq(from=1990,to=1994,by=1)),
                    #"unit"=letters[1:5],
                    "var1"=round(runif(5,0,5),0),
                    "var2"=round(runif(5,0,5),0),
                    "var3"=round(runif(5,0,5),0))
city2 <- data.frame("city"=rep(cities[2],5),
                    "year"=as.integer(seq(from=1990,to=1994,by=1)),
                    #"unit"=letters[1:5],
                    "var1"=round(runif(5,0,5),0),
                    "var2"=round(runif(5,0,5),0),
                    "var3"=round(runif(5,0,5),0))
city3 <- data.frame("city"=rep(cities[3],5),
                    "year"=as.integer(seq(from=1990,to=1994,by=1)),
                    #"unit"=letters[1:5],
                    "var1"=round(runif(5,0,5),0),
                    "var2"=round(runif(5,0,5),0),
                    "var3"=round(runif(5,0,5),0))

all_data <- bind_rows(city1,city2,city3)

##################################################################################################################
########################################################## Shiny #################################################
##################################################################################################################

ui <- fluidPage(
  h1("This is a sample H1 html header"),
  p("This is some sample p html text"),
  
  h2("Text Input"),
  textInput(inputId = "text",
            label = "Enter some text here",
            value = "This your entered text (you can replace it)"),
  
  h2("Text Output"),
  textOutput(outputId = "text_output"),
  
  h2("Print Output"),
  p("With print output, whatever your R console produced from an expression will be printed in the Shiny app. This is not usually preferred, because it is going to be unattractive."),
  verbatimTextOutput(outputId = "print1"),
  
  h2("Slider Input with Two Sliders"),
  sliderInput(inputId = "year1",
              label = "Select Year",
              min = 1990,
              max = 1994,
              value = c(1990, 1994),
              sep = ""),  
  
  h2("Checkbox Input"),
  checkboxGroupInput(inputId = "city1",
                     label = "Which City Do you Want to Display?",
                     choices = cities,
                     selected = cities),
  
  h2("A standard table"),
  tableOutput(outputId = "table1"),
  
  h2("A data table"),
  dataTableOutput(outputId = "table2"),

  h2("A standard plot"),
  plotOutput(outputId = "plot1"),
  
  h2("A plotly plot"),
  plotlyOutput(outputId = "plot2")
)



server <- function(input, output) {
  
  output$text_output <- renderText({input$text})
  
  output$print1 <- renderPrint({table(all_data$var1)})
  
  output$table1 <- renderTable({
    dplyr::filter(all_data, city %in% input$city1 & year >= input$year1[1] & year <= input$year1[2])})
  
  output$table2 <- renderDataTable({
    dplyr::filter(all_data, city %in% input$city1 & year >= input$year1[1] & year <= input$year1[2])})
  
  output$plot1 <- renderPlot({
    ggplot2::ggplot(dplyr::filter(all_data, city %in% input$city1 & year >= input$year1[1] & year <= input$year1[2]),
                    mapping = aes(x = var1, y = var2)) +
      ggplot2::geom_point()})
  
  output$plot2 <- renderPlotly({
    ggplot2::ggplot(dplyr::filter(all_data, city %in% input$city1 & year >= input$year1[1] & year <= input$year1[2]),
                    mapping = aes(x = var1)) +
      ggplot2::geom_histogram()})
}

# Run the application 
shinyApp(ui = ui, server = server)
