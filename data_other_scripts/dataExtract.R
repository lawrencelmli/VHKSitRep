library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")



# Night Capacity ----------------------------------------------------------

report_date <- read_excel("SitRep01.xlsm", sheet = 1, range = "G3", col_names = F)

report_date <- report_date[1,1]

## Medicine ----------------------------------------------------------------


medicine <- read_excel("SitRep01.xlsm", sheet = 1, range = "A8:C21", col_names = F)

colnames(medicine) <- c("Ward", "Compliment", "Empty")

total_med <- c("Total",
               colSums(medicine[, 2]), 
               colSums(medicine[, 3]))

medicine <- rbind(medicine, total_med)

night_medicine <- medicine
## Surgery -----------------------------------------------------------------

surgery <- read_excel("SitRep01.xlsm", sheet = 1, range = "A24:C30", col_names = F)

colnames(surgery) <- c("Ward", "Compliment", "Empty")

total_sx <- c("Total",
              colSums(surgery[, 2]),
              colSums(surgery[, 3]))

surgery <- rbind(surgery, total_sx)


## Trauma -------------------------------------------------------------------

trauma <- read_excel("SitRep01.xlsm", sheet = 1, range = "A33:C34", col_names = F)

colnames(trauma) <- c("Ward", "Compliment", "Empty")

total_tx <- c("Total",
              colSums(trauma[, 2]),
              colSums(trauma[, 3]))

trauma <- rbind(trauma, total_tx)


## ED ----------------------------------------------------------------------

ed <- read_excel("SitRep01.xlsm", sheet = 1, range = "F8:M8", col_names = F)

colnames(ed) <- c("Total",
                  "Longest",
                  "Time_to_Assess",
                  "Three_hours",
                  "DTA",
                  "Breaches",
                  "EMOU",
                  "Attendence")

ed$Longest <- format(ed$Longest, "%T")
ed$Time_to_Assess <- format(ed$Time_to_Assess, "%T")

# CritCare ----------------------------------------------------------------

critcare <- read_excel("SitRep01.xlsm", sheet = 1, range = "F14:H18", col_names = F)

critcare <- critcare[, -2]

Compliment <- stri_extract_all_regex(critcare[, 1], "[0-9]+")

Compliment <- as.numeric(Compliment[[1]])

critcare <- cbind(critcare, Compliment)

colnames(critcare) <- c("Ward", "Empty", "Compliment")

critcare$Ward <- gsub("[0-9]+", "", critcare$Ward)

critcare$Ward <- gsub(" \\(", "", critcare$Ward)

critcare$Ward <- gsub("\\)", "", critcare$Ward)


## Additional Capacity -----------------------------------------------------

extra <- read_excel("SitRep01.xlsm", sheet = 1, range = "F24:H28", col_names = F)

colnames(extra) <- c("Ward", "Capacity", "Used")



## Patients ----------------------------------------------------------------

patients <- read_excel("SitRep01.xlsm", sheet = 1, range = "J13:M15", col_names = F)
 
colnames(patients) <- c("Specialty", "Total", "Five_Days", "Boarders")


## Comment Box -------------------------------------------------------------

comm <- read_excel("SitRep01.xlsm", sheet = 1, range = "J20", col_names = F)

calls <- read_excel("SitRep01.xlsm", sheet = 1, range = "J27:K29", col_names = F)

colnames(calls) <- c("Time", "Nature")

calls$Time <- format(calls$Time, "%T")


# Safety Huddle -----------------------------------------------------------


# Site Position -----------------------------------------------------------

adult_occ1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "E2", col_names = F)

adult_occ2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "G2", col_names = F)

adult_occ3 <- adult_occ1/adult_occ2

add_occ1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "E3", col_names = F)

add_occ2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "G3", col_names = F)

add_occ3 <- add_occ1/add_occ2

ED_present <- read_excel("SitRep01.xlsm", sheet = 2, range = "E6", col_names = F)

ED_breach <- read_excel("SitRep01.xlsm", sheet = 2, range = "E7", col_names = F)

ED_perform <- (ED_present - ED_breach)/ED_present

EC_admit1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "E8", col_names = F)

EC_admit2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "G8", col_names = F)

EC_discharge1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "L8", col_names = F)

EC_discharge2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "M8", col_names = F)

EC_discharge3 <- read_excel("SitRep01.xlsm", sheet = 2, range = "O8", col_names = F)

PC_admit1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "E9", col_names = F)

PC_admit2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "G9", col_names = F)

PC_discharge1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "L9", col_names = F)

PC_discharge2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "M9", col_names = F)

PC_discharge3 <- read_excel("SitRep01.xlsm", sheet = 2, range = "O9", col_names = F)

total_patients <- read_excel("SitRep01.xlsm", sheet = 2, range = "M10", col_names = F)

AA_present <- read_excel("SitRep01.xlsm", sheet = 2, range = "E12", col_names = F)

AA_discharge <- read_excel("SitRep01.xlsm", sheet = 2, range = "M12", col_names = F)

AU1_tansfer1 <- read_excel("SitRep01.xlsm", sheet = 2, range = "F14", col_names = F)

AU1_tansfer2 <- read_excel("SitRep01.xlsm", sheet = 2, range = "J14", col_names = F)

AU1_tansfer3 <- read_excel("SitRep01.xlsm", sheet = 2, range = "N14", col_names = F)

HAN_table <- read_excel("SitRep01.xlsm", sheet = 2, range = "A17:F22", col_names = F)

HAN_table <- HAN_table %>%
  select(-c(2:5))

colnames(HAN_table) <- c("event", "numbers")


# SitRep 08:30 (Normal)----------------------------------------------------

EC_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "A6:E13", col_names = F)

EC_830$...1 <- gsub(":", "", EC_830$...1)

EC_830 <- EC_830 %>%
  select("FLow" = ...1,
         "Numbers" = ...5)

PC_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "G6:J13", col_names = F)

PC_830$...1 <- gsub(":", "", PC_830$...1)

PC_830 <- PC_830 %>%
  select("Flow" = ...1,
         "Numbers" = ...4)

total_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "M6:P13", col_names = F)

total_830$...1 <- gsub(":", "", total_830$...1)

total_830 <- total_830 %>%
  select("Flow" = ...1,
         "Numbers" = ...4)

columns <- c("Ward", 
             "EDD_Due",
             "EDD_Elapsed",
             "Empty",
             "Electives",
             "DC_Expect",
             "DC_12pm",
             "End_Pos",
             "Boarders",
             "RN_Short",
             "nRN_Short",
             "Safe")

med_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "A18:L31", col_names = columns)

total_med <- c("Total",
               colSums(med_830[, 2], na.rm = T),
               colSums(med_830[, 3], na.rm = T),
               colSums(med_830[, 4], na.rm = T),
               colSums(med_830[, 5], na.rm = T),
               colSums(med_830[, 6], na.rm = T),
               colSums(med_830[, 7], na.rm = T),
               colSums(med_830[, 8], na.rm = T),
               colSums(med_830[, 9], na.rm = T),
               colSums(med_830[, 10], na.rm = T),
               colSums(med_830[, 11], na.rm = T),
               NA)

med_830 <- rbind(med_830, total_med)

sx_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "A34:L42", col_names = columns)

ortho_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "A44:L46", col_names = columns)

trauma_list_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "E47", col_names = F)

woman_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "A49:L56", col_names = columns)

woman_830 <- woman_830 %>%
  select(-"EDD_Due", -"EDD_Elapsed")

ED_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "N18:V18", col_names = F)

colnames(ED_830) <- c("Total",
                      "Longest",
                      "Assessment",
                      "Three_hours",
                      "DTA",
                      "Breaches",
                      "RN_Shrot",
                      "nRN_Short",
                      "Safe")

if(is.character(ED_830$Longest) == T){
  ED_830$Longest <- ED_830$Longest
}else{
  ED_830$Longest <- format(ED_830$Longest, "%T")
}

if(is.character(ED_830$Assessment) == T){
  ED_830$Assessment <- ED_830$Assessment
}else{
  ED_830$Assessment <- format(ED_830$Assessment, "%T")
}

cc_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "N25:V29", col_names = F)

colnames(cc_830) <- c("Ward",
                      "Empty",
                      "Fit",
                      "Admissions",
                      "Discharges",
                      "End_Pos",
                      "RN_Short",
                      "nRN_Short",
                      "Safe")

cc_830[, 1] <- c("ITU",
                 "SHDU",
                 "MHDU",
                 "RHDU",
                 "CCU")

add_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "O34:U40", col_names = F)

add_830 <- select(add_830, -...3, -...5)

colnames(add_830) <- c("Ward", "Agreed", "Used", "EDD_Due", "EDD-Elapsed")

AU1_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "O44:S44", col_names = F)
AU2_830 <- read_excel("SitRep01.xlsm", sheet = 3, range = "O47:S47", col_names = F)

AU_830 <- rbind(AU1_830, AU2_830)

AU_830 <- AU_830 %>%
  select(-...2) %>%
  select("Now" = ...1,
         "Beds" = ...3,
         "DC" = ...4,
         "Ongoing" =...5)


# SitRep 13:00 (Normal) ---------------------------------------------------

EC_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "A6:F13", col_names = F)

EC_1300$...1 <- gsub(":", "", EC_1300$...1)

EC_1300 <- EC_1300 %>%
  select("FLow" = ...1,
         "Numbers" = ...6)

PC_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "H6:K13", col_names = F)

PC_1300$...1 <- gsub(":", "", PC_1300$...1)

PC_1300 <- PC_1300 %>%
  select("Flow" = ...1,
         "Numbers" = ...4)

total_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "M6:O13", col_names = F)

total_1300$...1 <- gsub(":", "", total_1300$...1)

total_1300 <- total_1300 %>%
  select("Flow" = ...1,
         "Numbers" = ...3)

columns_1300 <- c("Ward", 
                  "Access",
                  "Specialty",
                  "Empty",
                  "Electives",
                  "DC_Expect",
                  "DC_1pm",
                  "End_Pos")

med_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "A18:H32", col_names = columns_1300)

sx_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "A34:H42", col_names = columns_1300)

ortho_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "A44:H46", col_names = columns_1300)

ED_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "J18:P18", col_names = F)

colnames(ED_1300) <- c("Total",
                       "Longest",
                       "Assessment",
                       "Three_hours",
                       "DTA",
                       "Breaches",
                       "Midnight")

if(is.character(ED_1300$Longest) == T){
  ED_1300$Longest <- ED_1300$Longest
}else{
  ED_1300$Longest <- format(ED_1300$Longest, "%T")
}

if(is.character(ED_1300$Assessment) == T){
  ED_1300$Assessment <- ED_1300$Assessment
}else{
  ED_1300$Assessment <- format(ED_1300$Assessment, "%T")
}

cc_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "J25:O29", col_names = F)

colnames(cc_1300) <- c("Ward",
                       "Empty",
                       "Fit",
                       "Admissions",
                       "Discharges",
                       "End_Pos")

cc_1300[, 1] <- c("ITU",
                  "SHDU",
                  "MHDU",
                  "RHDU",
                  "CCU")


add_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "J34:N40", col_names = F)

add_1300 <- select(add_1300, -...3, -...5)

colnames(add_1300) <- c("Ward", "Agreed", "Used")

AU1_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "J44:N44", col_names = F)
AU2_1300 <- read_excel("SitRep01.xlsm", sheet = 4, range = "J47:N47", col_names = F)

AU_1300 <- rbind(AU1_1300, AU2_1300)

AU_1300 <- AU_1300 %>%
  select(-...2) %>%
  select("Now" = ...1,
         "Beds" = ...3,
         "DC" = ...4,
         "Ongoing" =...5)



# SitRep 17:00 (Normal) ---------------------------------------------------

EC_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "A6:F13", col_names = F)

EC_1700$...1 <- gsub(":", "", EC_1700$...1)

EC_1700 <- EC_1700 %>%
  select("FLow" = ...1,
         "Numbers" = ...6)

PC_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "H6:K13", col_names = F)

PC_1700$...1 <- gsub(":", "", PC_1700$...1)

PC_1700 <- PC_1700 %>%
  select("Flow" = ...1,
         "Numbers" = ...4)

total_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "M6:O13", col_names = F)

total_1700$...1 <- gsub(":", "", total_1700$...1)

total_1700 <- total_1700 %>%
  select("Flow" = ...1,
         "Numbers" = ...3)

columns_1700 <- c("Ward", 
                  "Access",
                  "Specialty",
                  "Empty",
                  "Electives",
                  "DC_Expect",
                  "DC_1pm",
                  "End_Pos")

med_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "A18:H32", col_names = columns_1700)

sx_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "A34:H42", col_names = columns_1700)

ortho_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "A44:H46", col_names = columns_1700)

ED_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "J18:P18", col_names = F)

colnames(ED_1700) <- c("Total",
                       "Longest",
                       "Assessment",
                       "Three_hours",
                       "DTA",
                       "Breaches",
                       "Midnight")

if(is.character(ED_1700$Longest) == T){
  ED_1700$Longest <- ED_1700$Longest
}else{
  ED_1700$Longest <- format(ED_1700$Longest, "%T")
}

if(is.character(ED_1700$Assessment) == T){
  ED_1700$Assessment <- ED_1700$Assessment
}else{
  ED_1700$Assessment <- format(ED_1700$Assessment, "%T")
}

cc_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "J25:O29", col_names = F)

colnames(cc_1700) <- c("Ward",
                       "Empty",
                       "Fit",
                       "Admissions",
                       "Discharges",
                       "End_Pos")

cc_1700[, 1] <- c("ITU",
                  "SHDU",
                  "MHDU",
                  "RHDU",
                  "CCU")


add_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "J34:N40", col_names = F)

add_1700 <- select(add_1700, -...3, -...5)

colnames(add_1700) <- c("Ward", "Agreed", "Used")

AU1_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "J44:N44", col_names = F)
AU2_1700 <- read_excel("SitRep01.xlsm", sheet = 5, range = "J47:N47", col_names = F)

AU_1700 <- rbind(AU1_1700, AU2_1700)

AU_1700 <- AU_1700 %>%
  select(-...2) %>%
  select("Now" = ...1,
         "Beds" = ...3,
         "DC" = ...4,
         "Ongoing" =...5)




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




















































































