# tidy_data.R
# Sabrina Kakei Tse and Ting Pan, Jan 18 2019

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# Find out more about building applications with Shiny here:
#    http://shiny.rstudio.com/
#


# Load packages
library(shiny)
library(tidyverse)
library(ggplot2)


# Load data
data <- read.csv("../data/tidy_data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  
  # Application title
  
  titlePanel("Mental Health Survey Data",
             
             windowTitle = "Mental Health app"), 
  
  # Sidebar with selection for countries, gender, age, and question of interest
  
  sidebarLayout(
    
    sidebarPanel( 
      
      selectInput("countryInput", "Country:",
                   
                     choices = c("All", "United States", "Canada", "United Kingdom", 
                                 "Germany", "Ireland", "Netherlands",
                                 "Australia", "France", "India","New Zealand")),
      
      radioButtons("genderInput", "Gender:",
                   
                   choices = c("All", "Male", "Female", "Other")),
      
      sliderInput("ageInput",
                  
                  "Age Range:",
                  
                  min = 15, max = 50,
                  
                  value = c(15,50)),
      
      
      selectInput("attitudeInput", "Survey Questions:",
                     choices = c("Would you bring up a mental health issue with a potential employer in an interview?"="mental_health_interview",
                                 "Do you think that discussing a mental health issue with your employer would have negative consequences?"="mental_health_consequence",
                                 "Would you be willing to discuss a mental health issue with your colleagues?"="coworkers",
                                 "Would you be willing to discuss a mental health issue with your supervisor(s)?"="supervisor",
                                 "Do you feel that your employer takes mental health as seriously as physical health?"="mental_vs_physical",
                                 "Have you heard of or observed negative consequences for coworkers with mental health conditions in your workplace?"="obs_consequence")),width = 3
  ),
  
  mainPanel(
    
    tabsetPanel(
    
    # First Tab - Corporate Support
    
    tabPanel("Corporate Support", 
             
             h5("In this section, we have summarized how the avaiability of corporate resources affect the number of individuals received mental health treament and those who did not or have not received treatment."),
             
             fluidRow(
               
               # Display the four plots
               
               splitLayout(cellWidths = c("50%", "50%"), plotOutput("benefits_plot"), plotOutput("options_plot")),
               splitLayout(cellWidths = c("50%", "50%"), plotOutput("program_plot"), plotOutput("help_plot"))
               
               )),
    
    # Second Tab - Attitudes of Question
    
    tabPanel("Attitudes",
             
             h5("In this section, employees'responses to the attitude questions are summarized in graphs."),
             
             column(10, align="center",
             
             # Display the attitude plot
                    
             plotOutput("plot")))
             
             
    ))))



server <- function(input, output){
  
  observe(print(input$countryInput))
  
  # Filter data
  
  data_filtered <- reactive({
    
    data %>% 
      
      dplyr::filter(if (input$countryInput != "All"){
        
                 Country == input$countryInput}
             
             else {Country == data$Country},
             
             
             if (input$genderInput != "All"){ 
             
                 Gender == input$genderInput}
             
             else {Gender == data$Gender},
             
             
             Age < input$ageInput[2],
             
             Age > input$ageInput[1])
    })
    
  
  # Benefits Plot
  
  output$benefits_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(benefits,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "",
        
        y = "",
        
        title = "Benefits",
        
        subtitle = "whether the company has mental health benefits" ) +
      
      theme(
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12),
        
        legend.position=c(1,1),
        
        legend.justification=c(1, 0),
        
        legend.direction="horizontal"
      )
    
  })
  
  
  # Care Options Plot
  
  output$options_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(care_options,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "",
        
        y = "",
        
        title = "Care Options",
        
        subtitle = "whether the individual knows about the mental health \n care options provided at work" ) +
      
      theme(
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12),
        
        legend.position=c(1,1),
        
        legend.justification=c(1, 0),
        
        legend.direction="horizontal"
      )
    
  })

  
  # Wellness Program Plot
  
  output$program_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(wellness_program,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "",
        
        y = "",
        
        title = "Wellness Program",
    
        subtitle = "whether the individual has discussed about mental \n health wellness program with their employer" ) +
      
      theme(
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12),
        
        legend.position=c(1,1),
        
        legend.justification=c(1, 0),
        
        legend.direction="horizontal"
      )
    
  })
  
  
  # Help Plot
  
  output$help_plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(seek_help,fill = treatment)) +
      
      geom_bar(position='dodge')+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      coord_flip() +
      
      labs(
        
        x = "",
        
        y = "",
        
        title = "Resources of Help",
        
        subtitle = "whether the employer has provided resources to \n learn more about mental health issues and how to seek help") +
      
      theme(
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12),
        
        legend.position=c(1,1),
        
        legend.justification=c(1, 0),
        
        legend.direction="horizontal"
      )
    
  })
  
  
  # Attitude Plot
  
  output$plot <- renderPlot({
    
    data_filtered() %>% 
      
      ggplot(aes(get(input$attitudeInput),fill=get(input$attitudeInput))) +
      
      geom_bar(position='dodge', show.legend=FALSE)+
      
      scale_fill_brewer(palette="Set2") +
      
      theme_bw() +
      
      
      labs(
        
        x = "response",
        
        y = "count",
        
        title = input$attitudeInput)+
      
      theme(
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12),
        
        legend.position=c(1,1),
        
        legend.justification=c(1, 0),
        
        legend.direction="horizontal"
      )
    
  },height = 400, width = 600)
  

}

shinyApp(ui = ui, server = server)