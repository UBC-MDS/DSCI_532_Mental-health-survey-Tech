#

# This is a Shiny web application. You can run the application by clicking

# the 'Run App' button above.

#

# Find out more about building applications with Shiny here:

#

#    http://shiny.rstudio.com/

#


library(shiny)
library(tidyverse)
library(ggplot2)

# Load data
data <- read.csv("../data/survey.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  
  # Application title
  titlePanel("Mental Health Survey Data",
             
             windowTitle = "Mental Health app"), 
  
  # Sidebar with a select input for countries
  
  sidebarLayout(
    
    sidebarPanel(
      
      radioButtons("countryInput", "Country:",
                   
                     choices = c("United States", "Canada", "United Kingdom", 
                                 "Germany", "Ireland", "Netherlands",
                                 "Australia", "France", "India","New Zealand")),
      
      sliderInput("ageInput",
                  
                  "Age Range:",
                  
                  min = 1, max = 99,
                  
                  value = c(20,60))
      
      #selectInput("attitudeInput", "Attitude",
                     #choices = c("How easy is it for you to take medical leave for a mental health condition?",
                                 #"Do you think that discussing a health issue with your employer would have negative consequences?",
                                 #"Would you be willing to discuss a mental health issue with your colleagues?",
                                 #"Would you bring up a health issue with a potential employer in an interview?",
                                 #"Do you feel that your employer takes mental health as seriously as physical health?",
                                 #"Have you heard of or observed negative consequences for coworkers with mental health conditions in your workplace?"))
  ),
  
  mainPanel(
    
    tabsetPanel(
      
    tabPanel("Personal Background",
             
             plotOutput("selfemployed_plot")),
    
    tabPanel("Work Background", 
             
             plotOutput("options_plot")))
    
    )
  )

)

server <- function(input, output){
  
  observe(print(input$countryInput))
  
  data_filtered <- reactive({
    
    data %>% 
      
      filter(Country == input$countryInput,
             
             seek_help %in% c("Yes","No"),
             
             Age < input$ageInput[2],
             
             Age > input$ageInput[1])
    
  })
  
  output$options_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(care_options,fill = seek_help)) +
      
      geom_bar() +
      
      theme(legend.position = "top") +
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw()
    
  })
  
  output$selfemployed_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(self_employed,fill = seek_help)) +
      
      geom_bar() +
      
      theme(legend.position = "top") +
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw()
    
  })
  
}

shinyApp(ui = ui, server = server)