
# SitRep 19:00 (Normal) ---------------------------------------------------

EC_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "A6:F13", col_names = F)

EC_1900$...1 <- gsub(":", "", EC_1900$...1)

EC_1900 <- EC_1900 %>%
  select("FLow" = ...1,
         "Numbers" = ...6)

PC_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "H6:K13", col_names = F)

PC_1900$...1 <- gsub(":", "", PC_1900$...1)

PC_1900 <- PC_1900 %>%
  select("Flow" = ...1,
         "Numbers" = ...4)

total_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "M6:O13", col_names = F)

total_1900$...1 <- gsub(":", "", total_1900$...1)

total_1900 <- total_1900 %>%
  select("Flow" = ...1,
         "Numbers" = ...3)

columns_1900 <- c("Ward", 
                  "Access",
                  "Planned",
                  "Empty",
                  "Electives",
                  "DC_Expect",
                  "DC_5pm",
                  "End_Pos")

med_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "A18:H32", col_names = columns_1900)

sx_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "A34:H41", col_names = columns_1900)

ortho_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "A43:H45", col_names = columns_1900)

ED_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "J18:P18", col_names = F)

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

cc_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "J25:O29", col_names = F)

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


add_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "J34:N39", col_names = F)

add_1900 <- select(add_1900, -...3, -...5)

colnames(add_1900) <- c("Ward", "Agreed", "Used")

AU1_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "J43:N43", col_names = F)
AU2_1900 <- read_excel("SitRep01.xlsm", sheet = 6, range = "J46:N46", col_names = F)

AU_1900 <- rbind(AU1_1900, AU2_1900)

AU_1900 <- AU_1900 %>%
  select(-...2) %>%
  select("Now" = ...1,
         "Beds" = ...3,
         "DC" = ...4,
         "Ongoing" =...5)





























