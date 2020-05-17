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












