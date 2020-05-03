library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")

covid17_sum <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "B7:E14", col_names = F) %>%
  select(1, 4)

columns_17 <- c("Ward", 
                "Compliment",
                "Empty",
                "Electives",
                "DC_Expected",
                "DC_1pm")

covid17_flow <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "B19:G42", col_names = F)

colnames(covid17_flow) <- columns_17

covid17_flow$Empty <- as.numeric(covid17_flow$Empty)

covid17_flow[8, 1] <- "22 Red"
covid17_flow[12, 1] <- "34 Red"

redzones_17 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")

covid17_flow <- covid17_flow %>%
  mutate("RedZone" = ifelse(Ward %in% redzones_17, T, F))

c17_flow_total <- c("Totals",
                    colSums(covid17_flow[, 2], na.rm = T),
                    colSums(covid17_flow[, 3], na.rm = T),
                    colSums(covid17_flow[, 4], na.rm = T),
                    colSums(covid17_flow[, 5], na.rm = T),
                    colSums(covid17_flow[, 6], na.rm = T),
                    NA
)

covid17_flow <- rbind(covid17_flow, c17_flow_total)

covid17_seal <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "E43", col_names = F)
covid17_ortho <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "E45", col_names = F)

covid17_wac <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "B50:G60", col_names = F)

colnames(covid17_wac) <- columns_17

covid17_wac[, 1] <- c("Delivery Suite Red",
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

covid17_wac <- covid17_wac %>%
  mutate("RedZones" = ifelse(Ward %in% red_wac, T, F))


covid17_ed <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "I19:M19", col_names = F)

if(!is.character(covid17_ed$...2)){
  covid17_ed$...2 <- format(covid17_ed$...2, "%T")
}else{
  covid17_ed$...2 <- covid17_ed$...2
}

if(!is.character(covid17_ed$...3)){
  covid17_ed$...3 <- format(covid17_ed$...3, "%T")
}else{
  covid17_ed$...3 <- covid17_ed$...3
}

covid17_cc <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "I26:N31", col_names = F)

columns_cc <- c("Ward",
                "Empty",
                "Fit",
                "Admissions",
                "DC_Expected",
                "Compliment")

colnames(covid17_cc) <- columns_cc

covid17_cc$Empty <- as.numeric(covid17_cc$Empty)

columns_au <- c("Patients",
                "Required",
                "Discharges",
                "Ongoing",
                "TCI")

covid17_au1 <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "I37:M37", col_names = F)
colnames(covid17_au1) <- columns_au

covid17_au2 <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "I44:M44", col_names = F)
colnames(covid17_au2) <- columns_au

covid17_add <- read_excel("COVIDSitRep01.xlsm", sheet = 5, range = "I50:M53", col_names = F)
colnames(covid17_add) <- c("Ward",
                           "Agreed.1",
                           "Agreed.2",
                           "InUse.1",
                           "InUse.2")
