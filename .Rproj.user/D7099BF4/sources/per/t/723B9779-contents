library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")

covid830_sum <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "B7:E14", col_names = F) %>%
  select(1, 4)

columns_830 <- c("Ward", 
                 "Compliment",
                 "Empty",
                 "Electives",
                 "DC_Expected",
                 "DC_Achieved",
                 "RN",
                 "nRN",
                 "Safe")

covid830_flow <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "B19:J41", col_names = F)

colnames(covid830_flow) <- columns_830

covid830_flow$Empty <- as.numeric(covid830_flow$Empty)

redzones_830 <- c("AU1", "22", "34", "41", "43", "51", "53")

covid830_flow <- covid830_flow %>%
  mutate("RedZone" = ifelse(Ward %in% redzones_830, T, F))

covid830_seal <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "E43", col_names = F)
covid830_ortho <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "E45", col_names = F)

covid830_wac <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "B52:J62", col_names = F)

colnames(covid830_wac) <- columns_830

covid830_wac[, 1] <- c("Delivery Suite Red",
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

covid830_wac <- covid830_wac %>%
  mutate("RedZones" = ifelse(Ward %in% red_wac, T, F))

covid830_gz_compliment <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "C47", col_names = F)
covid830_gz_empty <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "E47", col_names = F)
covid830_gz_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "G47", col_names = F)
covid830_gz_au <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "I47", col_names = F)

covid830_rz_compliment <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "C48", col_names = F)
covid830_rz_empty <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "E48", col_names = F)
covid830_rz_occ <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "G48", col_names = F)
covid830_rz <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "I48", col_names = F)
covid830_rz_au1 <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "M47", col_names = F)

covid830_ed <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "L19:S19", col_names = F)

if(!is.character(covid830_ed$...2)){
  covid830_ed$...2 <- format(covid830_ed$...2, "%T")
}else{
  covid830_ed$...2 <- covid830_ed$...2
}

if(!is.character(covid830_ed$...3)){
  covid830_ed$...3 <- format(covid830_ed$...3, "%T")
}else{
  covid830_ed$...3 <- covid830_ed$...3
}

covid830_cc <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "L26:T31", col_names = F)

columns_cc <- c("Ward",
                "Empty",
                "Fit",
                "Admissions",
                "DC_Expected",
                "RN",
                "nRN",
                "Safe",
                "Compliment")

colnames(covid830_cc) <- columns_cc

covid830_cc$Empty <- as.numeric(covid830_cc$Empty)

columns_au <- c("Patients",
                "Required",
                "Discharges",
                "Ongoing",
                "TCI")

covid830_au1 <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "L37:P39", col_names = F)
colnames(covid830_au1) <- columns_au

val <- filter(covid830_au1, !is.na(Patients)) %>%
  select(Patients)

val <- val[[1,1]]

covid830_au2 <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "L43:P44", col_names = F)
colnames(covid830_au2) <- columns_au

covid830_add <- read_excel("COVIDSitRep01.xlsm", sheet = 3, range = "L52:P55", col_names = F)
colnames(covid830_add) <- c("Ward",
                            "Agreed.1",
                            "Agreed.2",
                            "InUse.1",
                            "InUse.2")
