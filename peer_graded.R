library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# reference code: Pages.R

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)

dat %>% 
  dplyr::group_by(ideo5) %>% 
  dplyr::count(pid7) -> dat_2

#####Make your app

ui <- 
  ui <- navbarPage(
    title="My Application",
    tabPanel("Page 1",
             sidebarPanel(
             sliderInput(
               inputId = "slider",
               label = "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
               min = 1,
               max = 5,
               value = 3,
               sep= "",
               width = 500)),
             mainPanel(
               tabsetPanel(
                 id = "tab1",
                 tabPanel(
                   title = "tab1",
             plotOutput("plot1")),
             tabPanel(
               title = "tab2",
               plotOutput("plot2")
             ))
    )),
    tabPanel("Page 2"),
    tabPanel("Page 3")
  )

  
  
server<-function(input,output){
    output$plot1 <- renderPlot({
      
      plot_dat <- dplyr::filter(dat_2, ideo5 == input$slider)
      
      ggplot2::ggplot(plot_dat, mapping = aes(x = pid7, y = n)) +
        ggplot2::geom_bar(stat = "identity") +
        ggplot2::coord_cartesian(ylim = c(0, 100), xlim = c(0, 8)) +
        ggplot2::labs(x = "7 Point Party ID, 1 = Very D, 7 = Very R",
                      y = "Count")
    })

    
  } 

shinyApp(ui,server)


#####Hint: when you make the data table on page 3, you may need to adjust the height argument in the dataTableOutput function. Try a value of height=500
