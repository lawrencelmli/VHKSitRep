library(shiny)
library(shinyjs)
library(tidyverse)
library(readxl)
library(stringr)
library(stringi)
library(knitr)
library(kableExtra)


ui <- fluidPage(

    # Application title
    titlePanel("VHK Situation Report"),
    h3(paste0("Date of Report:", "")),
    textOutput("date_of_report"),
    br(),
    
    fileInput("file1", "Upload SitRep Excel"),
    
    fileInput("file2", "Upload CoViD-19 SitRep Excel"),

    # Sidebar with a slider input for number of bins 
    tabsetPanel(
        tabPanel(
            "Night Capacity Report",
            br(),
            
            # htmlOutput("patient_summary"),
            
            div(id = "night_report",
                fluidRow(
                    fixedRow(column(7, h4("EMERGENCY DEPARTMENT"),
                                    htmlOutput("ed_summary"),
                                    tags$style(HTML("#ed_summary {background-color: #dfd8d4}"))),
                            ),
                    column(12,
                           h4("MEDICINE"),
                           fixedRow(
                               column(1, 
                                      "Bed Compliment", textOutput("med_compliment"), tags$head(tags$style(HTML("#med_compliment {background-color: #609AB2}", "#med_compliment {color: white}", "#med_compliment {font-size: 24px}"))),
                                      "Empty Beds", textOutput("med_empty"), tags$head(tags$style(HTML("#med_empty {background-color: #6DAB63}", "#med_empty {color: white}", "#med_empty {font-size: 24px}")))
                                      ),
                               column(1, 
                                      "Total Patients", textOutput("med_total"),tags$head(tags$style(HTML("#med_total {background-color: #609AB2}", "#med_total {color: white}", "#med_total {font-size: 24px}"))),
                                      "No. > 5 Days", textOutput("med_5d"),tags$head(tags$style(HTML("#med_5d {background-color: #ea3e50}", "#med_5d {color: white}", "#med_5d {font-size: 24px}"))),
                                      "No. Boarded Yesterday", textOutput("med_boarders"),tags$head(tags$style(HTML("#med_boarders {background-color: #ea3e50}", "#med_boarders {color: white}", "#med_boarders {font-size: 24px}"))),
                                      ),
                               column(2,
                                      "AU One", textOutput("au1_empty"), tags$head(tags$style(HTML("#au1_empty {background-color: #6DAB63}", "#au1_empty {color: white}", "#au1_empty {font-size: 24px}"))),
                                      "Ward 13", textOutput("w13_empty"), tags$head(tags$style(HTML("#w13_empty {background-color: #6DAB63}", "#w13_empty {color: white}", "#w13_empty {font-size: 24px}"))),
                                      "Ward 9", textOutput("w9_empty"), tags$head(tags$style(HTML("#w9_empty {background-color: #6DAB63}", "#w9_empty {color: white}", "#w9_empty {font-size: 24px}"))),
                                      ),
                               column(2,
                                      "Ward 22", textOutput("w22_empty"), tags$head(tags$style(HTML("#w22_empty {background-color: #6DAB63}", "#w22_empty {color: white}", "#w22_empty {font-size: 24px}"))),
                                      "Ward 23", textOutput("w23_empty"), tags$head(tags$style(HTML("#w23_empty {background-color: #6DAB63}", "#w23_empty {color: white}", "#w23_empty {font-size: 24px}"))),
                                      ),
                               column(2,
                                      "Ward 32", textOutput("w32_empty"), tags$head(tags$style(HTML("#w32_empty {background-color: #6DAB63}", "#w32_empty {color: white}", "#w32_empty {font-size: 24px}"))),
                                      "Ward 33", textOutput("w33_empty"), tags$head(tags$style(HTML("#w33_empty {background-color: #6DAB63}", "#w33_empty {color: white}", "#w33_empty {font-size: 24px}"))),
                                      "Ward 34", textOutput("w34_empty"), tags$head(tags$style(HTML("#w34_empty {background-color: #6DAB63}", "#w34_empty {color: white}", "#w34_empty {font-size: 24px}"))),
                                      ),
                               column(2,
                                      "Ward 41", textOutput("w41_empty"), tags$head(tags$style(HTML("#w41_empty {background-color: #6DAB63}", "#w41_empty {color: white}", "#w41_empty {font-size: 24px}"))),
                                      "Ward 42", textOutput("w42_empty"), tags$head(tags$style(HTML("#w42_empty {background-color: #6DAB63}", "#w42_empty {color: white}", "#w42_empty {font-size: 24px}"))),
                                      "Ward 43", textOutput("w43_empty"), tags$head(tags$style(HTML("#w43_empty {background-color: #6DAB63}", "#w43_empty {color: white}", "#w43_empty {font-size: 24px}"))),
                                      "Ward 44", textOutput("w44_empty"), tags$head(tags$style(HTML("#w44_empty {background-color: #6DAB63}", "#w44_empty {color: white}", "#w44_empty {font-size: 24px}"))),
                                      ),
                               column(2,
                                      "Ward 51", textOutput("w51_empty"), tags$head(tags$style(HTML("#w51_empty {background-color: #6DAB63}", "#w51_empty {color: white}", "#w51_empty {font-size: 24px}"))),
                                      "Ward 54", textOutput("w54_empty"), tags$head(tags$style(HTML("#w54_empty {background-color: #6DAB63}", "#w54_empty {color: white}", "#w54_empty {font-size: 24px}"))),
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
    
    output$au1_empty <- renderText({night_medicine()[[1, 3]]})
    output$w13_empty <- renderText({night_medicine()[[2, 3]]})
    output$w9_empty <- renderText({night_medicine()[[3, 3]]})
    output$w22_empty <- renderText({night_medicine()[[4, 3]]})
    output$w23_empty <- renderText({night_medicine()[[5, 3]]})
    output$w32_empty <- renderText({night_medicine()[[6, 3]]})
    output$w33_empty <- renderText({night_medicine()[[7, 3]]})
    output$w34_empty <- renderText({night_medicine()[[8, 3]]}) 
    output$w41_empty <- renderText({night_medicine()[[9, 3]]}) 
    output$w42_empty <- renderText({night_medicine()[[10, 3]]})
    output$w43_empty <- renderText({night_medicine()[[11, 3]]})
    output$w44_empty <- renderText({night_medicine()[[12, 3]]})
    output$w51_empty <- renderText({night_medicine()[[13, 3]]})
    output$w54_empty <- renderText({night_medicine()[[14, 3]]})
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
