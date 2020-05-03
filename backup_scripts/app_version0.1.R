library(shiny)
library(shinyjs)
library(tidyverse)
library(readxl)
library(stringr)
library(stringi)
library(knitr)
library(kableExtra)

report_date <- NULL

ui <- fluidPage(

    # Application title
    titlePanel("VHK Situation Report"),
    h3(paste0("Date of Report:", "")),
    textOutput("date_of_report"),
    br(),
    
    fileInput("file1", "Choose Excel File"),

    # Sidebar with a slider input for number of bins 
    tabsetPanel(
        tabPanel(
            "Night Capacity Report",
            br(),
            
            # htmlOutput("patient_summary"),
            
            div(id = "night_report",
                fluidRow(
                    fixedRow(column(4, h4("PATIENT SUMMARY"),
                                    htmlOutput("patient_summary"),
                                    tags$style(HTML("#patient_summary {background-color: #dfd8d4}"))),
                             column(7, h4("EMERGENCY DEPARTMENT"),
                                    htmlOutput("ed_summary"),
                                    tags$style(HTML("#ed_summary {background-color: #dfd8d4}"))),
                            ),
                    column(12,
                           h4("MEDICINE"),
                           fixedRow(
                               column(2, 
                                      "Bed Compliment", textOutput("med_compliment"), tags$head(tags$style(HTML("#med_compliment {background-color: black}", "#med_compliment {color: white}", "#med_compliment {font-size: 24px}"))),
                                      "Empty Beds", textOutput("med_empty"), tags$head(tags$style(HTML("#med_empty {background-color: black}", "#med_empty {color: white}", "#med_empty {font-size: 24px}")))
                                      ),
                               column(2, 
                                      "Total Patients", textOutput("med_total"),tags$head(tags$style(HTML("#med_total {background-color: black}", "#med_total {color: white}", "#med_total {font-size: 24px}"))),
                                      "No. > 5 Days", textOutput("med_5d"),tags$head(tags$style(HTML("#med_5d {background-color: black}", "#med_5d {color: white}", "#med_5d {font-size: 24px}"))),
                                      "No. Boarded Yesterday", textOutput("med_boarders"),tags$head(tags$style(HTML("#med_boarders {background-color: black}", "#med_boarders {color: white}", "#med_boarders {font-size: 24px}"))),
                                      )
                               )
                           )
                    )
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    reportDate <- reactive({
        
        req(input$file1)
        
        report_date <- read_excel(input$file1$datapath, sheet = 1, range = "G3", col_names = F)
        
        report_date <- report_date[[1]]
        
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
    
    
    # No longer needed as the patient summary separated into the directorate
    
    # output$patient_summary <- renderText({
    #     patients_kable <- night_patients() %>% 
    #         select(Specialty,
    #                Total, 
    #                "Number > 5 Days" = Five_Days,
    #                "New Patients Boarded Yesterday" = Boarders)
    #     
    #     kable(patients_kable, "html", booktabs = T) %>%
    #         kable_styling(full_width = FALSE, position = "center", font_size = 12) %>% 
    #         row_spec(0, bold = T) %>%
    #         column_spec(1, bold = T) %>%
    #         column_spec(3, color = "white", background = "#ea3e50", width = "10em") %>%
    #         column_spec(4, color = "white", background = "#ea3e50", width = "10em") %>%
    #         column_spec(c(1,2), background = "#84beec")
    #         
    # })
    # 
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
    
    output$med_compliment <- renderText({
        night_medicine()[[15, 2]]
        
    })
    
    output$med_empty <- renderText({
        night_medicine()[[15, 3]]
    })
    
    output$med_total <- renderText({
        night_patients()[[1, 2]]
    })
    
    output$med_5d <- renderText({
        night_patients()[[1, 3]]
    })
    
    output$med_boarders <- renderText({
        night_patients()[[1, 4]]
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
