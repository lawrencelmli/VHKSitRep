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
    
    
    sidebarMenu(
      
      h4("Report Date: "),
      textOutput("date_of_report"),
      
      fileInput("file1", "Upload SitREp Excel"),
      
      fileInput("file2", "Upload COVID-19 SitRep Excel"),
      
      menuItem("Night Capacity Report", tabName = "night_report", icon = icon("clipboard")),
    
      menuItem("Safety Huddle", tabName = "safety", icon = icon("exclamation")),
    
      menuItem("08:30", tabName = "eight_thirty", icon = icon("clock")),
    
      menuItem("13:00", tabName = "one_pm", icon = icon("clock")),
    
      menuItem("17:00", tabName = "five_pm", icon = icon("clock")),
    
      menuItem("19:00", tabName = "seven_pm", icon = icon("clock")),
      
      menuItem("CoViD-19", icon = icon("cog"), startExpanded = F,
               
               menuSubItem("Night Capacity Report", tabName = "covid_night", icon = icon("clipboard")),
               menuSubItem("Safety Huddle", tabName = "covid_safety", icon = icon("exclamation")),
               menuSubItem("08:30", tabName = "covid_eight_thirty", icon = icon("clock")),
               menuSubItem("13:00", tabName = "covid_one_pm", icon = icon("clock")),
               menuSubItem("17:00", tabName = "covid_five_pm", icon = icon("clock")),
               menuSubItem("19:00", tabName = "covid_seven_pm", icon = icon("clock"))
               
               )
      
      
      
      ) #/sidebarMenu
    
    ), #/dashboardSidebar
  dashboardBody(
    tabItems(
      tabItem(tabName = "night_report", h3("Night Capacity Report"),
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    htmlOutput("ed_summary"))
                ), #/fluidRow
              fluidRow(
                box(title = "MEDICINE", width = 12, collapsible = T,
                    column(width = 3,
                           infoBoxOutput("med_compliment", width = NULL),
                           infoBoxOutput("med_empty", width = NULL),
                           infoBoxOutput("med_total_px", width = NULL),
                           infoBoxOutput("med_5d", width = NULL),
                           infoBoxOutput("med_boarders", width = NULL)
                      ),
                    column(width = 9, 
                           fluidRow(
                             valueBoxOutput("au1_night", width = 2),
                             valueBoxOutput("w13_night", width = 2),
                             valueBoxOutput("w9_night", width = 2)
                             ),
                           fluidRow(
                             valueBoxOutput("w22_night", width = 2),
                             valueBoxOutput("w23_night", width = 2)
                             ),
                           fluidRow(
                             valueBoxOutput("w32_night", width = 2),
                             valueBoxOutput("w33_night", width = 2),
                             valueBoxOutput("w34_night", width = 2)
                             ),
                           fluidRow(
                             valueBoxOutput("w41_night", width = 2),
                             valueBoxOutput("w42_night", width = 2),
                             valueBoxOutput("w43_night", width = 2),
                             valueBoxOutput("w44_night", width = 2)
                             ),
                           fluidRow(
                             valueBoxOutput("w51_night", width = 2),
                             valueBoxOutput("w54_night", width = 2)
                             )
                           )
                    ),
                box(title = "SURGERY", width = 12, collapsible = T)
                )
              ), #/tabItem "night_report"
      tabItem(tabName = "safety", h3("Safety Huddle")), #/tabItem "safety"
      tabItem(tabName = "eight_thirty", h3("Situation Report at 8:30")), #/tabItem "eight_thirty"
      tabItem(tabName = "one_pm", h3("Situation Report at 13:00")), #/tabItem "one_pm"
      tabItem(tabName = "five_pm", h3("Situation Report at 17:00")), #/tabItem "five_pm"
      tabItem(tabName = "seven_pm", h3("Situation Report at 19:00")), #/tabItem "seven_pm"
      
      tabItem(tabName = "covid_night", h3("Night Capacity Report COVID-19")), #/Night Report COVID-19
      tabItem(tabName = "covid_safety", h3("Safety Huddle COVID-19")), #/tabItem "safety COVID-19"
      tabItem(tabName = "covid_eight_thirty", h3("Situation Report at 8:30 COVID-19")), #/tabItem "eight_thirty COVID-19"
      tabItem(tabName = "covid_one_pm", h3("Situation Report at 13:00 COVID-19")), #/tabItem "one_pm COVID-19"
      tabItem(tabName = "covid_five_pm", h3("Situation Report at 17:00 COVID-19")), #/tabItem "five_pm" COVID-19
      tabItem(tabName = "covid_seven_pm", h3("Situation Report at 19:00 COVID-19"))
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
             "Number of Patients more than 3 Hours" = Three_hours,
             "Number of Patients with DTA" = DTA,
             "Number of Patients Breached since Midnight" = Breaches,
             "Number in EMOU (6)" = EMOU,
             "Attendences since Midnight" = Attendence)
    
    kable(ed_kable, "html", booktabs = T) %>%
      kable_styling(full_width = F, position = "center") %>% 
      row_spec(0, bold = T, font_size = 15, align = "center", background = "#4d749a", color = "white") %>%
      row_spec(1, bold = T, font_size = 20, align = "center") %>%
      column_spec(c(1:3, 7:8), color = "red") %>%
      column_spec(4, color = "white", background = "#ea3e50") %>%
      column_spec(c(5, 6), color = "white", background = "#a380b6") %>%
      column_spec(c(1:8), border_left = "5px solid white", border_right = "5px solid white", width = "12em")
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
  
  colour_empty_ward <- function(x) {
    cut(as.numeric(x), breaks=c(-Inf, 5, 10, Inf), labels=c("red","orange","green"), right = FALSE)
  }
  
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
  
  output$au1_night <- renderValueBox({
    
    valueBox(
      tags$h3("AU 1", style = "font-size: 150%;"), paste0(night_medicine()[[1,3]], "/", night_medicine()[[1,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[1,3]])
    )
  })
  
  output$w13_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 13", style = "font-size: 150%;"), paste0(night_medicine()[[2,3]], "/", night_medicine()[[2,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[2,3]])
    )
  })
  
  output$w9_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 9", style = "font-size: 150%;"), paste0(night_medicine()[[3,3]], "/", night_medicine()[[3,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[3,3]])
    )
  })
  
  output$w22_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 22", style = "font-size: 150%;"), paste0(night_medicine()[[4,3]], "/", night_medicine()[[4,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[4,3]])
    )
  })
  
  output$w23_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 23", style = "font-size: 150%;"), paste0(night_medicine()[[5,3]], "/", night_medicine()[[5,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[5,3]])
    )
  })
  
  output$w32_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 32", style = "font-size: 150%;"), paste0(night_medicine()[[6,3]], "/", night_medicine()[[6,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[6,3]])
    )
  })
  
  output$w33_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 33", style = "font-size: 150%;"), paste0(night_medicine()[[7,3]], "/", night_medicine()[[7,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[7,3]])
    )
  })
  
  output$w34_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 34", style = "font-size: 150%;"), paste0(night_medicine()[[8,3]], "/", night_medicine()[[8,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[8,3]])
    )
  })
  output$w41_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 41", style = "font-size: 150%;"), paste0(night_medicine()[[9,3]], "/", night_medicine()[[9,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[9,3]])
    )
  })
  output$w42_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 42", style = "font-size: 150%;"), paste0(night_medicine()[[10,3]], "/", night_medicine()[[10,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[10,3]])
    )
  })
  output$w43_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 43", style = "font-size: 150%;"), paste0(night_medicine()[[11,3]], "/", night_medicine()[[11,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[11,3]])
    )
  })
  output$w44_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 44", style = "font-size: 150%;"), paste0(night_medicine()[[12,3]], "/", night_medicine()[[12,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[12,3]])
    )
  })
  output$w51_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 51", style = "font-size: 150%;"), paste0(night_medicine()[[13,3]], "/", night_medicine()[[13,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[13,3]])
    )
  })
  output$w54_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 54", style = "font-size: 150%;"), paste0(night_medicine()[[14,3]], "/", night_medicine()[[14,2]], "Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[14,3]])
    )
  })
  
  
}


shinyApp(ui, server)