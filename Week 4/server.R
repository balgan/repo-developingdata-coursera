library(shiny)
library(leaflet)

df <- read.csv("airports.csv", sep = ",", header = TRUE)

df_filtered <- df[,c("type","name","latitude_deg", "longitude_deg", "iso_country")]

df_filtered <- df_filtered[df_filtered$iso_country == "US", ]
df_filtered <- df_filtered[(df_filtered$type == "large_airport" | df_filtered$type == "medium_airport"), ]


df_filtered <- df_filtered[complete.cases(df_filtered), ]

df_filtered$name <- as.character(df_filtered$name)

colnames(df_filtered)[3] <- "lat"
colnames(df_filtered)[4] <- "lon"


# Define server logic
shinyServer(function(input, output, session) {
   
  #data manipulation
  
  data_1 <- reactive({df_filtered[df_filtered$type %in% input$airport_choose,]})
  
  output$airportPlot <- renderLeaflet({
  data_1() %>% leaflet %>% addTiles() %>% setView(-98.35, 39.7,
                                                  zoom = 4) %>%
      addCircleMarkers(clusterOptions = markerClusterOptions(), data = data_1(), 
                       lng = ~ lon, lat = ~ lat, 
                       popup = paste("Airport name:", df_filtered$name, "<br>","Size:", data_1()$type))
    })
  
})



