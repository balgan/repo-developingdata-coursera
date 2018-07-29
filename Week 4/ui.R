library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Airports in the USA"),

  sidebarLayout(
    sidebarPanel(
       checkboxGroupInput("airport_choose", label = "Choose a type of airport",
                          choices = c("medium_airport","large_airport"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("airportPlot")
    )
  )
))
