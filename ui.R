data1 <- data.table::fread("data.cvs")
library(leaflet)
library(shiny)

names<-colnames(data1)
names[2]<-"year"
names[3]<-"month"
names[4]<-"day"
names[6]<-"country"
names[11]<-"attack_type"
names[12]<-"target_type"
names[14]<-"weapon_type"
colnames(data1)<-names

ui <- fluidPage(
  tags$h2("This map reveals a geographic disstribution of terrorism activity."),
  titlePanel("Terrorism Map"),
  sidebarPanel(
    selectInput(inputId = "country",
                label = "Choose a country:",
                choices = unique(data1$country)),
    
    selectInput(inputId = "yaer",
                label = "Choose a year:",
                choices = unique(data1$year)),
    
    textOutput(outputId = "summary")),
  
  mainPanel(
    leafletOutput(outputId = "distPlot1"), 
    dataTableOutput(outputId = "distPlot2"),
    plotOutput("linechart")
  )
)  