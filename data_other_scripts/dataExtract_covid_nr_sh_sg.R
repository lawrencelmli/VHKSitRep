library(tidyverse)
library(readxl)
library(stringr)
library(stringi)
library(lubridate)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")


# Night Report ------------------------------------------------------------

sum_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B7:G13", col_names = F) %>%
  select("Summary" = ...1,
         "Numbers" = ...6)

# Flow --------------------------------------------------------------------

flow_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B18:G42", col_names = F)

colnames(flow_nrc) <- c("Ward", "Compliment", "Empty", "Electives", "DC_Expected", "DC_Achieved")

flow_nrc[8, 1] <- "22 Red"
flow_nrc[12, 1] <- "34 Red"

redzones <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")

flow_nrc <- flow_nrc %>%
  mutate("RedZone" = ifelse(Ward %in% redzones, T, F))

trauma_list <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B44:E44", col_names = F)

trauma_list <- trauma_list[, -2]

colnames(trauma_list) <- c("Ward", "Empty", "Electives")




# ED ----------------------------------------------------------------------

ed_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I9:P9", col_names = F) %>%
  select(-...3, -...6)

new_col <- c("Total", "Longest", "Assess", "DTA", "Breaches", "Attendances")

colnames(ed_nrc) <- new_col

class(ed_nrc$Longest)
class(ed_nrc$Assess)

if(is.character(ed_nrc$Longest) == T | is.numeric(ed_nrc$Longest) == T){
  ed_nrc$Longest <- ed_nrc$Longest
}else{
  ed_nrc$Longest <- format(ed_nrc$Longest, "%T")
}

if(is.character(ed_nrc$Assess) == T | is.numeric(ed_nrc$Longest) == T){
  ed_nrc$Assess <- ed_nrc$Assess
}else{
  
  ed_nrc$Assess <- format(ed_nrc$Assess, "%T")
}


# AAA ---------------------------------------------------------------------

aaa_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I14:O14", col_names = F) %>%
  select(-...3, -...6)

# Critical Care -----------------------------------------------------------

redcc_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B21:I26", col_names = F) %>%
  select(-...1)

columns_cc <- c("Unit", "Compliment", "Empty", "Occ", "Fit", "Adm", "DC")

colnames(redcc_nrc) <- columns_cc

redcc_nrc <- redcc_nrc %>%
  filter(!is.na(Unit)) 
  
redcc_nrc$Occ <- as.numeric(redcc_nrc$Occ)

redcc_nrc$Occ <- paste0(as.character(round(redcc_nrc$Occ*100, 0)), "%")


# WAC ---------------------------------------------------------------------

greenwac_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "K51:Q58", col_names = F)

greenwac_nrc[8, 5] <- colSums(greenwac_nrc[, 5], na.rm = T)

greenwac_nrc[8, 6] <- colSums(greenwac_nrc[, 6], na.rm = T)

greenwac_nrc[8, 7] <- colSums(greenwac_nrc[, 7], na.rm = T)

# Safety Huddle -----------------------------------------------------------

# These are based on old Excel

shc_concerns <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "H2:O14", col_names = F, trim_ws = T) %>%
  filter(!is.na(...1)) %>%
  select("Concerns" = ...1, 
         "Details" = ...5)


concerns <- c("PATIENTRAK Dashboard (FEWS etc)", 
              "Other Clinical Concerns",
              "Urgent COVID-19 Updates",
              "PPE/Procurement Update",
              "Staff Issues - All Groups",
              "Other Concerns")

shc_concerns$Concerns <- concerns


shc_support <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "P4:W15", col_names = F, trim_ws = T) %>%
  filter(!is.na(...1)) %>%
  select("Department" = ...1,
         "Details" = ...5)

shc_support[3,1] <- "INFECTION PREVENTION & CONTROL (EXT 28102)"



# SG Report ---------------------------------------------------------------

sg_covid <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "C7:D25", col_names = F)



# COVID 830 ---------------------------------------------------------------

sum_c830 <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "B7:G13", col_names = F)

sum_c1300 <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "B7:G13", col_names = F)

sum_c1700 <- read_excel("COVIDSitRep01.xlsm", sheet = 7, range = "B7:G13", col_names = F)

sum_c1900 <- read_excel("COVIDSitRep01.xlsm", sheet = 8, range = "B7:G13", col_names = F)






















