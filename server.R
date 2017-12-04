library(shiny)
library(dplyr)
library(leaflet)
library(plyr)
library(ggplot2)

data1 <- data.table::fread("data.cvs")
server <- function(input, output) {
  output$summary1 <- renderText({
    print("This map reveals a geographic disstribution of terrorism activity.")
  })
  
  output$distPlot1 <- renderLeaflet({
    dm <- data1 %>% filter(iyear == input$yaer, country_txt == input$country)
    leaflet(data = dm) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude, popup = paste("Date:",dm$iyear,dm$imonth,dm$iday,"<br>",
                                                      "Attact Type:",dm$attacktype1_txt,"<br>",
                                                      "Target:", dm$targtype1_txt,"<br>",
                                                      "Motive:",dm$motive,"<br>",
                                                      "Weapon Type:", dm$weaptype1_txt
                                                      ))
  })
  
  output$distPlot2 <- renderDataTable({
    dm <- data1 %>% filter(iyear == input$yaer, country_txt == input$country)
    data2 <- dm %>% select(iyear,imonth,iday,attacktype1_txt,targtype1_txt,weaptype1_txt,city)
    data2
  },
    options = list(lengthMenu = c(5, 10, 33), pageLength = 5))
  
  output$linechart <- renderPlot({
    terrorism <- ddply(data1, .(iyear, country_txt), summarize, number=n())
    specific_country <- dplyr::filter(terrorism, country_txt == input$country)
    Number <- terrorism$number
    Year <- unique(terro$iyear)
    plot <- ggplot(data=specific_country) + 
      geom_line(mapping=aes(x = iyear, y =number)) + 
      geom_point(mapping=aes(x = iyear, y =number))+ 
      labs(x = "Years", y = "Frequence")
    plot
  })
}