library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")

covid13_sum <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "B7:E14", col_names = F) %>%
  select(1, 4)

columns_13 <- c("Ward", 
                 "Compliment",
                 "Empty",
                 "Electives",
                 "DC_Expected",
                 "DC_1pm")

covid13_flow <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "B19:G42", col_names = F)

colnames(covid13_flow) <- columns_13

covid13_flow$Empty <- as.numeric(covid13_flow$Empty)

covid13_flow[8, 1] <- "22 Red"
covid13_flow[12, 1] <- "34 Red"

redzones_13 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")

covid13_flow <- covid13_flow %>%
  mutate("RedZone" = ifelse(Ward %in% redzones_13, T, F))

c13_flow_total <- c("Totals",
                    colSums(covid13_flow[, 2], na.rm = T),
                    colSums(covid13_flow[, 3], na.rm = T),
                    colSums(covid13_flow[, 4], na.rm = T),
                    colSums(covid13_flow[, 5], na.rm = T),
                    colSums(covid13_flow[, 6], na.rm = T),
                    NA
                   )

covid13_flow <- rbind(covid13_flow, c13_flow_total)

covid13_seal <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "E43", col_names = F)
covid13_ortho <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "E45", col_names = F)

covid13_wac <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "B50:G60", col_names = F)

colnames(covid13_wac) <- columns_13

covid13_wac[, 1] <- c("Delivery Suite Red",
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

covid13_wac <- covid13_wac %>%
  mutate("RedZones" = ifelse(Ward %in% red_wac, T, F))


covid13_ed <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "I19:M19", col_names = F)

if(!is.character(covid13_ed$...2)){
  covid13_ed$...2 <- format(covid13_ed$...2, "%T")
}else{
  covid13_ed$...2 <- covid13_ed$...2
}

if(!is.character(covid13_ed$...3)){
  covid13_ed$...3 <- format(covid13_ed$...3, "%T")
}else{
  covid13_ed$...3 <- covid13_ed$...3
}

covid13_cc <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "I26:N31", col_names = F)

columns_cc <- c("Ward",
                "Empty",
                "Fit",
                "Admissions",
                "DC_Expected",
                "Compliment")

colnames(covid13_cc) <- columns_cc

covid13_cc$Empty <- as.numeric(covid13_cc$Empty)

columns_au <- c("Patients",
                "Required",
                "Discharges",
                "Ongoing",
                "TCI")

covid13_au1 <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "I37:M37", col_names = F)
colnames(covid13_au1) <- columns_au

covid13_au2 <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "I44:M44", col_names = F)
colnames(covid13_au2) <- columns_au

covid13_add <- read_excel("COVIDSitRep01.xlsm", sheet = 4, range = "I50:M53", col_names = F)
colnames(covid13_add) <- c("Ward",
                            "Agreed.1",
                            "Agreed.2",
                            "InUse.1",
                            "InUse.2")
