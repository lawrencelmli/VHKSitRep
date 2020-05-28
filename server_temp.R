ec_1900 <- reactive({
  req(input$file1)
  
  EC_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "A6:F13", col_names = F)
  
  EC_1900$...1 <- gsub(":", "", EC_1900$...1)
  
  EC_1900 <- EC_1900 %>%
    select("FLow" = ...1,
           "Numbers" = ...6)
  
  return(EC_1900)
})  

output$ec1900_1 <- renderInfoBox({
  
  infoBox(title = "Electives", value = ec_1900()[[1,2]], color = "navy", icon = icon("clipboard-list"))
  
})

output$ec1900_2 <- renderInfoBox({
  
  infoBox(title = "Predicted Emergencies", value = ec_1900()[[2,2]], color = "yellow", icon = icon("ambulance"))
  
})

output$ec1900_3 <- renderInfoBox({
  
  infoBox(title = "Total", value = ec_1900()[[3,2]], color = "navy", icon = icon("calculator"))
  
})

output$ec1900_4 <- renderInfoBox({
  
  infoBox(title = "Admissions so far", value = ec_1900()[[4,2]], color = "navy", icon = icon("hospital-user"))
  
})

output$ec1900_5 <- renderInfoBox({
  
  infoBox(title = "Remaining Today", value = ec_1900()[[5,2]], color = "navy", icon = icon("calculator"))
  
})

output$ec1900_6 <- renderInfoBox({
  
  infoBox(title = "Beds Available now", value = ec_1900()[[6,2]], color = ifelse(ec_1900()[[6,2]] < 5, "red", "green"), icon = icon("bed"))
  
})

output$ec1900_7 <- renderInfoBox({
  
  infoBox(title = "Definitive & Expected DC", value = ec_1900()[[7,2]], color = "navy", icon = icon("home"))
  
})

output$ec1900_8 <- renderInfoBox({
  
  infoBox(title = "Predicted Balance", value = ec_1900()[[8,2]], color = ifelse(ec_1900()[[8,2]] > 0, "green", "red"), icon = icon("balance-scale"))
  
})

pc_1900 <- reactive({
  req(input$file1)
  
  PC_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "H6:K13", col_names = F)
  
  PC_1900$...1 <- gsub(":", "", PC_1900$...1)
  
  PC_1900 <- PC_1900 %>%
    select("Flow" = ...1,
           "Numbers" = ...4)
  
  return(PC_1900)
  
})


output$pc1900_1 <- renderInfoBox({
  
  infoBox(title = "Electives", value = pc_1900()[[1,2]], color = "navy", icon = icon("clipboard-list"))
  
})

output$pc1900_2 <- renderInfoBox({
  
  infoBox(title = "Predicted Emergencies", value = pc_1900()[[2,2]], color = "yellow", icon = icon("ambulance"))
  
})

output$pc1900_3 <- renderInfoBox({
  
  infoBox(title = "Total", value = pc_1900()[[3,2]], color = "navy", icon = icon("calculator"))
  
})

output$pc1900_4 <- renderInfoBox({
  
  infoBox(title = "Admissions so far", value = pc_1900()[[4,2]], color = "navy", icon = icon("hospital-user"))
  
})

output$pc1900_5 <- renderInfoBox({
  
  infoBox(title = "Remaining Today", value = pc_1900()[[5,2]], color = "navy", icon = icon("calculator"))
  
})

output$pc1900_6 <- renderInfoBox({
  
  infoBox(title = "Beds Available now", value = pc_1900()[[6,2]], color = ifelse(pc_1900()[[6,2]] < 5, "red", "green"), icon = icon("bed"))
  
})

output$pc1900_7 <- renderInfoBox({
  
  infoBox(title = "Definitive & Expected DC", value = pc_1900()[[7,2]], color = "navy", icon = icon("home"))
  
})

output$pc1900_8 <- renderInfoBox({
  
  infoBox(title = "Predicted Balance", value = pc_1900()[[8,2]], color = ifelse(pc_1900()[[8,2]] > 0, "green", "red"), icon = icon("balance-scale"))
  
})

tot_1900 <- reactive({
  
  req(input$file1)
  
  total_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "M6:O13", col_names = F)
  
  total_1900$...1 <- gsub(":", "", total_1900$...1)
  
  total_1900 <- total_1900 %>%
    select("Flow" = ...1,
           "Numbers" = ...3)
  
  return(total_1900)
  
})

output$tot1900_1 <- renderInfoBox({
  
  infoBox(title = "Electives", value = tot_1900()[[1,2]], color = "navy", icon = icon("clipboard-list"))
  
})

output$tot1900_2 <- renderInfoBox({
  
  infoBox(title = "Predicted Emergencies", value = tot_1900()[[2,2]], color = "yellow", icon = icon("ambulance"))
  
})

output$tot1900_3 <- renderInfoBox({
  
  infoBox(title = "Total", value = tot_1900()[[3,2]], color = "navy", icon = icon("calculator"))
  
})

output$tot1900_4 <- renderInfoBox({
  
  infoBox(title = "Admissions so far", value = tot_1900()[[4,2]], color = "navy", icon = icon("hospital-user"))
  
})

output$tot1900_5 <- renderInfoBox({
  
  infoBox(title = "Remaining Today", value = tot_1900()[[5,2]], color = "navy", icon = icon("calculator"))
  
})

output$tot1900_6 <- renderInfoBox({
  
  infoBox(title = "Beds Available now", value = tot_1900()[[6,2]], color = ifelse(tot_1900()[[6,2]] < 5, "red", "green"), icon = icon("bed"))
  
})

output$tot1900_7 <- renderInfoBox({
  
  infoBox(title = "Definitive & Expected DC", value = tot_1900()[[7,2]], color = "navy", icon = icon("home"))
  
})

output$tot1900_8 <- renderInfoBox({
  
  infoBox(title = "Predicted Balance", value = tot_1900()[[8,2]], color = ifelse(tot_1900()[[8,2]] > 0, "green", "red"), icon = icon("balance-scale"))
  
})

ED1900 <- reactive({
  req(input$file1)
  ED_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "J18:P18", col_names = F)
  
  colnames(ED_1900) <- c("Total",
                         "Longest",
                         "Assessment",
                         "Three_hours",
                         "DTA",
                         "Breaches",
                         "Midnight")
  
  if(is.character(ED_1900$Longest) == T){
    ED_1900$Longest <- ED_1900$Longest
  }else{
    ED_1900$Longest <- format(ED_1900$Longest, "%T")
  }
  
  if(is.character(ED_1900$Assessment) == T){
    ED_1900$Assessment <- ED_1900$Assessment
  }else{
    ED_1900$Assessment <- format(ED_1900$Assessment, "%T")
  }
  
  return(ED_1900)
})

output$ed1900_1 <- renderInfoBox({
  
  infoBox("Total Number", value = ED1900()[[1,1]],
          color = "navy",
          icon = icon("hospital-user"))
  
})

output$ed1900_2 <- renderInfoBox({
  
  infoBox("Longest Wait", value = ED1900()[[1,2]],
          color = "yellow",
          icon = icon("clock"))
})


output$ed1900_3 <- renderInfoBox({
  
  infoBox("Time to Assessment", value = ED1900()[[1,3]],
          color = "yellow",
          icon = icon("stopwatch"))
})


output$ed1900_4 <- renderInfoBox({
  
  infoBox("Number with 3 hours wait", value = ED1900()[[1,4]],
          color = ifelse(ED1900()[[1,4]] > 0, "red", "green"),
          icon = icon("exclamation-triangle"))
})

output$ed1900_5 <- renderInfoBox({
  
  infoBox("Number of DTA", value = ED1900()[[1,5]],
          color = ifelse(ED1900()[[1,5]] > 0, "purple", "green"),
          icon = icon("hospital"))
})

output$ed1900_6 <- renderInfoBox({
  
  infoBox("Breaches Since Midnight", value = ED1900()[[1,6]],
          color = ifelse(ED1900()[[1,6]] > 0, "purple", "green"),
          icon = icon("stopwatch"))
})

output$ed1900_7 <- renderInfoBox({
  
  infoBox("Attendances Since Midnight", value = ED1900()[[1,7]],
          color = "navy",
          icon = icon("hospital-user"))
})



au1900 <- reactive({
  req(input$file1)
  
  AU1_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "J43:N43", col_names = F)
  AU2_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "J46:N46", col_names = F)
  
  AU_1900 <- rbind(AU1_1900, AU2_1900)
  
  AU_1900 <- AU_1900 %>%
    select(-...2) %>%
    select("Now" = ...1,
           "Beds" = ...3,
           "DC" = ...4,
           "Ongoing" =...5)
  
  return(AU_1900)
})


output$au1_1900_1 <- renderInfoBox({
  
  infoBox(title = "Patients Now", color = "blue", value = au1900()[[1,1]], icon = icon("hospital-user"))
  
  
})

output$au1_1900_2 <- renderInfoBox({
  
  infoBox(title = "Bed Required", color = "blue", value = au1900()[[1,2]], icon = icon("bed"))
  
  
})

output$au1_1900_3 <- renderInfoBox({
  
  infoBox(title = "Definite Discharges", color = "blue", value = au1900()[[1,3]], icon = icon("home"))
  
  
})

output$au1_1900_4 <- renderInfoBox({
  
  infoBox(title = "Ongoing Assessment", color = "blue", value = au1900()[[1,4]], icon = icon("clipboard-check"))
  
  
})

output$au2_1900_1 <- renderInfoBox({
  
  infoBox(title = "Patients Now", color = "light-blue", value = au1900()[[2,1]], icon = icon("hospital-user"))
  
  
})

output$au2_1900_2 <- renderInfoBox({
  
  infoBox(title = "Bed Required", color = "light-blue", value = au1900()[[2,2]], icon = icon("bed"))
  
  
})

output$au2_1900_3 <- renderInfoBox({
  
  infoBox(title = "Definite Discharges", color = "light-blue", value = au1900()[[2,3]], icon = icon("home"))
  
  
})

output$au2_1900_4 <- renderInfoBox({
  
  infoBox(title = "Ongoing Assessment", color = "light-blue", value = au1900()[[2,4]], icon = icon("clipboard-check"))
  
  
})

output$cc1900 <- renderText({
  
  req(input$file1)
  
  cc_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "J25:O29", col_names = F)
  
  colnames(cc_1900) <- c("Ward",
                         "Empty",
                         "Fit",
                         "Admissions",
                         "Discharges",
                         "End_Pos")
  
  cc_1900[, 1] <- c("ITU",
                    "SHDU",
                    "MHDU",
                    "RHDU",
                    "CCU")
  
  cc_1900 <- cc_1900 %>%
    mutate(
      End_Pos = cell_spec(End_Pos, "html", bold = T, color = "white", background = if_else(End_Pos >= 0, "#56b34b", "#c64040", "#1b1c21")),
    ) %>%
    select(
      "Ward" = Ward,
      "Empty Beds Now" = Empty,
      "Ward Fit Patients" = Fit,
      "Planned Admissions" = Admissions,
      "Discharges" = Discharges,
      "End of Day Position" = End_Pos,
    ) 
  
  kable(cc_1900, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(cc_1900), align = "center", background = "#DCDCDC") %>%
    column_spec(1, bold = T, width = "8em")
  
})



output$med1900 <- renderText({
  req(input$file1)
  
  columns <- c("Ward", 
               "Access",
               "Specialty",
               "Empty",
               "Electives",
               "DC_Expect",
               "DC_1pm",
               "End_Pos")
  
  med_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "A18:H32", col_names = columns)
  
  med_1900 <- med_1900 %>%
    mutate(
      DC_Expect = cell_spec(DC_Expect, "html", bold = T, color = "white", background = if_else(DC_Expect > 0, "#56b34b", "#c64040", "#1b1c21")),
      DC_1pm = cell_spec(DC_1pm, "html", bold = T, color = "white", background = if_else(DC_1pm > 0, "#56b34b", "#c64040", "#1b1c21")),
      End_Pos = cell_spec(End_Pos, "html", bold = T, color = "white", background = if_else(End_Pos < 0, "#c64040", "#56b34b", "#1b1c21")),
    ) %>%
    select(
      "Ward" = Ward,
      "Access Quotas" = Access,
      "Specialty Bed Waits" = Specialty,
      "Empty Beds Now" = Empty,
      "Electives (GP's on board AU 1 & 2)" = Electives,
      "Discharges Expected" = DC_Expect,
      "Discharges by 1 pm" = DC_1pm,
      "End of Day Position" = End_Pos)
  
  kable(med_1900, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(med_1900), align = "center", background = "#DCDCDC") %>%
    column_spec(2, color = "white", background = "#E79695") %>%
    column_spec(3, color = "white", background = "#DA7900") %>%
    column_spec(1, bold = T, width = "8em") %>%
    column_spec(5, width = "10em") %>%
    row_spec(nrow(med_1900), bold = T, color = "white", background = "#03396C")
  
})

output$sx1900 <- renderText({
  req(input$file1)
  
  columns <- c("Ward", 
               "Access",
               "Specialty",
               "Empty",
               "Electives",
               "DC_Expect",
               "DC_1pm",
               "End_Pos")
  
  sx_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "A34:H41", col_names = columns)
  
  sx_1900 <- sx_1900 %>%
    mutate(
      DC_Expect = cell_spec(DC_Expect, "html", bold = T, color = "white", background = if_else(DC_Expect > 0, "#56b34b", "#c64040", "#1b1c21")),
      DC_1pm = cell_spec(DC_1pm, "html", bold = T, color = "white", background = if_else(DC_1pm > 0, "#56b34b", "#c64040", "#1b1c21")),
      End_Pos = cell_spec(End_Pos, "html", bold = T, color = "white", background = if_else(End_Pos < 0, "#c64040", "#56b34b", "#1b1c21")),
    ) %>%
    select(
      "Ward" = Ward,
      "Access Quotas" = Access,
      "Specialty Bed Waits" = Specialty,
      "Empty Beds Now" = Empty,
      "Electives (GP's on board AU 1 & 2)" = Electives,
      "Discharges Expected" = DC_Expect,
      "Discharges by 1 pm" = DC_1pm,
      "End of Day Position" = End_Pos)
  
  kable(sx_1900, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(sx_1900), align = "center", background = "#DCDCDC") %>%
    column_spec(2, color = "white", background = "#E79695") %>%
    column_spec(3, color = "white", background = "#DA7900") %>%
    column_spec(1, bold = T, width = "8em") %>%
    column_spec(5, width = "10em") %>%
    row_spec(nrow(sx_1900), bold = T, color = "white", background = "#03396C")
  
  
})

output$ot1900 <- renderText({
  req(input$file1)
  
  columns <- c("Ward", 
               "Access",
               "Specialty",
               "Empty",
               "Electives",
               "DC_Expect",
               "DC_1pm",
               "End_Pos")
  
  ot_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "A43:H45", col_names = columns)
  
  ot_1900 <- ot_1900 %>%
    mutate(
      DC_Expect = cell_spec(DC_Expect, "html", bold = T, color = "white", background = if_else(DC_Expect > 0, "#56b34b", "#c64040", "#1b1c21")),
      DC_1pm = cell_spec(DC_1pm, "html", bold = T, color = "white", background = if_else(DC_1pm > 0, "#56b34b", "#c64040", "#1b1c21")),
      End_Pos = cell_spec(End_Pos, "html", bold = T, color = "white", background = if_else(End_Pos < 0, "#c64040", "#56b34b", "#1b1c21")),
    ) %>%
    select(
      "Ward" = Ward,
      "Access Quotas" = Access,
      "Specialty Bed Waits" = Specialty,
      "Empty Beds Now" = Empty,
      "Electives (GP's on board AU 1 & 2)" = Electives,
      "Discharges Expected" = DC_Expect,
      "Discharges by 1 pm" = DC_1pm,
      "End of Day Position" = End_Pos)
  
  kable(ot_1900, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
    row_spec(1:nrow(ot_1900), align = "center", background = "#DCDCDC") %>%
    column_spec(2, color = "white", background = "#E79695") %>%
    column_spec(3, color = "white", background = "#DA7900") %>%
    column_spec(1, bold = T, width = "8em") %>%
    column_spec(5, width = "10em") %>%
    row_spec(nrow(ot_1900), bold = T, color = "white", background = "#03396C")
  
  
  
})


output$add1900 <- renderText({
  req(input$file1)
  
  add_1900 <- read_excel(input$file1$datapath, sheet = 6, range = "J34:N39", col_names = F)
  
  add_1900 <- select(add_1900, -...3, -...5)
  
  colnames(add_1900) <- c("Ward", "Agreed", "Used")
  
  add_1900 <- add_1900 %>%
    mutate(Used = cell_spec(Used, bold = T, color = "white", background = if_else(Used > 0, "#c64040", "#56b34b", "#1b1c21"))
    ) %>%
    select("Ward" = Ward,
           "Agreed Additional Capacity" = Agreed,
           "Additional Beds in Use" = Used)
  
  kable(add_1900, "html", escape = F) %>%
    kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
    row_spec(0, bold = T, align = "center", background = "#DA7900", color = "white") %>%
    row_spec(1:nrow(add_1900), align = "center", background = "#DCDCDC") %>%
    column_spec(1, bold = T, width = "8em") 
  
})
