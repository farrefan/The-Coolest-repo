data1 <- data.table::fread("data.cvs")
library(leaflet)
library(shiny)

country <- unique(data1$country_txt)
ui <- fluidPage(
  titlePanel("Terrorism Map"),
  sidebarPanel(
    selectInput(inputId = "country",
                label = "Choose a country:",
                choices = unique(data1$country_txt)),
    
    selectInput(inputId = "year",
                label = "Choose a year:",
                choices = unique(data1$iyear)),
    radioButtons("country", label = "Country",
               choices = country,
               selected = 'United States')),
  mainPanel(
    textOutput("summary1"),
    leafletOutput(outputId = "distPlot1"), 
    dataTableOutput(outputId = "distPlot2"),
    plotOutput('linechart')
  )
  
)  