library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)

data1 <- data.table::fread("data.cvs")
names<-colnames(data1)
names[2]<-"year"
names[3]<-"month"
names[4]<-"day"
names[6]<-"country"
names[11]<-"attack_type"
names[12]<-"target_type"
names[14]<-"weapon_type"
colnames(data1)<-names
server <- function(input, output) {
    
  output$distPlot1 <- renderLeaflet({
    dm <- data1 %>% filter(year == input$yaer, country == input$country)
    leaflet(data = dm) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude, popup = paste("Date:",dm$year,dm$month,dm$day,"<br>",
                                                      "Attact Type:",dm$attack_type,"<br>",
                                                      "Target:", dm$target_type,"<br>",
                                                      "Motive:",dm$motive,"<br>",
                                                      "Weapon Type:", dm$weapon_type
      ))
  })
  
  output$distPlot2 <- renderDataTable({
    dm <- data1 %>% filter(year == input$yaer, country== input$country)
    data2 <- dm %>% select(year, month, day, attack_type, target_type, weapon_type,city)
    data2
  },
  options = list(lengthMenu = c(5, 10, 33), pageLength = 5))
  
  output$linechart <- renderPlot({
    specific_country <- data1 %>% filter(country == input$country) %>%
      group_by(year) %>% dplyr::summarise(number = n())
    ggplot(data = specific_country) + 
      geom_point(mapping = aes(x = year, y = number)) + 
      geom_smooth(mapping = aes(x = year, y = number)) + 
      labs(x = "Years", y = "Frequence")+
      scale_x_continuous(limits=c(1970,2016),breaks=seq(1970,2016,2))
  })
}