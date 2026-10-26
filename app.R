library(shiny)
library(tidyverse)
library(gapminder)

ui <- fluidPage(
  titlePanel("Shiny Gapminder"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput(
        "year",
        "Year",
        min = min(gapminder$year),
        max = max(gapminder$year),
        value = min(gapminder$year),
        step = 10,
        sep = ""
      ),
      #drop down list                
      selectInput(
        "selected_continent",
        "Continent",
        choices = c(sort(unique(as.character(gapminder$continent))), "All"), #we use as.character() because continent is a factor stored as 1, 2, 3, 4, 5
        selected = "All"
      ),
      
      radioButtons(
        "x_variable",
        "X",
        choices = c("Life expectancy" = "lifeExp", 
                    "Population" = "pop",
                    "GDP per capita" = "gdpPercap"),
        selected = "gdpPercap"
      ), 
      
      radioButtons(
        "y_variable",
        "Y",
        choices = c("Life expectancy" = "lifeExp", 
                    "Population" = "pop",
                    "GDP per capita" = "gdpPercap"),
        selected = "lifeExp"
      )
    ),
    
    mainPanel(
      
      plotOutput("scatter")
    )
  )
)

server <- function(input, output, session) {
  
  filtered_gapminder <- reactive({
    
   data <- gapminder |>
     
      filter(year == input$year)
   
   if (input$selected_continent != "All") {
     data <- data |>
       filter(continent == input$selected_continent)
   }
   
   data
   
  })
  
  output$scatter <- renderPlot({
    
    dat <- filtered_gapminder()
    
    p <- ggplot(dat,
           aes(x = .data[[input$x_variable]],
               y = .data[[input$y_variable]],
               colour = continent,
               size = pop
           )
          ) +
         geom_point(alpha = 0.5) +
        # scale_colour_brewer(palette = "Set2")+
      scale_colour_manual(
        values = c(
          Africa   = "#C7853D",
          Americas = "#D95A6A",
          Asia     = "#8D5CA6",
          Europe   = "#71A84A",
          Oceania  = "#6F86C9"
        )
      ) +
         scale_size(range = c(2, 18)) +
         theme_minimal() +
    
         theme(legend.position = "none") 

          if (input$x_variable %in% c("pop", "gdpPercap")) {
            p <- p + scale_x_log10()
          }
    
          if (input$y_variable %in% c("pop", "gdpPercap")) {
            p <- p + scale_y_log10()
          }
     p
  })
}

#launch application
shinyApp(ui, server)