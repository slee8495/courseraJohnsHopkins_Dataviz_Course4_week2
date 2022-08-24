library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# reference code
# https://github.com/phillyo/intelligentsia/blob/master/ui.R

# https://phillyo.shinyapps.io/intelligentsia/?_ga=2.51242282.2006853199.1661363042-153102189.1641594202

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)


#####Make your app

ui <- 
  ui <- navbarPage(
    title="My Application",
    tabPanel("Page 1",
             sliderInput(
               inputId = "slider",
               label = "Select Five Point Ideology (1=Very liberal, 5=Very conservative",
               min = 1,
               max = 5,
               value = 3,
               sep= "",
               width = 500),
             plotOutput("plot1")
    ),
    tabPanel("Page 2"),
    tabPanel("Page 3")
  )

  
  
  
  
server<-function(input,output){
    

    
  } 

shinyApp(ui,server)


#####Hint: when you make the data table on page 3, you may need to adjust the height argument in the dataTableOutput function. Try a value of height=500
