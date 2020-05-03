
# Server 19 ---------------------------------------------------------------


c19_glance <- reactive({
  req(input$file2)
  
  covid19_sum <- read_excel(input$file2$datapath, sheet = 7, range = "B7:E14", col_names = F) %>%
    select(1, 4)
  
  return(covid19_sum)
})  

output$c19_glance1 <- renderInfoBox({
  infoBox(title = "Electives", value = c19_glance()[[1,2]], icon = icon("clipboard-list"), color = "blue", fill = T)
})

output$c19_glance2 <- renderInfoBox({
  infoBox(title = "Predicted Emergency Admissions", value = c19_glance()[[2,2]], icon = icon("hospital"), color = "yellow", fill = T)
})

output$c19_glance3 <- renderInfoBox({
  infoBox(title = "Total", value = c19_glance()[[3,2]], icon = icon("plus-square"), color = "navy", fill = T)
})

output$c19_glance4 <- renderInfoBox({
  infoBox(title = "Emergency Admissions So Far", value = c19_glance()[[4,2]], icon = icon("ambulance"), color = "maroon", fill = T)
})

output$c19_glance5 <- renderInfoBox({
  infoBox(title = "Remaining Today", value = c19_glance()[[5,2]], icon = icon("clipboard"), color = "maroon", fill = T)
})

output$c19_glance6 <- renderInfoBox({
  infoBox(title = "Beds Available Now", value = c19_glance()[[6,2]], icon = icon("bed"), color = "navy", fill = T)
})

output$c19_glance7 <- renderInfoBox({
  infoBox(title = "Expected Discharges", value = c19_glance()[[7,2]], icon = icon("home"), color = "green", fill = T)
})

output$c19_glance8 <- renderInfoBox({
  infoBox(title = "Predicted Balance", value = c19_glance()[[8,2]], icon = icon("balance-scale"), color = "navy", fill = T)
})

c19_ed <- reactive({
  req(input$file2)
  
  covid19_ed <- read_excel(input$file2$datapath, sheet = 7, range = "I19:M19", col_names = F)
  
  if(!is.character(covid19_ed$...2)){
    covid19_ed$...2 <- format(covid19_ed$...2, "%T")
  }else{
    covid19_ed$...2 <- covid19_ed$...2
  }
  
  if(!is.character(covid19_ed$...3)){
    covid19_ed$...3 <- format(covid19_ed$...3, "%T")
  }else{
    covid19_ed$...3 <- covid19_ed$...3
  }
  
  return(covid19_ed)
})



output$c19_ed1 <- renderInfoBox({
  infoBox(title = "Total in ED", value = c19_ed()[[1,1]], icon = icon("hospital-user"), color = "blue")
})

output$c19_ed2 <- renderInfoBox({
  infoBox(title = "Longest Wait", value = c19_ed()[[1,2]], icon = icon("clock"), color = "yellow")
})

output$c19_ed3 <- renderInfoBox({
  infoBox(title = "Time to Assessment", value = c19_ed()[[1,3]], icon = icon("stopwatch"), color = "yellow")
})

output$c19_ed4 <- renderInfoBox({
  infoBox(title = "No. with DTA", value = c19_ed()[[1,4]], icon = icon("hospital"), color = colour_numbers(c19_ed()[[1,4]]), fill = T)
})

output$c19_ed5 <- renderInfoBox({
  infoBox(title = "Breaches since Midnight", value = c19_ed()[[1,5]], icon = icon("stopwatch"), color = colour_breaches(c19_ed()[[1,5]]), fill = T)
})

output$c19_seal <- renderInfoBox({
  req(input$file2)
  
  val <- read_excel(input$file2$datapath, sheet = 7, range = "E43", col_names = F)
  
  infoBox("SEAL Electives", value = val[[1,1]], color = "blue", icon = icon("clipboard-list"))
})

output$c19_trauma <- renderInfoBox({
  req(input$file2)
  
  val <- read_excel(input$file2$datapath, sheet = 7, range = "E45", col_names = F)
  
  infoBox("Trauma List", value = val[[1,1]], color = "blue", icon = icon("bone"))
})


c19_flow <- reactive({
  req(input$file2)
  
  columns_19 <- c("Ward", 
                  "Compliment",
                  "Empty",
                  "Electives",
                  "DC_Expected",
                  "DC_Achieved")
  
  covid19_flow <- read_excel(input$file2$datapath, sheet = 7, range = "B19:G42", col_names = F)
  
  colnames(covid19_flow) <- columns_19
  
  covid19_flow$Empty <- as.numeric(covid19_flow$Empty)
  
  covid19_flow[8, 1] <- "22 Red"
  covid19_flow[12, 1] <- "34 Red"
  
  redzones_13 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
  
  covid19_flow <- covid19_flow %>%
    mutate("RedZone" = ifelse(Ward %in% redzones_13, T, F))
  
  return(covid19_flow)
})

output$c19_red_flow <- renderText({
  
  df <- c19_flow() 
  
  red.total <- c("Total",
                 sum(df[df$RedZone == T, 2], na.rm = T),
                 sum(df[df$RedZone == T, 3], na.rm = T),
                 sum(df[df$RedZone == T, 4], na.rm = T),
                 sum(df[df$RedZone == T, 5], na.rm = T),
                 sum(df[df$RedZone == T, 6], na.rm = T)
  )
  
  red.df <- df %>%
    filter(RedZone == T) %>%
    mutate(Empty.col = cell_spec(Empty, background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
    ) %>%
    select("Ward" = Ward,
           "Bed Compliment" = Compliment,
           "Empty Beds" = Empty.col,
           "Elecives" = Electives,
           "Discharges Expected" = DC_Expected,
           "Discharges Achieved" = DC_Achieved)
  
  red.df <- rbind(red.df, red.total)
  
  kable(red.df, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(red.df), align = "center") %>%
    column_spec(1, bold = T, width = "8em") %>%
    column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
    row_spec(nrow(red.df), bold = T, color = "white", background = "#A32020")
})


output$c19_green_flow <- renderText({
  
  df <- c19_flow() 
  
  green.total <- c("Total",
                   sum(df[df$RedZone == F, 2], na.rm = T),
                   sum(df[df$RedZone == F, 3], na.rm = T),
                   sum(df[df$RedZone == F, 4], na.rm = T),
                   sum(df[df$RedZone == F, 5], na.rm = T),
                   sum(df[df$RedZone == F, 6], na.rm = T)
  )
  
  green.df <- df %>%
    filter(RedZone == F) %>%
    mutate(Empty.col = cell_spec(Empty, background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
    ) %>%
    select("Ward" = Ward,
           "Bed Compliment" = Compliment,
           "Empty Beds" = Empty.col,
           "Elecives" = Electives,
           "Discharges Expected" = DC_Expected,
           "Discharges Achieved" = DC_Achieved)
  
  green.df <- rbind(green.df, green.total)
  
  kable(green.df, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(green.df), align = "center") %>%
    column_spec(1, bold = T) %>%
    column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
    row_spec(nrow(green.df), bold = T, color = "white", background = "#004C00")
  
})

c19_wac <- reactive({
  req(input$file2)
  
  covid19_wac <- read_excel(input$file2$datapath, sheet = 7, range = "B50:G60", col_names = F)
  
  colnames(covid19_wac) <- c("Ward", 
                              "Compliment",
                              "Empty",
                              "Electives",
                              "DC_Expected",
                              "DC_Achieved")
  
  covid19_wac[, 1] <- c("Delivery Suite Red",
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
  
  red_wac <- c("Delivery Suite Red",
               "Observation Unit Red",
               "Maternity Ward Red",
               "Children's Ward Red",
               "Neonatal Unit Red")
  
  covid19_wac <- covid19_wac %>%
    mutate("RedZones" = ifelse(Ward %in% red_wac, T, F))
  
  return(covid19_wac)
})


output$c19_wac_flow <- renderText({
  wac.df <- c19_wac() 
  
  wac.df$Empty <- as.numeric(wac.df$Empty)
  
  total <- c("Total",
             sum(wac.df[ , 2], na.rm = T),
             sum(wac.df[ , 3], na.rm = T),
             sum(wac.df[ , 4], na.rm = T),
             sum(wac.df[ , 5], na.rm = T),
             sum(wac.df[ , 6], na.rm = T))
  
  wac.df <- wac.df %>%
    mutate(Empty.col = cell_spec(Empty, background = ifelse(Empty > 5, "#56b34b", "#c64040"))
    ) %>%
    select("Ward" = Ward,
           "Bed Compliment" = Compliment,
           "Empty Beds" = Empty.col,
           "Elecives" = Electives,
           "Discharges Expected" = DC_Expected,
           "Discharges before 1 PM" = DC_Achieved)
  
  wac.df <- rbind(wac.df, total)
  
  kable(wac.df, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
    row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
    column_spec(1, bold = T, color = "white") %>%
    column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
    row_spec(nrow(wac.df), bold = T, color = "white", align = "center", background = "#292e34")
})

c19_cc <- reactive({
  req(input$file2)
  covid19_cc <- read_excel(input$file2$datapath, sheet = 7, range = "I26:N31", col_names = F)
  
  columns_cc <- c("Ward",
                  "Empty",
                  "Fit",
                  "Admissions",
                  "DC_Expected",
                  "Compliment")
  
  colnames(covid19_cc) <- columns_cc
  
  covid19_cc$Empty <- as.numeric(covid19_cc$Empty)
  
  covid19_cc[, 1] <- c("ICU Red",
                        "ICU Green",
                        "SHDU Green",
                        "MHDU Red",
                        "RHDU",
                        "CCU/MHDU Green")
  
  return(covid19_cc)
})

output$c19_cc_flow <- renderText({
  
  df.cc <- c19_cc() %>%
    select("Ward" = Ward,
           "Bed Compliment" = Compliment,
           "Ward Fit" = Fit,
           "Empty Beds" = Empty,
           "Admissions Today" = Admissions,
           "Discharges Expected" = DC_Expected)
  
  kable(df.cc, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(c(1, 4), align = "center", background = "#c64040") %>%
    row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
    column_spec(1, bold = T, color = "white") %>%
    column_spec(c(2:6), background = "#edf5f9", color = "black") 
})


c19_au1 <- reactive({
  req(input$file2)
  covid19_au1 <- read_excel(input$file2$datapath, sheet = 7, range = "I37:M37", col_names = F)
  
  return(covid19_au1)
})

output$c19_au11 <- renderInfoBox({
  df <- c19_au1()
  
  df <- filter(df, !is.na(...1)) %>%
    select(...1)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
})

output$c19_au12 <- renderInfoBox({
  df <- c19_au1()
  
  df <- filter(df, !is.na(...2)) %>%
    select(...2)
  
  val <- df[[1, 1]]
  
  colour <- ifelse(val == 0, "green", "yellow")
  
  infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
})

output$c19_au13 <- renderInfoBox({
  df <- c19_au1()
  
  df <- filter(df, !is.na(...3)) %>%
    select(...3)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
})

output$c19_au14 <- renderInfoBox({
  df <- c19_au1()
  
  df <- filter(df, !is.na(...4)) %>%
    select(...4)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
})

output$c19_au15 <- renderInfoBox({
  df <- c19_au1()
  
  df <- filter(df, !is.na(...5)) %>%
    select(...5)
  
  val <- df[[1, 1]]
  
  colour <- ifelse(val == 0, "green", "red")
  
  infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
})

c19_au2 <- reactive({
  req(input$file2)
  covid19_au2 <- read_excel(input$file2$datapath, sheet = 7, range = "I44:M44", col_names = F)
  
  return(covid19_au2)
})

output$c19_au21 <- renderInfoBox({
  df <- c19_au2()
  
  df <- filter(df, !is.na(...1)) %>%
    select(...1)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
})

output$c19_au22 <- renderInfoBox({
  df <- c19_au2()
  
  df <- filter(df, !is.na(...2)) %>%
    select(...2)
  
  val <- df[[1, 1]]
  
  colour <- ifelse(val == 0, "green", "yellow")
  
  infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
})

output$c19_au23 <- renderInfoBox({
  df <- c19_au2()
  
  df <- filter(df, !is.na(...3)) %>%
    select(...3)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
})

output$c19_au24 <- renderInfoBox({
  df <- c19_au2()
  
  df <- filter(df, !is.na(...4)) %>%
    select(...4)
  
  val <- df[[1, 1]]
  
  infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
})

output$c19_au25 <- renderInfoBox({
  df <- c19_au2()
  
  df <- filter(df, !is.na(...5)) %>%
    select(...5)
  
  val <- df[[1, 1]]
  
  colour <- ifelse(val == 0, "green", "red")
  
  infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
})

output$c19_add <- renderText({
  req(input$file2)
  
  add_nrc <- read_excel(input$file2$datapath, sheet = 7, range = "I50:M53", col_names = F)
  
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


# UI 19 ---------------------------------------------------------------

fluidRow(
  box(title = "13:00 At a Glance", width = 12, collapsible = T,
      column(width = 6,
             fluidRow(
               infoBoxOutput("c19_glance1", width = 6),
               infoBoxOutput("c19_glance2", width = 6)
             ),
             fluidRow(
               infoBoxOutput("c19_glance4", width = 6),
               infoBoxOutput("c19_glance5", width = 6)
             ),
             fluidRow(
               infoBoxOutput("c19_glance7", width = 6)
             )
      ),
      column(width = 6,
             fluidRow(infoBoxOutput("c19_glance3", width = 4)),
             fluidRow(infoBoxOutput("c19_glance6", width = 4)),
             fluidRow(infoBoxOutput("c19_glance8", width = 4))
      )
  )
),#/fluidRow

fluidRow(
  box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
      infoBoxOutput("c19_ed1", width = 2),
      infoBoxOutput("c19_ed2", width = 2),
      infoBoxOutput("c19_ed3", width = 2),
      infoBoxOutput("c19_ed4", width = 2),
      infoBoxOutput("c19_ed5", width = 2)
  )
), #/fluidRow

fluidRow(
  box(title = "FLOW", width = 12, collapsible = T,
      fluidRow(
        box(title = "SEAL and Trauma", width = 12, collapsible = T,
            infoBoxOutput("c19_seal", width = 2),
            infoBoxOutput("c19_trauma", width = 2)
        )
      ),
      fluidRow(
        box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
            htmlOutput("c19_red_flow")),
        box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T,
            htmlOutput("c19_green_flow")),
        box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
            htmlOutput("c19_wac_flow")),
        box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
            htmlOutput("c19_cc_flow"))
      )
      
  ) #/box
  
), #/fluidRow
fluidRow(
  box(title = "Assessment Units", width = 12, collapsible = T,
      box(title = "AU One", width = 6, collapsible = T,
          column(width = 6,
                 infoBoxOutput("c19_au11", width = NULL),
                 infoBoxOutput("c19_au12", width = NULL),
                 infoBoxOutput("c19_au13", width = NULL)
          ),
          column(width = 6,
                 infoBoxOutput("c19_au14", width = NULL),
                 infoBoxOutput("c19_au15", width = NULL)
          )
      ),
      
      
      box(title = "AU Two", width = 6, collapsible = T,
          column(width = 6,
                 infoBoxOutput("c19_au21", width = NULL),
                 infoBoxOutput("c19_au22", width = NULL),
                 infoBoxOutput("c19_au23", width = NULL)
          ),
          column(width = 6,
                 infoBoxOutput("c19_au24", width = NULL),
                 infoBoxOutput("c19_au25", width = NULL)
          )
      ),
      box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
          htmlOutput("c19_add")
      )
  )
)
