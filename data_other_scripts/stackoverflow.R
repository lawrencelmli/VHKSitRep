library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Situation Report"),
  dashboardSidebar(
    
    menuItem("Night Capacity Report", tabName = "night_report", icon = icon("file-alt"))
    
    
    
  ), #/dashboardSidebar
  dashboardBody(
    tabItems(
      tabItem(tabName = "night_report", h3("Night Capacity Report"),
              
              fluidRow(
                box(title = "MEDICINE", width = 12,
                    
                    fluidRow(
                      valueBoxOutput("au1_night", width = 3),
                      valueBoxOutput("w13_night", width = 3),
                      valueBoxOutput("w9_night", width = 3)
                    )
                    
                )
              )
      )
      
      
    ) #/tabItems
  ) #/dashboardBody
) #/dashboardPage


server <- function(input, output){
  
  colour_empty_med_ward <- reactive({
    for (i in seq_along(night_medicine)) {
      
      
      if(night_medicine[[i, 3]] >= 10){
        colour_med <- "green"
      }else if(night_medicine[[i, 3]] >= 5 & night_medicine[[i, 3]] < 10){
        colour_med <- "orange"
      }else if(night_medicine[[i, 3]] < 5){
        colour_med <- "red"
      }
      
      return(colour_med)
    }
  })
}

output$au1_night <- renderValueBox({
  
  valueBox(
    "AU 1", paste0(night_medicine[[1,3]], "/", night_medicine[[1,2]]), icon = icon("bed"),
    color = colour_empty_med_ward()
  )
})

output$w13_night <- renderValueBox({
  valueBox(
    "Ward 13", paste0(night_medicine[[2,3]], "/", night_medicine[[2,2]]), icon = icon("bed"),
    color = colour_empty_med_ward()
  )
})

output$w9_night <- renderValueBox({
  valueBox(
    "Ward 9", paste0(night_medicine[[3,3]], "/", night_medicine[[3,2]]), icon = icon("bed"),
    color = colour_empty_med_ward()
  )
})

shinyApp(ui = ui, server = server)