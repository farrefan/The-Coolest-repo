data1 <- data.table::fread("data.cvs")
library(leaflet)
library(shiny)


ui <- fluidPage(
  titlePanel("Terrorism Map"),
  sidebarPanel(
    selectInput(inputId = "country",
                label = "Choose a country:",
                choices = unique(data1$country_txt)),
    
    selectInput(inputId = "yaer",
                label = "Choose a year:",
                choices = unique(data1$iyear)),
    radioButtons(inputId = "country",
                 label = "Country:",
               choices = unique(data1$country_txt),
               selected = 'United States')),
  mainPanel(
    textOutput("summary1"),
    leafletOutput(outputId = "distPlot1"), 
    dataTableOutput(outputId = "distPlot2"),
    plotOutput('linechart')
  )
  
)  