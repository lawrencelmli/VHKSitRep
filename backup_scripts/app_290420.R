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
      
      menuItem("How to Use", tabName = "instructions", icon = icon("book-open")),
      
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
      tabItem(tabName = "instructions", h3("How to Generate Report"),
              p("To use this app, please upload the relevant Excel file using the upload buttons, 
                then click on the links to see the report"),
              p("The reports during CoViD-19 period are found under the CoViD-19 item on the left."),
              p("Copyright (c) Lawrence Li")
              ),
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
      
      tabItem(tabName = "covid_night", h3("Night Capacity Report COVID-19"),
              div(style="display: inline-block;vertical-align:top; ", p("Date of COVID Report: ")), 
              div(style="display: inline-block;vertical-align:top; ", textOutput("COVID_date")),
              
              fluidRow(
                box(title = "OVERALL SUMMARY", width = 12, collapsible = T,
                    infoBoxOutput("nrc_electives", width = 2),
                    infoBoxOutput("nrc_predicted", width = 3),
                    infoBoxOutput("nrc_total", width = 2),
                    infoBoxOutput("nrc_admissions", width = 3),
                    infoBoxOutput("nrc_remain", width = 3),
                    infoBoxOutput("nrc_beds", width = 2),
                    infoBoxOutput("nrc_dc_expected", width = 3)
                    ),
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("nrc_ED_1", width = 2),
                    infoBoxOutput("nrc_ED_2", width = 2),
                    infoBoxOutput("nrc_ED_3", width = 2),
                    infoBoxOutput("nrc_ED_4", width = 2),
                    infoBoxOutput("nrc_ED_5", width = 3)
                    ),
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(box(title = "FLOW - SUMMARY", width = 12, collapsible = T, 
                      column(width = 6,
                        htmlOutput("nrc_flow_sum")
                        ),
                        fluidRow(
                          infoBoxOutput("trauma_flow", width = 2),
                          infoBoxOutput("SEAL_flow", width = 3)
                          ),
                        fluidRow(
                          box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                            htmlOutput("nrc_red_flow")
                            ),
                          box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T, 
                            htmlOutput("nrc_green_flow")
                            ),
                          box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                            htmlOutput("nrc_wac")
                            ),
                          box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                            htmlOutput("nrc_critcare")
                            )
                          )
                        )
                      ),
                fluidRow(
                  box(title = "Assessment Units", width = 12, collapsible = T, 
                      fluidRow(
                        box(title = "AU One", width = 12,
                            infoBoxOutput("au1_px", width = 2),
                            infoBoxOutput("au1_beds", width = 2),
                            infoBoxOutput("au1_dc", width = 2),
                            infoBoxOutput("au1_ongoing", width = 2),
                            infoBoxOutput("au1_gp", width = 2)
                            )
                        ),
                      fluidRow(
                        box(title = "AU Two", width = 12,
                            infoBoxOutput("au2_px", width = 2),
                            infoBoxOutput("au2_beds", width = 2),
                            infoBoxOutput("au2_dc", width = 2),
                            infoBoxOutput("au2_ongoing", width = 2),
                            infoBoxOutput("au2_gp", width = 2)
                            )
                        )
                      )
                    )
                    
                    
                    ),
                
                box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                    htmlOutput("nrc_add")
                    
                    )
                    
                
              )
              
              
              ), #/"Night Report COVID-19"
      tabItem(tabName = "covid_safety", h3("Safety Huddle COVID-19"),
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                           infoBoxOutput("shc_ed1", width = 2),
                           infoBoxOutput("shc_ed2", width = 2)
                    )
                ),
              fluidRow(
                box(title = "CRITICAL CARE BEDS", width = 12, collapsible = T,
                    infoBoxOutput("shc_cc1", width = 2),
                    infoBoxOutput("shc_cc2", width = 2),
                    infoBoxOutput("shc_cc3", width = 2),
                    infoBoxOutput("shc_cc4", width = 2),
                    infoBoxOutput("shc_cc5", width = 2),
                    infoBoxOutput("shc_cc6", width = 2)
                    )
              )
                
              
              ), #/tabItem "safety COVID-19"
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
  

# COVID Section -----------------------------------------------------------
  
  nrc_summary <- reactive({
    
    req(input$file2)
    
    sum_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B7:E13", col_names = F) %>%
      select("Summary" = ...1,
             "Numbers" = ...4)
    
    return(sum_nrc)
    
  })
  
  output$nrc_electives <- renderInfoBox({
    infoBox("Electives", value = nrc_summary()[[1, 2]], color = "blue")
  })
  output$nrc_predicted <- renderInfoBox({
    infoBox("Predicted Emergency Admissions", value = nrc_summary()[[2, 2]], color = "red", icon = icon("hospital"))  
  })
  output$nrc_total <- renderInfoBox({
    infoBox("Total", value = nrc_summary()[[3, 2]], color = "blue", icon = icon("calculator"))
  })
  output$nrc_admissions <- renderInfoBox({
    infoBox("Admissions So Far", value = nrc_summary()[[4, 2]], color = "blue", icon = icon("hospital"))
  })
  output$nrc_remain <- renderInfoBox({
    infoBox("Remaining Today", value = nrc_summary()[[5, 2]], color = "blue", icon = icon("clipboard"))
  })
  output$nrc_beds <- renderInfoBox({
    color_bed <- function(){
      if(nrc_summary()[[6, 2]] >= 15){
        colour <- "green"
      }else if(nrc_summary()[[6, 2]] < 15 & nrc_summary()[[6, 2]] >= 10){
        colour <- "orange"
      }else if(nrc_summary()[[6, 2]] < 10){
        colour <- "red"
      }
  
      return(colour)  
    }
    
    infoBox("Beds Available", value = nrc_summary()[[6, 2]], color = color_bed(), icon = icon("bed"))
  })
  
  output$nrc_dc_expected <- renderInfoBox({
    infoBox("Expected Discharges", value = nrc_summary()[[7, 2]], color = "blue", icon = icon("home"))
  })
  
  nrc_ed <- reactive({
    req(input$file2$datapath)
    
    ed_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I18:M18", col_names = F)
    
    new_col <- c("Total", "Longest", "Assess", "DTA", "Breaches")
    
    colnames(ed_nrc) <- new_col
    
    if(is.character(ed_nrc$Longest) == F){
      ed_nrc$Longest <- format(ed_nrc$Longest, "%T")
    }else{
      ed_nrc$Longest < ed_nrc$Longest
    }
    
    if(is.character(ed_nrc$Assess) == F){
      ed_nrc$Assess <- format(ed_nrc$Assess, "%T")
    }else{
      ed_nrc$Assess < ed_nrc$Assess
    }
      
    return(ed_nrc)
    
  })
  
  output$nrc_ED_1 <- renderInfoBox({
    infoBox("Total Number", value = nrc_ed()[[1, 1]], color = "blue", icon = icon("procedures"))
  })
  output$nrc_ED_2 <- renderInfoBox({
    infoBox("Longest Wait", value = nrc_ed()[[1, 2]], color = "red", icon = icon("clock"))
  })
  output$nrc_ED_3 <- renderInfoBox({
    infoBox("Time to Assessment", value = nrc_ed()[[1, 3]], color = "red", icon = icon("stopwatch"))
  })
  output$nrc_ED_4 <- renderInfoBox({
    infoBox("Number with DTA", value = nrc_ed()[[1, 4]], color = "orange", icon = icon("hospital"))
  })
  output$nrc_ED_5 <- renderInfoBox({
    infoBox("Breaches since Midnight", value = nrc_ed()[[1, 5]], color = "purple", icon = icon("stopwatch"))
  })
  
  nrc_flow <- reactive({
    
    req(input$file2)
    
    flow_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B18:G42", col_names = F)
    
    colnames(flow_nrc) <- c("Ward", "Compliment", "Empty", "Electives", "DC_Expected", "DC_Achieved")
    
    flow_nrc[8, 1] <- "22 Red"
    flow_nrc[12, 1] <- "34 Red"
    
    redzones <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    flow_nrc <- flow_nrc %>%
      mutate("RedZone" = ifelse(Ward %in% redzones, T, F))
    
    flow_nrc$Empty <- as.numeric(flow_nrc$Empty)
    
    return(flow_nrc)
    
  })
  
  output$nrc_red_flow <- renderText({
    
    nrc_flow.df <- nrc_flow() 
    
    nrc_red <- nrc_flow.df %>%
      filter(RedZone == T) %>%
      select(-7) 
    
    nrc_red$Empty <- as.double(nrc_red$Empty)
    
    nrc_red <- nrc_red %>%
      mutate(Empty.color = cell_spec(Empty, "html", background = if_else(Empty >= 5, "#56b34b", "#c64040", "#1b1c21"))) %>% 
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.color,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
             )
      
    
    kable(nrc_red, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(nrc_red), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
    })
  
  output$nrc_green_flow <- renderText({
    
    nrc_flow.df <- nrc_flow() 
    
    nrc_green <- nrc_flow.df %>%
      filter(RedZone == F) %>%
      select(-7) 
    
    nrc_green$Empty <- as.double(nrc_green$Empty)
    
    nrc_green <- nrc_green %>%
      mutate(Empty.color = cell_spec(Empty, "html", background = if_else(Empty >= 5, "#56b34b", "#c64040", "#1b1c21"))) %>% 
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.color,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
      )
    
    
    kable(nrc_green, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(nrc_green), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  output$nrc_flow_sum <- renderText({
    df <- nrc_flow()
    
    df$Empty <- as.numeric(df$Empty)
    
    flow_red <- df %>%
      filter(RedZone == T) %>%
      select(-7)
    
    
    red_total <- data.frame(Ward = "Red Total",
                            Compliment = colSums(flow_red[, 2], na.rm = T),
                            Empty = colSums(flow_red[, 3], na.rm = T),
                            Electives = colSums(flow_red[, 4], na.rm = T),
                            DC_Expected = colSums(flow_red[, 5], na.rm = T),
                            DC_Achieved = colSums(flow_red[, 6], na.rm = T)
    )
    
    flow_green <- df %>%
      filter(RedZone == F) %>%
      select(-7)
    
    
    green_total <- data.frame(Ward = "Green Total",
                              Compliment = colSums(flow_green[, 2], na.rm = T),
                              Empty = colSums(flow_green[, 3], na.rm = T),
                              Electives = colSums(flow_green[, 4], na.rm = T),
                              DC_Expected = colSums(flow_green[, 5], na.rm = T),
                              DC_Achieved = colSums(flow_green[, 6], na.rm = T)
    )
    
    sum_flow <- rbind(red_total, green_total)
    
    
    total_both <- data.frame(Ward = "Sum Total",
                             Compliment = sum(sum_flow[1:2, 2]),
                             Empty = sum(sum_flow[1:2, 3]),
                             Electives = sum(sum_flow[1:2, 4]),
                             DC_Expected = sum(sum_flow[1:2, 5]),
                             DC_Achieved = sum(sum_flow[1:2, 6])
                             )
    
    sum_flow <- rbind(sum_flow, total_both)
    
    rownames(sum_flow) <- NULL
    
    sum_flow <- sum_flow %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
      )
    
    kable(sum_flow, "html") %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1, align = "center", background = "#c64040", color = "white") %>%
      row_spec(2, align = "center", background = "#56b34b", color = "white") %>%
      row_spec(3, align = "center", background = "#5f6fa2", bold = T, color = "white") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), color = "black")
    
    })
  
  output$trauma_flow <- renderInfoBox({
    req(input$file2)
    trauma_list <- read_excel(input$file2$datapath, sheet = 2, range = "B44:E44", col_names = F)
    
    trauma_list <- trauma_list[, -2]
    
    infoBox(title = "Trauma List", value = trauma_list[1, 3], icon = icon("bone"), color = "blue")
  })
  
  output$SEAL_flow <- renderInfoBox({
    
    df <- nrc_flow()
    
    infoBox(title = "SEAL Electives", value = df[[25, 4]], icon = icon("procedures"), color = "blue")
    
  })
  
  output$nrc_wac <- renderText({
    req(input$file2)
    
    wac_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B49:G59", col_names = F)
    
    colnames(wac_nrc) <- c("Ward", "Compliment", "Empty", "Electives", "DC_Expected", "DC_Achieved")
    
    wac_nrc_wards <- c("Delivery Suite Red",
                       "Observation Unit Red",
                       "Maternity Ward Red",
                       "Delivery Suite",
                       "IOL",
                       "Observation Unit",
                       "Maternity Ward",
                       "Children's Ward",
                       "Children's Ward Red",
                       "Neonatal Unit",
                       "Neonatal Unit Red")
    wac_nrc[, 1] <- wac_nrc_wards
    
    wac_nrc <- wac_nrc %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
      )
    
    kable(wac_nrc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  au <- reactive({
    req(input$file2)
    
    au1_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I36:M36", col_names = F)
    au2_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I43:M43", col_names = F)
    
    au_nrc <- rbind(au1_nrc, au2_nrc) %>%
      mutate("Ward" = c("AU 1", "AU2"))
    au_nrc <- au_nrc[, c(6, 1:5)]
    
    colnames(au_nrc) <- c("Ward", "Patients", "Required", "DC", "Ongoing", "GPTCI")
    
    return(au_nrc)

    
  })
  
  output$au1_px <- renderInfoBox({
    infoBox("Patients Now", value = au()[[1,2]], color = "blue")
  })
  output$au1_beds <- renderInfoBox({
    infoBox("Beds Required", value = au()[[1,3]], color = "orange", icon = icon("bed"))
  })
  output$au1_dc <- renderInfoBox({
    infoBox("Discharges", value = au()[[1,4]], color = "green", icon = icon("home"))
  })
  output$au1_ongoing <- renderInfoBox({
    infoBox("Ongoing Assessment", value = au()[[1,5]], color = "orange", icon = icon("clipboard"))
  })
  output$au1_gp <- renderInfoBox({
    infoBox("To Come In", value = au()[[1,6]], color = "red", icon = icon("ambulance"))
  })
  
  output$au2_px <- renderInfoBox({
    infoBox("Patients Now", value = au()[[2,2]], color = "blue")
  })
  output$au2_beds <- renderInfoBox({
    infoBox("Beds Required", value = au()[[2,3]], color = "orange", icon = icon("bed"))
  })
  output$au2_dc <- renderInfoBox({
    infoBox("Discharges", value = au()[[2,4]], color = "green", icon = icon("home"))
  })
  output$au2_ongoing <- renderInfoBox({
    infoBox("Ongoing Assessment", value = au()[[2,5]], color = "orange", icon = icon("clipboard"))
  })
  output$au2_gp <- renderInfoBox({
    infoBox("To Come In", value = au()[[2,6]], color = "red", icon = icon("ambulance"))
  })
  
  output$nrc_critcare <- renderText({
    
    req(input$file2)
    
    critcare_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I25:N30", col_names = F)
    
    colnames(critcare_nrc) <- c("Ward", "Empty", "Fit", "Admissions", "Discharges", "Compliment")
    
    cc_wards <- c("ITU Red", "ITU Green", "SHDU Green", "MHDU Red", "RHDU", "CCU/MHDU Green")
    
    critcare_nrc[, 1] <- cc_wards
    
    critcare_nrc <- critcare_nrc %>%
      select("Ward" = Ward,
             "Empty Beds" = Empty,
             "Fit for Discharge" = Fit,
             "Admissions Today" = Admissions,
             "Discharges Expected" = Discharges,
             "Bed Compliment" = Compliment)
    
    kable(critcare_nrc, "html") %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  output$COVID_date <- renderText({
    req(input$file2)
    
    report_date <- read_excel(input$file2$datapath, sheet = 2, range = "C4", col_names = F)
    
    report_date <- report_date[[1]]
    
    if(is.character(report_date) == F){
      report_date <- as.character(report_date)
    }else{
      report_date < report_date
    }
    
    return(report_date)
    
    report_date
  })
  
  output$nrc_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I49:M52", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
    })
  
  ed_shc <- reactive({
    req(input$file2)
    
    shc_ed <- read_excel(input$file2$datapath, sheet = 1, range = "B3:E3", col_names = F)
    
    shc_ed <- select(shc_ed, total = 2, DTA = 4)
    
    return(shc_ed)
  })
  
  output$shc_ed1 <- renderInfoBox({
    infoBox("Total in ED", value = ed_shc()[[1,1]], color = "blue")
  })
  
  output$shc_ed2 <- renderInfoBox({
    infoBox("No. with DTA", value = ed_shc()[[1,2]], color = "blue")
  })
  
  output$shc_cc1 <- renderInfoBox({
    shc_icu_red <- read_excel(input$file2$datapath, sheet = 1, range = "C5:C5", col_names = F)
    
    infoBox(title = "ICU Red", value = shc_icu_red[[1,1]], color = "red", fill = T)
  })
  
  output$shc_cc2 <- renderInfoBox({
    shc_icu_green <- read_excel(input$file2$datapath, sheet = 1, range = "E5", col_names = F)
    
    infoBox(title = "ICU Green", value = shc_icu_green[[1,1]], color = "green", fill = T)
  })
  
  output$shc_cc3 <- renderInfoBox({
    shc_rhdu <- read_excel(input$file2$datapath, sheet = 1, range = "G5", col_names = F)
    
    infoBox(title = "Renal HDU", value = shc_rhdu[[1,1]], color = "green", fill = T)
  })
  
  output$shc_cc4 <- renderInfoBox({
    shc_mhdu <- read_excel(input$file2$datapath, sheet = 1, range = "C6", col_names = F)
    
    infoBox(title = "MHDU Red", value = shc_mhdu[[1,1]], color = "green", fill = T)
  })
  
  
}


shinyApp(ui, server)