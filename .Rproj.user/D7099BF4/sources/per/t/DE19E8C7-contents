flow_nrc <- read_excel("COVIDSitRep01.xlsm", sheet = 2, range = "B18:G42", col_names = F)

colnames(flow_nrc) <- c("Ward", "Compliment", "Empty", "Electives", "DC_Expected", "DC_Achieved")

flow_nrc[8, 1] <- "22 Red"
flow_nrc[12, 1] <- "34 Red"

redzones <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")

flow_nrc <- flow_nrc %>%
  mutate("RedZone" = ifelse(Ward %in% redzones, T, F))

flow_red <- flow_nrc %>%
  filter(RedZone == T)


flow_red$Empty <- as.numeric(flow_red$Empty)

flow_nrc$Empty <- as.numeric(flow_nrc$Empty)

total_red <- c("Red Total", 
               colSums(flow_red[, 2]),
               colSums(flow_red[, 3]),
               colSums(flow_red[, 4]),
               colSums(flow_red[, 5]),
               colSums(flow_red[, 6])
)

flow_red <- rbind(flow_red, total_red)


df <- flow_nrc

df$Empty <- as.numeric(df$Empty)

flow_red <- df %>%
  filter(RedZone == T) %>%
  select(-7)


red_total <- data.frame(Ward = "Red Total",
                        Compliment = colSums(flow_red[, 2], na.rm = T),
                        Empty = colSums(flow_red[, 3], na.rm = T),
                        Electives = colSums(flow_red[, 4], na.rm = T),
                        DC_Expected = colSums(flow_red[, 5], na.rm = T),
                        DC_Achieved = colSums(flow_red[, 6], na.rm = T)
                        )

flow_green <- df %>%
  filter(RedZone == F) %>%
  select(-7)
  

green_total <- data.frame(Ward = "Green Total",
                          Compliment = colSums(flow_green[, 2], na.rm = T),
                          Empty = colSums(flow_green[, 3], na.rm = T),
                          Electives = colSums(flow_green[, 4], na.rm = T),
                          DC_Expected = colSums(flow_green[, 5], na.rm = T),
                          DC_Achieved = colSums(flow_green[, 6], na.rm = T)
                          )

sum_flow <- rbind(red_total, green_total)


total_both <- data.frame(Ward = "Sum Total",
                         Compliment = sum(sum_flow[1:2, 2]),
                         Empty = sum(sum_flow[1:2, 3]),
                         Electives = sum(sum_flow[1:2, 4]),
                         DC_Expected = sum(sum_flow[1:2, 5]),
                         DC_Achieved = sum(sum_flow[1:2, 6])
                         )

sum_flow <- rbind(sum_flow, total_both)


mutate(Empty.col = cell_spec(Empty, background = if_else(Empty > 0, "#56b34b", "#c64040", "#1b1c21")),
       RN.col = cell_spec(RN, background = if_else(RN > 0, "#56b34b", "#c64040", "#1b1c21")),
       nRN.col = cell_spec(nRN, background = if_else(nRN > 0, "#56b34b", "#c64040", "#1b1c21")),
       Safe.col = cell_spec(Safe, background = if_else((Safe == "No" | Safe == "N" | Safe == "no" | Safe == "n"), "#56b34b", "#c64040", "#1b1c21"))
) %>%
