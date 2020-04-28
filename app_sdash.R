library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(readxl)
library(stringr)
library(stringi)
library(knitr)
library(kableExtra)

ui <- dashboardPage(
  dashboardHeader(title = "VHK Situation Report"),
  dashboardSidebar(
    h4("Report Date: "),
    textOutput("date_of_report"),
    
    fileInput("file1", "Upload Excel Here"),
    
    menuItem("Night Capacity Report", tabName = "night_report", icon = icon("file-alt")),
    menuItem("Safety Huddle", tabName = "safety", icon = icon("clipboard")),
    menuItem("08:30", tabName = "eight_thirty", icon = icon("clock")),
    menuItem("13:00", tabName = "one_pm", icon = icon("clock")),
    menuItem("17:00", tabName = "five_pm", icon = icon("clock")),
    menuItem("19:00", tabName = "seven_pm", icon = icon("clock"))
    
    ), #/dashboardSidebar
  dashboardBody(
    tabItems(
      tabItem(tabName = "night_report", h3("Night Capacity Report"),
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 7, htmlOutput("ed_summary"))
                ), #/fluidRow
              fluidRow(
                box(title = "MEDICINE", width = 12,
                    fluidRow(
                      infoBoxOutput("med_compliment", width = 2),
                      infoBoxOutput("med_empty", width = 2)
                    ),
                    fluidRow(
                      infoBoxOutput("med_total_px", width = 2),
                      infoBoxOutput("med_5d", width = 2),
                      infoBoxOutput("med_boarders", width = 4)
                    )
                    )
                )
              ), #/tabItem "night_report"
      tabItem(tabName = "safety", h3("Safety Huddle")), #/tabItem "safety"
      tabItem(tabName = "eight_thirty", h3("Situation Report at 8:30")), #/tabItem "eight_thirty"
      tabItem(tabName = "one_pm", h3("Situation Report at 13:00")), #/tabItem "one_pm"
      tabItem(tabName = "five_pm", h3("Situation Report at 17:00")), #/tabItem "five_pm"
      tabItem(tabName = "seven_pm", h3("Situation Report at 19:00")) #/tabItem "seven_pm"
      
    ) #/tabItems
  ) #/dashboardBody
) #/dashboardPage

server <- function(input, output){
  reportDate <- reactive({
    
    req(input$file1)
    
    report_date <- read_excel(input$file1$datapath, sheet = 1, range = "G3", col_names = F)
    
    report_date <- report_date[[1]]
    
    if(is.character(report_date) == F){
      report_date <- as.character(report_date)
    }else{
      report_date < report_date
    }
    
    return(report_date)
  })
  
  output$date_of_report <- renderText({
    reportDate()
  })
  
  night_patients <- reactive({
    req(input$file1)
    
    patients <- read_excel(input$file1$datapath, sheet = 1, range = "J13:M15", col_names = F)
    
    colnames(patients) <- c("Specialty", "Total", "Five_Days", "Boarders")
    
    return(patients)
  })
  
  ED_summary <- reactive({
    req(input$file1)
    
    ed <- read_excel(input$file1$datapath, sheet = 1, range = "F8:M8", col_names = F)
    
    colnames(ed) <- c("Total",
                      "Longest",
                      "Time_to_Assess",
                      "Three_hours",
                      "DTA",
                      "Breaches",
                      "EMOU",
                      "Attendence")
    
    if(is.character(ed$Longest) == F){
      ed$Longest <- format(ed$Longest, "%T")
    }else{
      ed$Longest < ed$Longest
    }
    
    if(is.character(ed$Time_to_Assess) == F){
      ed$Time_to_Assess <- format(ed$Time_to_Assess, "%T")
    }else{
      ed$Time_to_Assess < ed$Time_to_Assess
    }
    
    
    return(ed)
  })
  
  output$ed_summary <- renderText({
    ed_kable <- ED_summary() %>%
      rename("Total Number in ED" = Total,
             "Longest Wait" = Longest,
             "Longest Time to First Assessment" = Time_to_Assess,
             "Number of Patients > 3 Hours" = Three_hours,
             "Number of Patients with DTA" = DTA,
             "Number of Patients Breached since Midnight" = Breaches,
             "Number in EMOU (6)" = EMOU,
             "Attendences since Midnight" = Attendence)
    
    kable(ed_kable, "html", booktabs = T) %>%
      kable_styling(full_width = F, position = "center", font_size = 12) %>% 
      row_spec(0, bold = T) %>%
      column_spec(c(1:3, 7:8), color = "red") %>%
      column_spec(4, color = "white", background = "#ea3e50") %>%
      column_spec(c(5, 6), color = "white", background = "#a380b6")
  })
  
  night_medicine <- reactive({
    
    req(input$file1)
    
    medicine <- read_excel(input$file1$datapath, sheet = 1, range = "A8:C21", col_names = F)
    
    colnames(medicine) <- c("Ward", "Compliment", "Empty")
    
    total_med <- c("Total",
                   colSums(medicine[, 2]), 
                   colSums(medicine[, 3]))
    
    medicine <- rbind(medicine, total_med)
    
    return(medicine)
  })
  
  output$med_compliment <- renderInfoBox({
    infoBox(
      "Bed Compliment", night_medicine()[[15, 2]], icon = icon("hospital"),
      color = "purple"
    )
  })
  
  colour_empty_night <- reactive({
    if(night_medicine()[[15, 3]] >= 30){
      colour <- "green"
    }else if(night_medicine()[[15, 3]] >= 15 & night_medicine()[[15, 3]] < 30){
      colour <- "orange"
    }else if(night_medicine()[[15, 3]] < 15){
      colour <- "red"
    }
    
    return(colour)
  })
  
  colour_empty_med_ward <- reactive({
    for (i in seq_along(night_medicine())) {
      colour <- "purple"
      
      if(night_medicine()[[i, 3]] >= 10){
        colour <- "green"
      }else if(night_medicine()[[i, 3]] >= 5 & night_medicine()[[15, 3]] < 10){
        colour <- "orange"
      }else if(night_medicine()[[i, 3]] < 5){
        colour <- "red"
      }
      
      return(colour)
    }
  })
  
  output$med_empty <- renderInfoBox({
    infoBox(
      "Empty Beds", night_medicine()[[15, 3]], icon = icon("bed"),
      color = colour_empty_night()
    )
  })
  
  output$med_total_px <- renderInfoBox({
    infoBox(
      "Total Patients", night_patients()[[1, 2]], icon = icon("procedures"),
      color = "purple"
    )
  })
  
  output$med_5d <- renderInfoBox({
    infoBox(
      "No. more than 5 Days", night_patients()[[1, 3]], icon = icon("stopwatch"),
      color = "red"
    )
  })
  
  output$med_boarders <- renderInfoBox({
    infoBox(
      "No. Boarded Yesterday", night_patients()[[1, 4]], icon = icon("passport"),
      color = "red"
    )
  })
  
}


shinyApp(ui, server)