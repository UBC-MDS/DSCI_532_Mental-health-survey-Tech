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
library(shinythemes)


# Load data
data <- read.csv("tidy_data.csv", stringsAsFactors = FALSE)

ui <- fluidPage( theme = shinytheme("simplex"),
  
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
                  
                  min = 15, max = 60,
                  
                  value = c(15,60)),
      
      
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
             
             br(),
             
             fluidRow(
               
               # Display the four plots
               
               splitLayout(cellWidths = c("50%", "50%"), plotOutput("benefits_plot"), plotOutput("options_plot")),
               splitLayout(cellWidths = c("50%", "50%"), plotOutput("program_plot"), plotOutput("help_plot"))
               
               )),
    
    # Second Tab - Attitudes of Question
    
    tabPanel("Attitudes",
             
             h5("In this section, employees' responses to the attitude questions are summarized in graphs."),
             
             br(),
             
             column(12, align="center",
             
             # Display the attitude plot
                    
             plotOutput("plot"))),
    
    # Third Tab - Info about dataset
    
    tabPanel("About",
             
             h5("In this section, the number of observations per country and per gender are plotted in bar graphs."),
             
             h5("NOTE: this tab is meant for general information only so it is not interactive with the filtered options"),
             
             br(),
             
             column(12, align="center",
             
             plotOutput("country_plot"),
             
             br(),
             
             fluidRow(
             
               splitLayout(cellWidths = c("40%", "60%"), plotOutput("gender_plot"), plotOutput("age_plot"))))
             
             
    )))))



server <- function(input, output){
  
  observe(print(input$countryInput))
  
  # Filter data
  
  data_filtered <- reactive({
    
    data %>% 
      
      filter(if (input$countryInput != "All"){
        
                 Country == input$countryInput}
             
             else {Country == data$Country},
             
             
             if (input$genderInput != "All"){ 
             
                 Gender == input$genderInput}
             
             else {Gender == data$Gender},
             
             
             Age < input$ageInput[2],
             
             Age > input$ageInput[1])
    })
  
  # Data count for each country
  
  data_info <- reactive({
    
    data %>% 
      
      group_by(Country) %>% 
      
      summarise(n=n()) %>% 
      
      arrange(desc(n)) %>% 
      
      head(10)
    
  })
  
  # Data count for gender
  
  data_info_gender <- reactive({
    
    data %>% 
      
      group_by(Gender) %>% 
      
      summarise(n=n()) %>% 
      
      arrange(desc(n))
    
  })
  
  
  # Data count for age group
  
  data_info_age <- reactive({
    
    data %>% 
      mutate(agegroup= factor(case_when(
        .$Age <  20 ~ "<20",
        .$Age >= 20 & .$Age <= 29 ~ "20-29",
        .$Age >= 30 & .$Age <= 39 ~"30-39",
        .$Age >= 40 & .$Age <= 49 ~  "40-49",
        .$Age >= 50 ~ ">50"))) %>% 
      
      group_by(agegroup) %>% 
      
      summarise(n=n())
    
  })
  
  
  # Plot of data count for each country
  
  
  output$country_plot <- renderPlot({
    
    data_info() %>% 
      
      ggplot(aes(x = Country,y = n)) +
      
      geom_bar(stat = "identity", fill = "#FC8D62") +
      
      geom_text(aes(label=n), position=position_dodge(width=0.9), vjust=-0.25) +
      
      
      theme_bw() +
      
      labs(
        
        x = "country",
        
        y = "count",
        
        title = "country vs. observations count") +
      
      theme(
        
        axis.text.x = element_text(angle = 45, hjust = 1 ),
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12)
      )
    
  },height = 400, width = 700)
  
  
  # Plot of data count for gender
  
  
  output$gender_plot <- renderPlot({
    
    data_info_gender() %>% 
      
      ggplot(aes(x = Gender,y = n)) +
      
      geom_bar(stat = "identity", width = 0.5, fill = "#66C2A5") +
      
      geom_text(aes(label=n), position=position_dodge(width=0.9), vjust=-0.25) +
      
      theme_bw() +
      
      labs(
        
        x = "gender",
        
        y = "count",
        
        title = "gender vs. observations count") +
      
      theme(
      
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12)
      )
    
  })
  
  
  
  # Plot of data count for age
  
  
  output$age_plot <- renderPlot({
    
    data_info_age() %>% 
      
      ggplot(aes(x = agegroup,y = n)) +
      
      geom_bar(stat = "identity", width = 0.5, fill = "#66C2A5") +
      
      scale_x_discrete(limits=c("<20","20-29","30-39","40-49",">50")) +
      
      geom_text(aes(label=n), position=position_dodge(width=0.9), vjust=-0.25) +
      
      theme_bw() +
      
      labs(
        
        x = "age",
        
        y = "count",
        
        title = "age vs. observations count") +
      
      theme(
        
        
        plot.title = element_text(size=14, face="bold.italic"),
        
        axis.title.x = element_text(size=14, face="bold"),
        
        axis.title.y = element_text(size=14, face="bold"),
        
        axis.text = element_text(size=12)
      )
    
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
      
      geom_bar(position='dodge', show.legend=FALSE, width = 0.5)+
      
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
    
  },height = 400, width = 700)
  

}

shinyApp(ui = ui, server = server)