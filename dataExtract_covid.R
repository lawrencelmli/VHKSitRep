library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")


# Night Report ------------------------------------------------------------

sum_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B7:E13", col_names = F) %>%
  select("Summary" = ...1,
         "Numbers" = ...4)

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

ed_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I18:M18", col_names = F)

new_col <- c("Total", "Longest", "Assess", "DTA", "Breaches")

colnames(ed_nrc) <- new_col


# Women & Chilren -------------------------------------------------------

wac_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B49:G59", col_names = F)

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



red_wac <- c("Delivery Suite Red",
             "Observation Unit Red",
             "Maternity Ward Red",
             "Children's Ward Red",
             "Neonatal Unit Red")

wac_nrc <- wac_nrc %>%
  mutate("Red Zone" = ifelse(Ward %in% red_wac, T, F))


# Critical Care -----------------------------------------------------------

critcare_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I25:N30", col_names = F)

colnames(critcare_nrc) <- c("Ward", "Empty", "Fit", "Admissions", "Discharges", "Compliment")

cc_wards <- c("ITU Red", "ITU Green", "SHDU Green", "MHDU Red", "RHDU", "CCU/MHDU Green")

critcare_nrc[, 1] <- cc_wards

red_cc <- c("ITU Red", "MHDU Red")

critcare_nrc <- critcare_nrc %>%
  mutate("Red Zone" = ifelse(Ward %in% red_cc, T, F))


# AU One ------------------------------------------------------------------

au1_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I36:M36", col_names = F)
au2_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I43:M43", col_names = F)

au_nrc <- rbind(au1_nrc, au2_nrc) %>%
  mutate("Ward" = c("AU 1", "AU2"))
au_nrc <- au_nrc[, c(6, 1:5)]

colnames(au_nrc) <- c("Ward", "Patients", "Required", "DC", "Ongoing", "GPTCI")


# Additional --------------------------------------------------------------

add_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "I49:M52", col_names = F)

colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "USed1", "Used2")


# Safety Huddle -----------------------------------------------------------

shc_ed_total <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C3:C3", col_names = F)
shc_dta <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "E3", col_names = F)

shc_icu_red <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C5:C5", col_names = F)
shc_icu_green <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "E5:E5", col_names = F)
shc_rhdu <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "G5:G5", col_names = F)
shc_mhdu_red <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C6:C6", col_names = F)
shc_mhdu_green <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "E6:E6", col_names = F)
shc_shdu <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "G6:G6", col_names = F)

shc_red_wards <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "D8", col_names = F)
shc_red_zones <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "D9", col_names = F)

shc_aured_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C10", col_names = F)
shc_augreen_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "E10", col_names = F)
shc_totalgreen_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "G10", col_names = F)

shc_red_avail <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C11", col_names = F)
shc_red_pat <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "E11", col_names = F)
shc_totalred_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "G11", col_names = F)

shc_pc_urgent <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "D13", col_names = F)
shc_mat_beds <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "D16", col_names = F)

shc_paeds <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "C18:G20", col_names = F)%>%
  mutate("Ward" = c("Paeds", NA, "Neonates")) %>%
  filter(!is.na(...1)) %>% 
  select(Ward, "Red_Patients" = ...1,
         "Red_Beds" = ...3, 
         "Green_Beds" = ...5) 
  
shc_care <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "H3:L15", col_names = F, trim_ws = T) %>%
  filter(!is.na(...1)) %>%
  select("Concerns" = ...1, 
         "Details" = ...5)


concerns <- c("PATIENTRAK Dashboard (FEWS etc)", 
              "Other Clinical Concerns",
              "Urgent COVID-19 Updates",
              "PPE/Procurement Update",
              "Staff Issues - All Groups",
              "Other Concerns")

shc_care$Concerns <- concerns


shc_support <- read_excel("COVIDSitRep01.xlsm", sheet = 1, range = "P4:W15", col_names = F, trim_ws = T) %>%
  filter(!is.na(...1)) %>%
  select("Department" = ...1,
         "Details" = ...5)

shc_support[3,1] <- "INFECTION PREVENTION & CONTROL (EXT 28102)"

