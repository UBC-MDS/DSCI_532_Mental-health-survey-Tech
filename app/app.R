# tidy_data.R
# Sabrina Kakei Tse and Ting Pan, Jan 18 2019

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# Find out more about building applications with Shiny here:
#    http://shiny.rstudio.com/
#


library(shiny)
library(tidyverse)
library(ggplot2)


# Load data
data <- read.csv("../data/tidy_data.csv", stringsAsFactors = FALSE)

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
      
      radioButtons("genderInput", "Gender:",
                   
                   choices = c("male", "female", "trans")),
      
      sliderInput("ageInput",
                  
                  "Age Range:",
                  
                  min = 15, max = 50,
                  
                  value = c(20,40))
      
      
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
    
    tabPanel("Company support", 
             
             plotOutput("benefits_plot"),
             
             br(), 
             
             plotOutput("options_plot"),
             
             br(),
             
             plotOutput("program_plot"),
             
             br(),
             
             plotOutput("help_plot")),
             
    
    
    
    tabPanel("Attitudes",
             
             "Bring up a mental vs. physical health in interview:",
             
             br(), 
             
             plotOutput("mental_health_interview_plot"),
             
             br(),
             
             plotOutput("phys_health_interview_plot"),
             
             br(), br(),

             "Mental vs. Physical health consequence:",
             
             br(), 
             
             plotOutput("mental_health_consequence_plot"),
             
             br(),
             
             plotOutput("phys_health_consequence_plot"),
             
             br(), br(),
             
             "Discuss with coworkers vs. supervisor(s):",
             
             br(),
             
             plotOutput("coworkers_plot"),
             
             br(),
             
             plotOutput("supervisor_plot")))
             
             
    )
    
    )
  )



server <- function(input, output){
  
  observe(print(input$countryInput))
  
  data_filtered <- reactive({
    
    data %>% 
      
      filter(Country == input$countryInput,
             
             Gender == input$genderInput,
             
             Age < input$ageInput[2],
             
             Age > input$ageInput[1])
    
  })
  
  
  
  output$benefits_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(benefits,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Benefits",
        
        y = "",
        
        title = "Comparison about benefits")
    
  })
  
  
  output$options_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(care_options,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Care Options",
        
        y = "",
        
        title = "Comparison about care options")
    
  })
  
  
  output$program_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(wellness_program,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Wellness program",
        
        y = "",
        
        title = "Comparison about wellness program")
    
  })
  
  
  output$help_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(seek_help,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Resources of help",
        
        y = "",
        
        title = "Comparison about resources of help")
    
  })
  
  
  
  output$mental_health_consequence_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(mental_health_consequence,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Mental health consequence",
        
        y = "",
        
        title = "Comparison about mental health consequence")
    
  })
  
  
  output$phys_health_consequence_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(phys_health_consequence,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Physical health consequence",
        
        y = "",
        
        title = "Comparison about physical health consequence")
    
  })
  
  
  
  output$coworkers_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(coworkers,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Discuss with coworkers",
        
        y = "",
        
        title = "Comparison about discussing with coworkers")
    
  })
  
  
  output$supervisor_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(supervisor,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Discuss with supervisor(s)",
        
        y = "",
        
        title = "Comparison about discussing with supervisor(s)")
    
  })
  
  
  output$mental_health_interview_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(mental_health_interview,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Mental health in interview",
        
        y = "",
        
        title = "Comparison about mental health in interview")
    
  })

  
  
  output$phys_health_interview_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(phys_health_interview,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "Physical health in interview",
        
        y = "",
        
        title = "Comparison about physical health in interview")
    
  })
  

}

shinyApp(ui = ui, server = server)