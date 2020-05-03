library(tidyverse)
library(readxl)
library(stringr)
library(stringi)

setwd("D:\\Lawrence\\Documents\\R_Projects\\VHKSitRep")

covid19_sum <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "B7:E14", col_names = F) %>%
  select(1, 4)

columns_19 <- c("Ward", 
                "Compliment",
                "Empty",
                "Electives",
                "DC_Expected",
                "DC_1pm")

covid19_flow <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "B19:G42", col_names = F)

colnames(covid19_flow) <- columns_19

covid19_flow$Empty <- as.numeric(covid19_flow$Empty)

covid19_flow[8, 1] <- "22 Red"
covid19_flow[12, 1] <- "34 Red"

redzones_19 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")

covid19_flow <- covid19_flow %>%
  mutate("RedZone" = ifelse(Ward %in% redzones_19, T, F))

c19_flow_total <- c("Totals",
                    colSums(covid19_flow[, 2], na.rm = T),
                    colSums(covid19_flow[, 3], na.rm = T),
                    colSums(covid19_flow[, 4], na.rm = T),
                    colSums(covid19_flow[, 5], na.rm = T),
                    colSums(covid19_flow[, 6], na.rm = T),
                    NA
)

covid19_flow <- rbind(covid19_flow, c19_flow_total)

covid19_seal <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "E43", col_names = F)
covid19_ortho <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "E45", col_names = F)

covid19_wac <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "B50:G60", col_names = F)

colnames(covid19_wac) <- columns_19

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


covid19_ed <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "I19:M19", col_names = F)

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

covid19_cc <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "I26:N31", col_names = F)

columns_cc <- c("Ward",
                "Empty",
                "Fit",
                "Admissions",
                "DC_Expected",
                "Compliment")

colnames(covid19_cc) <- columns_cc

covid19_cc$Empty <- as.numeric(covid19_cc$Empty)

columns_au <- c("Patients",
                "Required",
                "Discharges",
                "Ongoing",
                "TCI")

covid19_au1 <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "I37:M37", col_names = F)
colnames(covid19_au1) <- columns_au

covid19_au2 <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "I44:M44", col_names = F)
colnames(covid19_au2) <- columns_au

covid19_add <- read_excel("COVIDSitRep01.xlsm", sheet = 6, range = "I50:M53", col_names = F)
colnames(covid19_add) <- c("Ward",
                           "Agreed.1",
                           "Agreed.2",
                           "InUse.1",
                           "InUse.2")
