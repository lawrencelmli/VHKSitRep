library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(readxl)
library(stringr)
library(stringi)
library(knitr)
library(kableExtra)

ui <- dashboardPage(
  
  
  dashboardHeader(title = "VHK Situation Report"),
  dashboardSidebar(
    
    
    sidebarMenu(
      
      fileInput("file1", "Upload SitREp Excel"),
      
      div(style="display: inline-block;vertical-align:top; ", p("Date of SitRep: ")), 
      div(style="display: inline-block;vertical-align:top; ", textOutput("date_of_report")),
      
      fileInput("file2", "Upload COVID-19 SitRep Excel"),
      
      div(style="display: inline-block;vertical-align:top; ", p("Date of COVID Report: ")), 
      div(style="display: inline-block;vertical-align:top; ", textOutput("COVID_date")),
      
      menuItem("How to Use", tabName = "instructions", icon = icon("book-open")),
      
      menuItem("Night Capacity Report", tabName = "night_report", icon = icon("clipboard")),
    
      menuItem("Safety Huddle", tabName = "safety", icon = icon("hard-hat")),
    
      menuItem("08:30", tabName = "eight_thirty", icon = icon("clock")),
    
      menuItem("13:00", tabName = "one_pm", icon = icon("clock")),
    
      menuItem("17:00", tabName = "five_pm", icon = icon("clock")),
    
      menuItem("19:00", tabName = "seven_pm", icon = icon("clock")),
      
      menuItem("CoViD-19", icon = icon("virus"), startExpanded = T,
               
               menuSubItem("Night Capacity Report", tabName = "covid_night", icon = icon("clipboard")),
               menuSubItem("Safety Huddle", tabName = "covid_safety", icon = icon("hard-hat")),
               menuSubItem("08:30", tabName = "covid_eight_thirty", icon = icon("clock")),
               menuSubItem("13:00", tabName = "covid_one_pm", icon = icon("clock")),
               menuSubItem("17:00", tabName = "covid_five_pm", icon = icon("clock")),
               menuSubItem("19:00", tabName = "covid_seven_pm", icon = icon("clock"))
               )
      
      ) #/sidebarMenu
    ), #/dashboardSidebar
  dashboardBody(
    
    tags$style("@import url(https://use.fontawesome.com/releases/v5.13.0/css/all.css);"), # to use the latest fontawesome icons
    tabItems(
      tabItem(tabName = "instructions", h3("How to Generate Reports"),
              p("To use this app, please upload the relevant Excel file using the upload buttons, 
                then click on the links to see the reports"),
              p("The reports during CoViD-19 period are found under the CoViD-19 menu on the left."),
              p("Copyright (c) Lawrence Li")
              ),
      
      tabItem(tabName = "night_report", h3("Night Capacity Report"),
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("nc_ed.1", width = 3),
                    infoBoxOutput("nc_ed.2", width = 3),
                    infoBoxOutput("nc_ed.3", width = 3),
                    infoBoxOutput("nc_ed.4", width = 3),
                    infoBoxOutput("nc_ed.5", width = 3),
                    infoBoxOutput("nc_ed.6", width = 3),
                    infoBoxOutput("nc_ed.7", width = 3),
                    infoBoxOutput("nc_ed.8", width = 3))
                ), #/fluidRow
              fluidRow(
                box(title = "MEDICINE", width = 9, collapsible = T, 
                    column(width = 3,
                           infoBoxOutput("med_compliment", width = NULL),
                           infoBoxOutput("med_empty", width = NULL),
                           infoBoxOutput("med_total_px", width = NULL),
                           infoBoxOutput("med_5d", width = NULL),
                           infoBoxOutput("med_boarders", width = NULL)
                      ),
                    column(width = 9, 
                           fluidRow(
                             valueBoxOutput("au1_night", width = 3),
                             valueBoxOutput("w13_night", width = 3),
                             valueBoxOutput("w9_night", width = 3)
                             ),
                           fluidRow(
                             valueBoxOutput("w22_night", width = 3),
                             valueBoxOutput("w23_night", width = 3)
                             ),
                           fluidRow(
                             valueBoxOutput("w32_night", width = 3),
                             valueBoxOutput("w33_night", width = 3),
                             valueBoxOutput("w34_night", width = 3)
                             ),
                           fluidRow(
                             valueBoxOutput("w41_night", width = 3),
                             valueBoxOutput("w42_night", width = 3),
                             valueBoxOutput("w43_night", width = 3),
                             valueBoxOutput("w44_night", width = 3)
                             ),
                           fluidRow(
                             valueBoxOutput("w51_night", width = 3),
                             valueBoxOutput("w54_night", width = 3)
                             )
                           )
                    ),
                
                box(title = "CRITICAL CARE", width = 3, collapsible = T,
                    infoBoxOutput("nc_icu", width = NULL),
                    infoBoxOutput("nc_shdu", width = NULL),
                    infoBoxOutput("nc_mhdu", width = NULL),
                    infoBoxOutput("nc_rhdu", width = NULL),
                    infoBoxOutput("nc_ccu", width = NULL)
                    ),
                
                box(title = "SURGERY", width = 6, collapsible = T,
                    column(width = 6,
                           infoBoxOutput("sx_compliment", width = NULL),
                           infoBoxOutput("sx_empty", width = NULL),
                           infoBoxOutput("sx_total_px", width = NULL),
                           infoBoxOutput("sx_5d", width = NULL),
                           infoBoxOutput("sx_boarders", width = NULL)
                           ),
                    column(width = 6, 
                           fluidRow(
                             valueBoxOutput("au2_night", width = 6),
                             valueBoxOutput("ent_night", width = 6),
                             valueBoxOutput("w10_night", width = 6),
                             valueBoxOutput("w9sx_night", width = 6)
                             ),
                           fluidRow(
                             valueBoxOutput("w52_night", width = 6),
                             valueBoxOutput("w53_night", width = 6),
                             valueBoxOutput("w54sx_night", width = 6)
                             )
                           )
                      ), #/box - Surgery
                box(title = "TRAUMA", width = 6, collapsible = T,
                    column(width = 6,
                           infoBoxOutput("trauma_compliment", width = NULL),
                           infoBoxOutput("trauma_empty", width = NULL),
                           infoBoxOutput("trauma_total_px", width = NULL),
                           infoBoxOutput("trauma_5d", width = NULL),
                           infoBoxOutput("trauma_boarders", width = NULL)
                    ),
                    column(width = 6, 
                           fluidRow(
                             valueBoxOutput("w31_night", width = 6),
                             valueBoxOutput("w33tx_night", width = 6)
                             )
                           )
                    ), #/box - Ortho
                box(title = "ADDITIONAL CAPACITY", width = 6, collapsible = T, collapsed = T,
                    infoBoxOutput("nc_add1", width = 6),
                    infoBoxOutput("nc_add2", width = 6),
                    infoBoxOutput("nc_add3", width = 6),
                    infoBoxOutput("nc_add4", width = 6),
                    infoBoxOutput("nc_add5", width = 6)
                    ),
                
                box(title = "OTHER/MISCELLANEOUS", width = 6, collapsible = T, collapsed = T,
                    infoBoxOutput("comments", width = 12),
                    htmlOutput("calls")
                    )
                
                ) #/FluidRow
              ), #/tabItem "night_report"
      
      tabItem(tabName = "safety", h3("Safety Huddle"),
              fluidRow(
                box(title = "SITE POSITION", collapsible = T, width = 6,
                    fluidRow(
                      infoBoxOutput("bed_occ", width = 6),
                      valueBoxOutput("occ_percent", width = 3)
                      ),
                    fluidRow(
                      infoBoxOutput("add_occ", width = 6),
                      valueBoxOutput("add_percent", width = 3))
                    ), #/box - SITE POSITION
                box(title = "HOSPITAL @ NIGHT", collapsible = T, width = 6,
                    infoBoxOutput("han1", width = 6),
                    infoBoxOutput("han4", width = 6),
                    infoBoxOutput("han2", width = 6),
                    infoBoxOutput("han5", width = 6),
                    infoBoxOutput("han3", width = 6),
                    infoBoxOutput("han6", width = 6)
                    )
                ), #/fluidRow
              fluidRow(
                box(title = "CAPACITY ACTIVITY", width = 12, collapsible = T,
                    fluidRow(
                      box(title = "Emergency Department", width = 6, collapsible = T,
                          infoBoxOutput("sh_ed1", width = 6),
                          infoBoxOutput("sh_ed2", width = 6),
                          valueBoxOutput("sh_ed3", width = 6)
                          ),
                      box(title = "Assessment Units", width = 6, collapsible = T,
                          column(width = 5,
                                 h4("AA Ax U"),
                                 infoBoxOutput("aa_present", width = 12),
                                 infoBoxOutput("aa_dc", width = 12)
                                 ),
                          column(width = 7,
                                 h4("Transfer Profile from AU One"),
                                 fluidRow(infoBoxOutput("aa_transfer1", width = 12)),
                                 fluidRow(infoBoxOutput("aa_transfer2", width = 12)),
                                 fluidRow(infoBoxOutput("aa_transfer3", width = 12))
                                 )
                          ) #/box Assessment Units
                      ),
                    fluidRow(
                      box(title = "Admissions", width = 3, collapsible = T,
                          infoBoxOutput("ec_admit", width = 12),
                          infoBoxOutput("pc_admit", width = 12)
                          ),
                      box(title = "Discharges", width = 9, collapsible = T,
                          infoBoxOutput("ec_dc1", width = 4),
                          valueBoxOutput("ec_dc2", width = 3),
                          valueBoxOutput("ec_dc3", width = 3),
                          infoBoxOutput("pc_dc1", width = 4),
                          valueBoxOutput("pc_dc2", width = 3),
                          valueBoxOutput("pc_dc3", width = 3),
                          column(width = 4),
                          infoBoxOutput("total_dc", width = 3)
                          )
                      )
                    
                    ) #/box "Capacity"
                )
              ), #/tabItem "safety"
      tabItem(tabName = "eight_thirty", h3("Situation Report at 8:30")), #/tabItem "eight_thirty"
      tabItem(tabName = "one_pm", h3("Situation Report at 13:00")), #/tabItem "one_pm"
      tabItem(tabName = "five_pm", h3("Situation Report at 17:00")), #/tabItem "five_pm"
      tabItem(tabName = "seven_pm", h3("Situation Report at 19:00")), #/tabItem "seven_pm"
      
      tabItem(tabName = "covid_night", h3("Night Capacity Report COVID-19"),
              
              fluidRow(
                box(title = "OVERALL SUMMARY", width = 12, collapsible = T,
                    infoBoxOutput("nrc_electives", width = 2),
                    infoBoxOutput("nrc_predicted", width = 3),
                    infoBoxOutput("nrc_total", width = 2),
                    infoBoxOutput("nrc_admissions", width = 3),
                    infoBoxOutput("nrc_remain", width = 3),
                    infoBoxOutput("nrc_beds", width = 2),
                    infoBoxOutput("nrc_dc_expected", width = 3)
                    ),
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("nrc_ED_1", width = 2),
                    infoBoxOutput("nrc_ED_2", width = 2),
                    infoBoxOutput("nrc_ED_3", width = 2),
                    infoBoxOutput("nrc_ED_4", width = 2),
                    infoBoxOutput("nrc_ED_5", width = 3)
                    ),
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(box(title = "FLOW - SUMMARY", width = 12, collapsible = T, 
                      column(width = 6,
                        htmlOutput("nrc_flow_sum")
                        ),
                        fluidRow(
                          infoBoxOutput("trauma_flow", width = 2),
                          infoBoxOutput("SEAL_flow", width = 3)
                          ),
                        fluidRow(
                          box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                            htmlOutput("nrc_red_flow")
                            ),
                          box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T, 
                            htmlOutput("nrc_green_flow")
                            ),
                          box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                            htmlOutput("nrc_wac")
                            ),
                          box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                            htmlOutput("nrc_critcare")
                            )
                          )
                        )
                      ),
                fluidRow(
                  box(title = "Assessment Units", width = 12, collapsible = T, 
                      fluidRow(
                        box(title = "AU One", width = 12,
                            infoBoxOutput("au1_px", width = 2),
                            infoBoxOutput("au1_beds", width = 2),
                            infoBoxOutput("au1_dc", width = 2),
                            infoBoxOutput("au1_ongoing", width = 3),
                            infoBoxOutput("au1_gp", width = 2)
                            )
                        ),
                      fluidRow(
                        box(title = "AU Two", width = 12,
                            infoBoxOutput("au2_px", width = 2),
                            infoBoxOutput("au2_beds", width = 2),
                            infoBoxOutput("au2_dc", width = 2),
                            infoBoxOutput("au2_ongoing", width = 3),
                            infoBoxOutput("au2_gp", width = 2)
                            )
                        )
                      )
                    )
                    
                    
                    ),
                
                box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                    htmlOutput("nrc_add")
                    
                    )
                    
                
              )
              
              
              ), #/"Night Report COVID-19"
      
      tabItem(tabName = "covid_safety", h3("Safety Huddle COVID-19"),
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                           infoBoxOutput("shc_ed1", width = 2),
                           infoBoxOutput("shc_ed2", width = 2)
                    )
                ),
              fluidRow(
                box(title = "CRITICAL CARE BEDS AVAILABLE", width = 12, collapsible = T,
                    infoBoxOutput("shc_cc1", width = 2),
                    infoBoxOutput("shc_cc2", width = 2),
                    infoBoxOutput("shc_cc3", width = 2),
                    infoBoxOutput("shc_cc4", width = 2),
                    infoBoxOutput("shc_cc5", width = 2),
                    infoBoxOutput("shc_cc6", width = 2)
                    )
                ),
              
              fluidRow(
                box(title = "INPATIENT CAPACITY", width = 12, collapsible = T,
                    infoBoxOutput("red_wards", width = 6),
                    infoBoxOutput("red_zones", width = 6),
                    
                    box(title = "Red and Green Occupancy", collapsible = T, width = 6,
                      column(width = 6,
                             infoBoxOutput("shc_occ1", width = NULL),
                             infoBoxOutput("shc_occ2", width = NULL),
                             infoBoxOutput("shc_occ3", width = NULL),
                             infoBoxOutput("shc_occ4", width = NULL)
                             ),
                      column(width = 6,
                             infoBoxOutput("shc_occ5", width = NULL),
                             infoBoxOutput("shc_occ6", width = NULL)
                             )
                      ),
                    column(width = 4,
                           box(title ="Planned Care", collapsible = T, width = NULL,
                               infoBoxOutput("shc_pc", width = NULL)
                               )
                           )
                    
                    ),
                box(title = "Women & Children", width = 12, collapsible = T,
                    column(width = 4,
                           infoBoxOutput("shc_mat", width = NULL)
                           ),
                    column(width = 4,
                           infoBoxOutput("shc_paeds1", width = NULL),
                           infoBoxOutput("shc_paeds2", width = NULL),
                           infoBoxOutput("shc_paeds3", width = NULL)
                           ),
                    column(width = 4,
                           infoBoxOutput("shc_neo1", width = NULL),
                           infoBoxOutput("shc_neo2", width = NULL),
                           infoBoxOutput("shc_neo3", width = NULL)
                           )
                    )
                
                ), #/fluidRow
              fluidRow(
                box(width = 5, title = "CARE & TREATMENT CONCERNS", collapsible = T,
                    htmlOutput("shc_care_con")
                    ),
                box(width = 7, title = "SUPPORT SERVICES", collapsible = T,
                    fluidRow(
                      infoBoxOutput("shc_ss1", width = 6),
                      infoBoxOutput("shc_ss2", width = 6),
                      infoBoxOutput("shc_ss3", width = 6),
                      infoBoxOutput("shc_ss4", width = 6),
                      infoBoxOutput("shc_ss5", width = 6),
                      infoBoxOutput("shc_ss6", width = 6),
                      infoBoxOutput("shc_ss7", width = 6)
                      )#/fluidRow
                    )
                ) #/fluidRow
                
              
                
              
              ), #/tabItem "safety COVID-19"
      
      tabItem(tabName = "covid_eight_thirty", h3("Situation Report at 08:30 COVID-19"),
              
              fluidRow(
                box(title = "08:30 At a Glance", width = 12, collapsible = T,
                    column(width = 6,
                      fluidRow(
                        infoBoxOutput("c830_glance1", width = 6),
                        infoBoxOutput("c830_glance2", width = 6)
                        ),
                      fluidRow(
                        infoBoxOutput("c830_glance4", width = 6),
                        infoBoxOutput("c830_glance5", width = 6)
                        ),
                      fluidRow(
                        infoBoxOutput("c830_glance7", width = 6)
                        )
                      ),
                    column(width = 6,
                           fluidRow(infoBoxOutput("c830_glance3", width = 4)),
                           fluidRow(infoBoxOutput("c830_glance6", width = 4)),
                           fluidRow(infoBoxOutput("c830_glance8", width = 4))
                           )
                    )
              ), #/fluidRow
              
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("c830_ed1", width = 2),
                    infoBoxOutput("c830_ed2", width = 2),
                    infoBoxOutput("c830_ed3", width = 2),
                    infoBoxOutput("c830_ed4", width = 2),
                    infoBoxOutput("c830_ed5", width = 2),
                    infoBoxOutput("c830_ed6", width = 3),
                    infoBoxOutput("c830_ed7", width = 3),
                    infoBoxOutput("c830_ed8", width = 2)
                    )
              ),
              
              
              fluidRow(
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(
                      box(title = "Flow - Summary", width = 12, collapsible = T,
                          infoBoxOutput("c830_fl_sum1", width = 3),
                          infoBoxOutput("c830_fl_sum2", width = 3),
                          infoBoxOutput("c830_fl_sum3", width = 3),
                          infoBoxOutput("c830_fl_sum4", width = 3),
                          infoBoxOutput("c830_fl_sum5", width = 3),
                          infoBoxOutput("c830_fl_sum6", width = 3),
                          infoBoxOutput("c830_fl_sum7", width = 3),
                          infoBoxOutput("c830_fl_sum8", width = 3),
                          infoBoxOutput("c830_fl_sum9", width = 3),
                          infoBoxOutput("c830_fl_sum10", width = 2),
                          infoBoxOutput("c830_fl_sum11", width = 2)
                          )
                      ),
                    
                    fluidRow(
                      box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                          htmlOutput("c830_red_flow")
                          ),
                      box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T,
                          htmlOutput("c830_green_flow")
                          ),
                      box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c830_wac_flow")
                          ),
                      box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c830_cc_flow"))
                      )
                    )
              ),
              
              fluidRow(
                box(title = "Assessment Units", width = 12, collapsible = T,
                    box(title = "AU One", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c830_au11", width = NULL),
                               infoBoxOutput("c830_au12", width = NULL),
                               infoBoxOutput("c830_au13", width = NULL)
                               ),
                        column(width = 6,
                               infoBoxOutput("c830_au14", width = NULL),
                               infoBoxOutput("c830_au15", width = NULL)
                               )
                        ),

                    
                    box(title = "AU Two", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c830_au21", width = NULL),
                               infoBoxOutput("c830_au22", width = NULL),
                               infoBoxOutput("c830_au23", width = NULL)
                               ),
                        column(width = 6,
                               infoBoxOutput("c830_au24", width = NULL),
                               infoBoxOutput("c830_au25", width = NULL)
                               )
                        ),
                    
                    box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                        htmlOutput("c830_add")
                        )
                    )
                )

              
              ), #/tabItem "eight_thirty COVID-19"
      tabItem(tabName = "covid_one_pm", h3("Situation Report at 13:00 COVID-19"),
              fluidRow(
                box(title = "13:00 At a Glance", width = 12, collapsible = T,
                    column(width = 6,
                           fluidRow(
                             infoBoxOutput("c13_glance1", width = 6),
                             infoBoxOutput("c13_glance2", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c13_glance4", width = 6),
                             infoBoxOutput("c13_glance5", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c13_glance7", width = 6)
                           )
                    ),
                    column(width = 6,
                           fluidRow(infoBoxOutput("c13_glance3", width = 4)),
                           fluidRow(infoBoxOutput("c13_glance6", width = 4)),
                           fluidRow(infoBoxOutput("c13_glance8", width = 4))
                           )
                    )
                ),#/fluidRow
              
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("c13_ed1", width = 2),
                    infoBoxOutput("c13_ed2", width = 2),
                    infoBoxOutput("c13_ed3", width = 2),
                    infoBoxOutput("c13_ed4", width = 2),
                    infoBoxOutput("c13_ed5", width = 2)
                    )
                ), #/fluidRow
              
              fluidRow(
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(
                      box(title = "SEAL and Trauma", width = 12, collapsible = T,
                          infoBoxOutput("c13_seal", width = 2),
                          infoBoxOutput("c13_trauma", width = 2)
                          )
                      ),
                   fluidRow(
                      box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                          htmlOutput("c13_red_flow")),
                      box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T,
                          htmlOutput("c13_green_flow")),
                      box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c13_wac_flow")),
                      box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c13_cc_flow"))
                      )
                      
                    ) #/box
                
                ), #/fluidRow
              fluidRow(
                box(title = "Assessment Units", width = 12, collapsible = T,
                    box(title = "AU One", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c13_au11", width = NULL),
                               infoBoxOutput("c13_au12", width = NULL),
                               infoBoxOutput("c13_au13", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c13_au14", width = NULL),
                               infoBoxOutput("c13_au15", width = NULL)
                        )
                    ),
                    
                    
                    box(title = "AU Two", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c13_au21", width = NULL),
                               infoBoxOutput("c13_au22", width = NULL),
                               infoBoxOutput("c13_au23", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c13_au24", width = NULL),
                               infoBoxOutput("c13_au25", width = NULL)
                        )
                    ),
                    box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                        htmlOutput("c13_add")
                    )
                )
              )
              ), #/tabItem "one_pm COVID-19"
      tabItem(tabName = "covid_five_pm", h3("Situation Report at 17:00 COVID-19"),
              fluidRow(
                box(title = "17:00 At a Glance", width = 12, collapsible = T,
                    column(width = 6,
                           fluidRow(
                             infoBoxOutput("c17_glance1", width = 6),
                             infoBoxOutput("c17_glance2", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c17_glance4", width = 6),
                             infoBoxOutput("c17_glance5", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c17_glance7", width = 6)
                           )
                    ),
                    column(width = 6,
                           fluidRow(infoBoxOutput("c17_glance3", width = 4)),
                           fluidRow(infoBoxOutput("c17_glance6", width = 4)),
                           fluidRow(infoBoxOutput("c17_glance8", width = 4))
                    )
                )
              ),#/fluidRow
              
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("c17_ed1", width = 2),
                    infoBoxOutput("c17_ed2", width = 2),
                    infoBoxOutput("c17_ed3", width = 2),
                    infoBoxOutput("c17_ed4", width = 2),
                    infoBoxOutput("c17_ed5", width = 2)
                )
              ), #/fluidRow
              
              fluidRow(
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(
                      box(title = "SEAL and Trauma", width = 12, collapsible = T,
                          infoBoxOutput("c17_seal", width = 2),
                          infoBoxOutput("c17_trauma", width = 2)
                      )
                    ),
                    fluidRow(
                      box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                          htmlOutput("c17_red_flow")),
                      box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T,
                          htmlOutput("c17_green_flow")),
                      box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c17_wac_flow")),
                      box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c17_cc_flow"))
                    )
                    
                ) #/box
                
              ), #/fluidRow
              fluidRow(
                box(title = "Assessment Units", width = 12, collapsible = T,
                    box(title = "AU One", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c17_au11", width = NULL),
                               infoBoxOutput("c17_au12", width = NULL),
                               infoBoxOutput("c17_au13", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c17_au14", width = NULL),
                               infoBoxOutput("c17_au15", width = NULL)
                        )
                    ),
                    
                    
                    box(title = "AU Two", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c17_au21", width = NULL),
                               infoBoxOutput("c17_au22", width = NULL),
                               infoBoxOutput("c17_au23", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c17_au24", width = NULL),
                               infoBoxOutput("c17_au25", width = NULL)
                        )
                    ),
                    box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                        htmlOutput("c17_add")
                    )
                )
              )
              
              
              ), #/tabItem "five_pm" COVID-19
      tabItem(tabName = "covid_seven_pm", h3("Situation Report at 19:00 COVID-19"),
              fluidRow(
                box(title = "19:00 At a Glance", width = 12, collapsible = T,
                    column(width = 6,
                           fluidRow(
                             infoBoxOutput("c19_glance1", width = 6),
                             infoBoxOutput("c19_glance2", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c19_glance4", width = 6),
                             infoBoxOutput("c19_glance5", width = 6)
                           ),
                           fluidRow(
                             infoBoxOutput("c19_glance7", width = 6)
                           )
                    ),
                    column(width = 6,
                           fluidRow(infoBoxOutput("c19_glance3", width = 4)),
                           fluidRow(infoBoxOutput("c19_glance6", width = 4)),
                           fluidRow(infoBoxOutput("c19_glance8", width = 4))
                    )
                )
              ),#/fluidRow
              
              fluidRow(
                box(title = "EMERGENCY DEPARTMENT", width = 12, collapsible = T,
                    infoBoxOutput("c19_ed1", width = 2),
                    infoBoxOutput("c19_ed2", width = 2),
                    infoBoxOutput("c19_ed3", width = 2),
                    infoBoxOutput("c19_ed4", width = 2),
                    infoBoxOutput("c19_ed5", width = 2)
                )
              ), #/fluidRow
              
              fluidRow(
                box(title = "FLOW", width = 12, collapsible = T,
                    fluidRow(
                      box(title = "SEAL and Trauma", width = 12, collapsible = T,
                          infoBoxOutput("c19_seal", width = 2),
                          infoBoxOutput("c19_trauma", width = 2)
                      )
                    ),
                    fluidRow(
                      box(title = "Red Zones", width = 6, collapsible = T, background = "red", collapsed = T,
                          htmlOutput("c19_red_flow")),
                      box(title = "Green Zones", width = 6, collapsible = T, background = "green", collapsed = T,
                          htmlOutput("c19_green_flow")),
                      box(title = "Women and Children", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c19_wac_flow")),
                      box(title = "Critical Care", width = 6, collapsible = T, collapsed = T,
                          htmlOutput("c19_cc_flow"))
                    )
                    
                ) #/box
                
              ), #/fluidRow
              fluidRow(
                box(title = "Assessment Units", width = 12, collapsible = T,
                    box(title = "AU One", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c19_au11", width = NULL),
                               infoBoxOutput("c19_au12", width = NULL),
                               infoBoxOutput("c19_au13", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c19_au14", width = NULL),
                               infoBoxOutput("c19_au15", width = NULL)
                        )
                    ),
                    
                    
                    box(title = "AU Two", width = 6, collapsible = T,
                        column(width = 6,
                               infoBoxOutput("c19_au21", width = NULL),
                               infoBoxOutput("c19_au22", width = NULL),
                               infoBoxOutput("c19_au23", width = NULL)
                        ),
                        column(width = 6,
                               infoBoxOutput("c19_au24", width = NULL),
                               infoBoxOutput("c19_au25", width = NULL)
                        )
                    ),
                    box(title = "Additional Capacity", collapsible = T, collapsed = T, width = 6,
                        htmlOutput("c19_add")
                    )
                )
              )
      )
    ) #/tabItems
  ) #/dashboardBody
) #/dashboardPage


# SERVER ------------------------------------------------------------------

server <- function(input, output){
  
  colour_numbers <- function(x){
    if (x > 0){
      colour <- "red"
    }else{
      colour <- "light-blue"
    }
    return(colour)
  }
  
  colour_breaches <- function(x){
    if (x > 0){
      colour <- "purple"
    }else{
      colour <- "green"
    }
    return(colour)
  }
  
  colour_rn <- function(x){
    if (x > 0){
      colour <- "red"
    }else{
      colour <- "green"
    }
    return(colour)
  }
  
  colour_safe <- function(x){
    if(x == "Yes" | x == "Y" | x == "yes" | x == "y"){
      colour <- "green"
    }else{
      colour <- "red"
    }
    return(colour)
  }
  
  reportDate <- reactive({
    
    req(input$file1)
    
    report_date <- read_excel(input$file1$datapath, sheet = 1, range = "G3", col_names = F)
    
    report_date <- report_date[[1]]
    
    if(is.character(report_date) == F){
      report_date <- as.character(report_date)
    }else{
      report_date < report_date
    }
    
    return(report_date)
  })
  
  output$date_of_report <- renderText({
    reportDate()
  })
  
  night_patients <- reactive({
    req(input$file1)
    
    patients <- read_excel(input$file1$datapath, sheet = 1, range = "J13:M15", col_names = F)
    
    colnames(patients) <- c("Specialty", "Total", "Five_Days", "Boarders")
    
    return(patients)
  })
  
  ED_summary <- reactive({
    req(input$file1)
    
    ed <- read_excel(input$file1$datapath, sheet = 1, range = "F8:M8", col_names = F)
    
    colnames(ed) <- c("Total",
                      "Longest",
                      "Time_to_Assess",
                      "Three_hours",
                      "DTA",
                      "Breaches",
                      "EMOU",
                      "Attendence")
    
    if(is.character(ed$Longest) == F){
      ed$Longest <- format(ed$Longest, "%T")
    }else{
      ed$Longest < ed$Longest
    }
    
    if(is.character(ed$Time_to_Assess) == F){
      ed$Time_to_Assess <- format(ed$Time_to_Assess, "%T")
    }else{
      ed$Time_to_Assess < ed$Time_to_Assess
    }
    
    
    return(ed)
  })
  
   output$nc_ed.1 <- renderInfoBox({
     infoBox(title = "Total No. in ED", value = ED_summary()[1,1], color = "navy", icon = icon("clipboard"))
   })
   
   output$nc_ed.2 <- renderInfoBox({
     infoBox(title = "Longest Wait", value = ED_summary()[1,2], color = "yellow", icon = icon("clock"))
   })
   
   output$nc_ed.3 <- renderInfoBox({
     infoBox(title = "Longest Time to Assessment", value = ED_summary()[1,3], color = "yellow", icon = icon("stopwatch"))
   })
   
   output$nc_ed.4 <- renderInfoBox({
     
     colour <- function(x){
       if(x > 0){
         colour <- "red"
       }else{
         colour <- "green"
       }
       return(colour)
     }
     
     infoBox(title = "Patients more than 3 hours", value = ED_summary()[1,4], color = colour(ED_summary()[1,4]), icon = icon("exclamation-triangle"))
   })
   
   output$nc_ed.5 <- renderInfoBox({
     
     colour <- function(x){
       if(x > 0){
         colour <- "purple"
       }else{
         colour <- "green"
       }
       return(colour)
     }
     
     infoBox(title = "No. with DTA", value = ED_summary()[1,5], color = colour(ED_summary()[1,5]), icon = icon("hospital"))
   })
   
   output$nc_ed.6 <- renderInfoBox({
     
     colour <- function(x){
       if(x > 0){
         colour <- "purple"
       }else{
         colour <- "green"
       }
       return(colour)
     }
     
     infoBox(title = "No. of breaches since MN", value = ED_summary()[1,6], color = colour(ED_summary()[1,6]), icon = icon("stopwatch"))
   })
   
   output$nc_ed.7 <- renderInfoBox({
     infoBox(title = "No. of patients in EMOU", value = paste0(ED_summary()[1,7], "/6 Beds"), color = "navy", icon = icon("procedures"))
   })
   
   output$nc_ed.8 <- renderInfoBox({
     infoBox(title = "Attendances since Midnight", value = ED_summary()[1,8], color = "navy", icon = icon("ambulance"))
   })
   
   
   
  
  colour_empty_night <- reactive({
    if(night_medicine()[[15, 3]] >= 20){
      colour <- "green"
    }else if(night_medicine()[[15, 3]] >= 10 & night_medicine()[[15, 3]] < 20){
      colour <- "yellow"
    }else if(night_medicine()[[15, 3]] < 10){
      colour <- "red"
    }
    
    return(colour)
  })
  
  colour_empty_ward <- function(x) {
    cut(as.numeric(x), breaks=c(-Inf, 1, 3, Inf), labels=c("red","yellow","green"), right = FALSE)
  }

# Normal Night Capacity_Medicine ------------------------------------------

  night_medicine <- reactive({
    
    req(input$file1)
    
    medicine <- read_excel(input$file1$datapath, sheet = 1, range = "A8:C21", col_names = F)
    
    colnames(medicine) <- c("Ward", "Compliment", "Empty")
    
    total_med <- c("Total",
                   colSums(medicine[, 2]), 
                   colSums(medicine[, 3]))
    
    medicine <- rbind(medicine, total_med)
    
    return(medicine)
  })
  
  output$med_compliment <- renderInfoBox({
    infoBox(
      "Bed Compliment", night_medicine()[[15, 2]], icon = icon("hospital"),
      color = "blue"
    )
  })
  
  
  output$med_empty <- renderInfoBox({
    infoBox(
      "Empty Beds", night_medicine()[[15, 3]], icon = icon("bed"),
      color = colour_empty_night()
    )
  })
  
  output$med_total_px <- renderInfoBox({
    infoBox(
      "Total Patients", night_patients()[[1, 2]], icon = icon("hospital-user"),
      color = "blue"
    )
  })
  
  output$med_5d <- renderInfoBox({
    infoBox(
      "No. more than 5 Days", night_patients()[[1, 3]], icon = icon("calendar-day"),
      color = "red"
    )
  })
  
  output$med_boarders <- renderInfoBox({
    infoBox(
      "No. Boarded Yesterday", night_patients()[[1, 4]], icon = icon("passport"),
      color = "red"
    )
  })
  
  output$au1_night <- renderValueBox({
    
    valueBox(
      tags$h3("AU 1", style = "font-size: 150%;"), paste0(night_medicine()[[1,3]], "/", night_medicine()[[1,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[1,3]])
    )
  })
  
  output$w13_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 13", style = "font-size: 150%;"), paste0(night_medicine()[[2,3]], "/", night_medicine()[[2,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[2,3]])
    )
  })
  
  output$w9_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 9", style = "font-size: 150%;"), paste0(night_medicine()[[3,3]], "/", night_medicine()[[3,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[3,3]])
    )
  })
  
  output$w22_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 22", style = "font-size: 150%;"), paste0(night_medicine()[[4,3]], "/", night_medicine()[[4,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[4,3]])
    )
  })
  
  output$w23_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 23", style = "font-size: 150%;"), paste0(night_medicine()[[5,3]], "/", night_medicine()[[5,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[5,3]])
    )
  })
  
  output$w32_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 32", style = "font-size: 150%;"), paste0(night_medicine()[[6,3]], "/", night_medicine()[[6,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[6,3]])
    )
  })
  
  output$w33_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 33", style = "font-size: 150%;"), paste0(night_medicine()[[7,3]], "/", night_medicine()[[7,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[7,3]])
    )
  })
  
  output$w34_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 34", style = "font-size: 150%;"), paste0(night_medicine()[[8,3]], "/", night_medicine()[[8,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[8,3]])
    )
  })
  output$w41_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 41", style = "font-size: 150%;"), paste0(night_medicine()[[9,3]], "/", night_medicine()[[9,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[9,3]])
    )
  })
  output$w42_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 42", style = "font-size: 150%;"), paste0(night_medicine()[[10,3]], "/", night_medicine()[[10,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[10,3]])
    )
  })
  output$w43_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 43", style = "font-size: 150%;"), paste0(night_medicine()[[11,3]], "/", night_medicine()[[11,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[11,3]])
    )
  })
  output$w44_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 44", style = "font-size: 150%;"), paste0(night_medicine()[[12,3]], "/", night_medicine()[[12,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[12,3]])
    )
  })
  output$w51_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 51", style = "font-size: 150%;"), paste0(night_medicine()[[13,3]], "/", night_medicine()[[13,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[13,3]])
    )
  })
  output$w54_night <- renderValueBox({
    valueBox(
      tags$h3("Ward 54", style = "font-size: 150%;"), paste0(night_medicine()[[14,3]], "/", night_medicine()[[14,2]], "Available"), icon = icon("bed"),
      color = colour_empty_ward(night_medicine()[[14,3]])
    )
  })
  


# Normal Night Capacity_Surgery -------------------------------------------
  
  colour_empty_sx <- reactive({
    if(night_surgery()[[8, 3]] >= 20){
      colour <- "green"
    }else if(night_surgery()[[8, 3]] >= 10 & night_surgery()[[8, 3]] < 20){
      colour <- "yellow"
    }else if(night_surgery()[[8, 3]] < 10){
      colour <- "red"
    }
    
    return(colour)
  })

  night_surgery <- reactive({
    req(input$file1)
    
    surgery <- read_excel(input$file1$datapath, sheet = 1, range = "A24:C30", col_names = F)
    
    colnames(surgery) <- c("Ward", "Compliment", "Empty")
    
    total_sx <- c("Total",
                  colSums(surgery[, 2]),
                  colSums(surgery[, 3]))
    
    surgery <- rbind(surgery, total_sx)
    
    return(surgery)
  })
  output$sx_compliment <- renderInfoBox({
    infoBox(
      "Bed Compliment", night_surgery()[[8, 2]], icon = icon("hospital"),
      color = "blue"
    )
  })
  output$sx_empty <- renderInfoBox({
    infoBox(
      "Empty Beds", night_surgery()[[8, 3]], icon = icon("bed"),
      color = colour_empty_sx()
    )
  })
  
  output$sx_total_px <- renderInfoBox({
    infoBox(
      "Total Patients", night_patients()[[2, 2]], icon = icon("hospital-user"),
      color = "blue"
    )
  })
  
  output$sx_5d <- renderInfoBox({
    infoBox(
      "No. more than 5 Days", night_patients()[[2, 3]], icon = icon("calendar-day"),
      color = "red"
    )
  })
  
  output$sx_boarders <- renderInfoBox({
    infoBox(
      "No. Boarded Yesterday", night_patients()[[2, 4]], icon = icon("passport"),
      color = "red"
    )
  })
  
  output$au2_night <- renderValueBox({
    
    valueBox(
      tags$h3("AU 2", style = "font-size: 150%;"), paste0(night_surgery()[[1,3]], "/", night_surgery()[[1,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[1,3]])
    )
  })
  
  output$ent_night <- renderValueBox({
    
    valueBox(
      tags$h3("ENT", style = "font-size: 150%;"), paste0(night_surgery()[[2,3]], "/", night_surgery()[[2,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[2,3]])
    )
  })
  
  output$w10_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 10", style = "font-size: 150%;"), paste0(night_surgery()[[3,3]], "/", night_surgery()[[3,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[3,3]])
    )
  })
  
  output$w9sx_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 9", style = "font-size: 150%;"), paste0(night_surgery()[[4,3]], "/", night_surgery()[[4,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[4,3]])
    )
  })
  
  output$w52_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 52", style = "font-size: 150%;"), paste0(night_surgery()[[5,3]], "/", night_surgery()[[5,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[5,3]])
    )
  })
  
  output$w53_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 53", style = "font-size: 150%;"), paste0(night_surgery()[[6,3]], "/", night_surgery()[[6,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[6,3]])
    )
  })
  
  output$w54sx_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 54", style = "font-size: 150%;"), paste0(night_surgery()[[7,3]], "/", night_surgery()[[7,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_surgery()[[7,3]])
    )
  })
  



# Normal Night Capacity_Trauma --------------------------------------------
  colour_empty_tx <- function(x){
    
    x <- as.numeric(x)
    
    if(x >= 10){
      colour <- "green"
    }else if(x >= 5 & x < 10){
      colour <- "yellow"
    }else if(x < 5){
      colour <- "red"
    }
    
    return(colour)
  }
  
  
  night_tx <- reactive({
    req(input$file1)
    
    trauma <- read_excel(input$file1$datapath, sheet = 1, range = "A33:C34", col_names = F)
    
    colnames(trauma) <- c("Ward", "Compliment", "Empty")
    
    total_tx <- c("Total",
                  colSums(trauma[, 2]),
                  colSums(trauma[, 3]))
    
    trauma <- rbind(trauma, total_tx)
    
    return(trauma)
    })
  
  output$trauma_compliment <- renderInfoBox({
    infoBox(
      "Bed Compliment", night_tx()[[3, 2]], icon = icon("hospital"),
      color = "blue"
    )
  })
  output$trauma_empty <- renderInfoBox({
    infoBox(
      "Empty Beds", night_tx()[[3, 3]], icon = icon("bed"),
      color = colour_empty_tx(night_tx()[[3, 3]])
    )
  })
  
  output$trauma_total_px <- renderInfoBox({
    infoBox(
      "Total Patients", night_patients()[[3, 2]], icon = icon("hospital-user"),
      color = "blue"
    )
  })
  
  output$trauma_5d <- renderInfoBox({
    infoBox(
      "No. more than 5 Days", night_patients()[[3, 3]], icon = icon("calendar-day"),
      color = "red"
    )
  })
  
  output$trauma_boarders <- renderInfoBox({
    infoBox(
      "No. Boarded Yesterday", night_patients()[[3, 4]], icon = icon("passport"),
      color = "red"
    )
  })
  
  output$w31_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 31", style = "font-size: 150%;"), paste0(night_tx()[[1,3]], "/", night_tx()[[1,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_tx()[[1,3]])
    )
  })
  
  output$w33tx_night <- renderValueBox({
    
    valueBox(
      tags$h3("Ward 33", style = "font-size: 150%;"), paste0(night_surgery()[[2,3]], "/", night_tx()[[2,2]], " Available"), icon = icon("bed"),
      color = colour_empty_ward(night_tx()[[2,3]])
    )
  })
  


# Normal Night Capacity_Critical Care -------------------------------------

  night_cc <- reactive({
    req(input$file1)
    
    critcare <- read_excel(input$file1$datapath, sheet = 1, range = "F14:H18", col_names = F)
    
    critcare <- critcare[, -2]
    
    Compliment <- stri_extract_all_regex(critcare[, 1], "[0-9]+")
    
    Compliment <- as.numeric(Compliment[[1]])
    
    critcare <- cbind(critcare, Compliment)
    
    colnames(critcare) <- c("Ward", "Empty", "Compliment")
    
    critcare$Ward <- gsub("[0-9]+", "", critcare$Ward)
    
    critcare$Ward <- gsub(" \\(", "", critcare$Ward)
    
    critcare$Ward <- gsub("\\)", "", critcare$Ward)
    
    return(critcare)
    
  })  
  
  output$nc_icu <- renderInfoBox({
    infoBox(title = "ICU Empty Beds", value = paste0(night_cc()[[1,2]], "/", night_cc()[[1,3]]), 
            color = "navy", icon = icon("lungs"))
  })
  
  
  output$nc_shdu <- renderInfoBox({
    infoBox(title = "SHDU Empty Beds", value = paste0(night_cc()[[2,2]], "/", night_cc()[[2,3]]), 
            color = "navy", icon = icon("user-injured"))
  })
  
  output$nc_mhdu <- renderInfoBox({
    infoBox(title = "MHDU Empty Beds", value = paste0(night_cc()[[3,2]], "/", night_cc()[[3,3]]), 
            color = "navy", icon = icon("stethoscope"))
  })
  
  output$nc_rhdu <- renderInfoBox({
    infoBox(title = "Renal HDU Empty Beds", value = paste0(night_cc()[[4,2]], "/", night_cc()[[4,3]]), 
            color = "navy", icon = icon("weight"))
  })
  
  output$nc_ccu <- renderInfoBox({
    infoBox(title = "CCU Empty Beds", value = paste0(night_cc()[[5,2]], "/", night_cc()[[5,3]]), 
            color = "navy", icon = icon("heartbeat"))
  })
  
  

# Normal Night Capacity_Additional Capacity -------------------------------

  nc_add <- reactive({
    req(input$file1)
    
    extra <- read_excel(input$file1$datapath, sheet = 1, range = "F24:H28", col_names = F)
    
    colnames(extra) <- c("Ward", "Capacity", "Used")
    
    return(extra)
  })
  
  colour_add <- function(x){
    colour <- ifelse(x > 0, "red", "navy")
    
    return(colour)
  }
  
  output$nc_add1 <- renderInfoBox({
    
    infoBox(title = nc_add()[[1,1]], value = paste0(nc_add()[[1,3]], " Used/", nc_add()[[1,2]], " Agreed"),
            color = colour_add(nc_add()[[1,3]]), icon = icon("bed"))
    
  })
  
  output$nc_add2 <- renderInfoBox({
    
    infoBox(title = nc_add()[[2,1]], value = paste0(nc_add()[[2,3]], " Used/", nc_add()[[2,2]], " Agreed"),
            color = colour_add(nc_add()[[2,3]]), icon = icon("bed"))
    
  })
  
  output$nc_add3 <- renderInfoBox({
    
    infoBox(title = nc_add()[[3,1]], value = paste0(nc_add()[[3,3]], " Used/", nc_add()[[3,2]], " Agreed"),
            color = colour_add(nc_add()[[3,3]]), icon = icon("bed"))
    
  })
  
  output$nc_add4 <- renderInfoBox({
    
    infoBox(title = nc_add()[[4,1]], value = paste0(nc_add()[[4,3]], " Used/", nc_add()[[4,2]], " Agreed"),
            color = colour_add(nc_add()[[4,3]]), icon = icon("bed"))
    
  })
  
  output$nc_add5 <- renderInfoBox({
    
    infoBox(title = nc_add()[[5,1]], value = paste0(nc_add()[[5,3]], " Used/", nc_add()[[5,2]], " Agreed"),
            color = colour_add(nc_add()[[5,3]]), icon = icon("bed"))
    
  })
  
  


# Other/Misc --------------------------------------------------------------

  output$comments <- renderInfoBox({
    
    req(input$file1)
    
    comm <- read_excel(input$file1$datapath, sheet = 1, range = "J20", col_names = F)
    
    infoBox(title = "Other Comments or Reported Incidents", value = comm[[1,1]], color = "teal", icon = icon("comments"))
    
  })  
  
  output$calls <- renderText({
    
    req(input$file1)
    
    calls <- read_excel(input$file1$datapath, sheet = 1, range = "J27:K29", col_names = F)
    
    colnames(calls) <- c("Time", "Nature")
    
    if(is.character(calls$Time) == F){
      calls$Time <- format(calls$Time, "%T")
    }else{
      calls$Time <- calls$Time
    }
    
    calls <- calls %>%
      select("Time of Call" = Time,
             "Calls after 8 PM to On-call Manager Escalation" = Nature) 
    kable(calls, "html", align = "c") %>%
      kable_styling(full_width = F, font_size = 16) %>%
      row_spec(0, bold = T, color = "white", background = "#008080", align = "center") %>%
      row_spec(1:nrow(calls), color = "white", background = "#a6bf92", align = "center")

    
  })
  
  


# Normal Safety Huddle ----------------------------------------------------

  output$bed_occ <- renderInfoBox({
    req(input$file1)
    
    adult_occ1 <- read_excel(input$file1$datapath, sheet = 2, range = "E2", col_names = F)
    
    adult_occ2 <- read_excel(input$file1$datapath, sheet = 2, range = "G2", col_names = F)
    
    infoBox(title = "Adult Bed Occupancy", color = "navy",
            value = paste0(adult_occ1, "/", adult_occ2), icon = icon("bed"))
    
  })    
  
  colour.occ <- function(x, y){
    if(x/y >= 0.9){
      colour <- "red"
    }else if(x/y < 0.9 | x/y >= 0.8){
      colour <- "yellow"
    }else if(x/y < 0.8){
      colour <- "green"
    }
    
    return(colour)
  }
  
  output$occ_percent <- renderValueBox({
    req(input$file1)
    
    adult_occ1 <- read_excel(input$file1$datapath, sheet = 2, range = "E2", col_names = F)
    
    adult_occ2 <- read_excel(input$file1$datapath, sheet = 2, range = "G2", col_names = F)
    
    valueBox(value = paste0(round((adult_occ1/adult_occ2)*100, 1), "%"), subtitle = "Occupancy",
             color = colour.occ(adult_occ1, adult_occ2))
    
  })
  
  output$add_occ <- renderInfoBox({
    req(input$file1)
    
    add_occ1 <- read_excel(input$file1$datapath, sheet = 2, range = "E3", col_names = F)
    
    add_occ2 <- read_excel(input$file1$datapath, sheet = 2, range = "G3", col_names = F)
    
    infoBox(title = "Additional Capacity in Use", color = "navy",
            value = paste0(add_occ1, "/", add_occ2), icon = icon("bed"))
    
  })
  
  output$add_percent <- renderValueBox({
    req(input$file1)
    
    add_occ1 <- read_excel(input$file1$datapath, sheet = 2, range = "E3", col_names = F)
    
    add_occ2 <- read_excel(input$file1$datapath, sheet = 2, range = "G3", col_names = F)
    
    valueBox(value = paste0(round((add_occ1/add_occ2)*100, 1), "%"), subtitle = "Occupancy",
             color = colour.occ(add_occ1, add_occ2))
    
  })
  
  HAN <- reactive({
    req(input$file1)
    
    HAN_table <- read_excel("SitRep01.xlsm", sheet = 2, range = "A17:F22", col_names = F)
    
    HAN_table <- HAN_table %>%
      select(-c(2:5))
    
    colnames(HAN_table) <- c("event", "numbers")
    
    return(HAN_table)
  })
  
  output$han1 <- renderInfoBox({
    colour <- ifelse(HAN()[[1, 2]] > 0, "red", "green")
    
    infoBox(title = "Falls Reported", value = HAN()[[1, 2]], icon = icon("wheelchair"), color = colour)
  })
  
  output$han2 <- renderInfoBox({
    colour <- ifelse(HAN()[[2, 2]] > 0, "red", "green")
    
    infoBox(title = "Expected Deaths", value = HAN()[[2, 2]], icon = icon("book-dead"), color = colour)
  })
  
  output$han3 <- renderInfoBox({
    colour <- ifelse(HAN()[[3, 2]] > 0, "red", "green")
    
    infoBox(title = "Unexpected Deaths", value = HAN()[[3, 2]], icon = icon("skull-crossbones"), color = colour)
  })
  
  output$han4 <- renderInfoBox({
    colour <- ifelse(HAN()[[4, 2]] > 0, "red", "green")
    
    infoBox(title = "Early Reviews Required", value = HAN()[[4, 2]], icon = icon("file-medical"), color = colour)
  })
  
  
  output$han5 <- renderInfoBox({
    colour <- ifelse(HAN()[[5, 2]] > 0, "red", "green")
    
    infoBox(title = "Cardiac Arrests", value = HAN()[[5, 2]], icon = icon("heartbeat"), color = colour)
  })
  
  output$han6 <- renderInfoBox({
    colour <- ifelse(HAN()[[6, 2]] > 0, "red", "green")
    
    infoBox(title = "Reviews for Delirium", value = HAN()[[6, 2]], icon = icon("clipboard-check"), color = colour)
  })
  
  
  output$sh_ed1 <- renderInfoBox({
    req(input$file1)
    
    ED_present <- read_excel(input$file1$datapath, sheet = 2, range = "E6", col_names = F)
    
    infoBox(title = "Total ED Presentations", value = ED_present[[1,1]], color = "navy", icon = icon("hospital-user"))
    
  })
  
  output$sh_ed2 <- renderInfoBox({
    req(input$file1)
    
    ED_breach <- read_excel(input$file1$datapath, sheet = 2, range = "E7", col_names = F)
    
    infoBox(title = "Breaches", value = ED_breach[[1,1]], color = ifelse(ED_breach[[1,1]] == 0, "green", "purple"), icon = icon("stopwatch"))
    
  })
  
  output$sh_ed3 <- renderValueBox({
    req(input$file1)
    
    ED_present <- read_excel(input$file1$datapath, sheet = 2, range = "E6", col_names = F)
    
    ED_breach <- read_excel(input$file1$datapath, sheet = 2, range = "E7", col_names = F)
    
    ED_perform <- (ED_present - ED_breach)/ED_present
    
    valueBox(value = paste0(round(ED_perform*100, 1), "%"), subtitle = "Performance", color = ifelse(ED_perform >= 0.95, "green", "red"))
  })
  
  output$ec_admit <- renderInfoBox({
    req(input$file1)
    
    EC_admit1 <- read_excel(input$file1$datapath, sheet = 2, range = "E8", col_names = F)
    
    EC_admit2 <- read_excel(input$file1$datapath, sheet = 2, range = "G8", col_names = F)
    
    infoBox(title = "Admissions against Predicted EC", value = paste0(EC_admit1, "/", EC_admit2), color = "light-blue", icon = icon("ambulance"))
    
  })
  
  output$pc_admit <- renderInfoBox({
    req(input$file1)
    
    PC_admit1 <- read_excel(input$file1$datapath, sheet = 2, range = "E9", col_names = F)
    
    PC_admit2 <- read_excel(input$file1$datapath, sheet = 2, range = "G9", col_names = F)
    
    infoBox(title = "Admissions against Predicted PC", value = paste0(PC_admit1, "/", PC_admit2), color = "teal", icon = icon("ambulance"))
    
  })
  
  output$ec_dc1 <- renderInfoBox({
    req(input$file1)
    
    EC_discharge1 <- read_excel(input$file1$datapath, sheet = 2, range = "L8", col_names = F)
    
    infoBox(title = "Discharges Achieved EC", value = EC_discharge1, color = "light-blue", icon = icon("home"))
  })
  
  output$ec_dc2 <- renderValueBox({
    req(input$file1)
    
    EC_discharge2 <- read_excel(input$file1$datapath, sheet = 2, range = "M8", col_names = F)
    
    valueBox(value = EC_discharge2, subtitle = "Balance", color = ifelse(EC_discharge2 < 0, "red", "green"))
    
  })
  
  output$ec_dc3 <- renderValueBox({
    req(input$file1)
    
    EC_discharge3 <- read_excel(input$file1$datapath, sheet = 2, range = "O8", col_names = F)
    
    valueBox(value = EC_discharge3, subtitle = "Before 1PM")
    
  })
  
  output$pc_dc1 <- renderInfoBox({
    req(input$file1)
    
    PC_discharge1 <- read_excel(input$file1$datapath, sheet = 2, range = "L9", col_names = F)
    
    infoBox(title = "Discharges Achieved PC", value = PC_discharge1, color = "teal", icon = icon("home"))
  })
  
  output$pc_dc2 <- renderValueBox({
    req(input$file1)
    
    PC_discharge2 <- read_excel(input$file1$datapath, sheet = 2, range = "M9", col_names = F)
    
    valueBox(value = PC_discharge2, subtitle = "Balance", color = ifelse(PC_discharge2 < 0, "red", "green"))
    
  })
  
  output$pc_dc3 <- renderValueBox({
    req(input$file1)
    
    PC_discharge3 <- read_excel(input$file1$datapath, sheet = 2, range = "O9", col_names = F)
    
    valueBox(value = PC_discharge3, subtitle = "Before 1PM")
    
  })
  
  output$total_dc <- renderInfoBox({
    req(input$file1)
    
    total_patients <- read_excel(input$file1$datapath, sheet = 2, range = "M10", col_names = F)
    
    infoBox(title = "Total Patients", value = total_patients, color = ifelse(total_patients < 0, "red", "green"), icon = icon("calculator"))
  
  })
  
  output$aa_present <- renderInfoBox({
    req(input$file1)
    
    AA_present <- read_excel(input$file1$datapath, sheet = 2, range = "E12", col_names = F)
    
    infoBox("Total Presentations", value = AA_present, color = "navy", icon = icon("hospital-user"))
    
  })
  
  output$aa_dc <- renderInfoBox({
    req(input$file1)
    
    AA_discharge <- read_excel(input$file1$datapath, sheet = 2, range = "M12", col_names = F)
    
    infoBox("Total Discharges", color = "navy", value = AA_discharge, icon = icon("home"))
    
  })
  
  output$aa_transfer1 <- renderInfoBox({
    req(input$file1)
    
    AU1_tansfer1 <- read_excel(input$file1$datapath, sheet = 2, range = "F14", col_names = F)
    
    infoBox("08:00 to 13:00", color = "green", value = AU1_tansfer1, icon = icon("clock"))
    
  })
  
  output$aa_transfer2 <- renderInfoBox({
    req(input$file1)
    
    AU1_tansfer2 <- read_excel(input$file1$datapath, sheet = 2, range = "J14", col_names = F)
    
    infoBox("13:00 to 20:00", color = "yellow", value = AU1_tansfer2, icon = icon("clock"))
    
  })
  
  output$aa_transfer3 <- renderInfoBox({
    req(input$file1)
    
    AU1_tansfer3 <- read_excel(input$file1$datapath, sheet = 2, range = "N14", col_names = F)
    
    infoBox("After 20:00", color = "red", value = AU1_tansfer3, icon = icon("clock"))
    
  })
  
# COVID Section -----------------------------------------------------------
  
  nrc_summary <- reactive({
    
    req(input$file2)
    
    sum_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B7:E13", col_names = F) %>%
      select("Summary" = ...1,
             "Numbers" = ...4)
    
    return(sum_nrc)
    
  })
  
  output$nrc_electives <- renderInfoBox({
    infoBox("Electives", value = nrc_summary()[[1, 2]], color = "blue", icon = icon("clipboard-list"))
  })
  output$nrc_predicted <- renderInfoBox({
    infoBox("Predicted Emergency Admissions", value = nrc_summary()[[2, 2]], color = "red", icon = icon("hospital"))  
  })
  output$nrc_total <- renderInfoBox({
    infoBox("Total", value = nrc_summary()[[3, 2]], color = "blue", icon = icon("calculator"))
  })
  output$nrc_admissions <- renderInfoBox({
    infoBox("Admissions So Far", value = nrc_summary()[[4, 2]], color = "blue", icon = icon("hospital"))
  })
  output$nrc_remain <- renderInfoBox({
    infoBox("Remaining Today", value = nrc_summary()[[5, 2]], color = "blue", icon = icon("clipboard"))
  })
  output$nrc_beds <- renderInfoBox({
    color_bed <- function(){
      if(nrc_summary()[[6, 2]] >= 15){
        colour <- "green"
      }else if(nrc_summary()[[6, 2]] < 15 & nrc_summary()[[6, 2]] >= 10){
        colour <- "yellow"
      }else if(nrc_summary()[[6, 2]] < 10){
        colour <- "red"
      }
  
      return(colour)  
    }
    
    infoBox("Beds Available", value = nrc_summary()[[6, 2]], color = color_bed(), icon = icon("bed"))
  })
  
  output$nrc_dc_expected <- renderInfoBox({
    infoBox("Expected Discharges", value = nrc_summary()[[7, 2]], color = "blue", icon = icon("home"))
  })
  
  nrc_ed <- reactive({
    req(input$file2$datapath)
    
    ed_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I18:M18", col_names = F)
    
    new_col <- c("Total", "Longest", "Assess", "DTA", "Breaches")
    
    colnames(ed_nrc) <- new_col
    
    if(is.character(ed_nrc$Longest) == F){
      ed_nrc$Longest <- format(ed_nrc$Longest, "%T")
    }else{
      ed_nrc$Longest < ed_nrc$Longest
    }
    
    if(is.character(ed_nrc$Assess) == F){
      ed_nrc$Assess <- format(ed_nrc$Assess, "%T")
    }else{
      ed_nrc$Assess < ed_nrc$Assess
    }
      
    return(ed_nrc)
    
  })
  
  output$nrc_ED_1 <- renderInfoBox({
    infoBox("Total in ED", value = nrc_ed()[[1, 1]], color = "blue", icon = icon("hospital-user"))
  })
  output$nrc_ED_2 <- renderInfoBox({
    infoBox("Longest Wait", value = nrc_ed()[[1, 2]], color = "yellow", icon = icon("clock"))
  })
  output$nrc_ED_3 <- renderInfoBox({
    infoBox("Time to Assessment", value = nrc_ed()[[1, 3]], color = "yellow", icon = icon("stopwatch"))
  })
  output$nrc_ED_4 <- renderInfoBox({
    infoBox("No. with DTA", value = nrc_ed()[[1, 4]], color = colour_numbers(nrc_ed()[[1, 4]]), icon = icon("hospital"))
  })
  output$nrc_ED_5 <- renderInfoBox({
    infoBox("Breaches since Midnight", value = nrc_ed()[[1, 5]], color = colour_breaches(nrc_ed()[[1, 5]]), icon = icon("stopwatch"))
  })
  
  nrc_flow <- reactive({
    
    req(input$file2)
    
    flow_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B18:G42", col_names = F)
    
    colnames(flow_nrc) <- c("Ward", "Compliment", "Empty", "Electives", "DC_Expected", "DC_Achieved")
    
    flow_nrc[8, 1] <- "22 Red"
    flow_nrc[12, 1] <- "34 Red"
    
    redzones <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    flow_nrc <- flow_nrc %>%
      mutate("RedZone" = ifelse(Ward %in% redzones, T, F))
    
    flow_nrc$Empty <- as.numeric(flow_nrc$Empty)
    
    return(flow_nrc)
    
  })
  
  output$nrc_red_flow <- renderText({
    
    nrc_flow.df <- nrc_flow() 
    
    nrc_red <- nrc_flow.df %>%
      filter(RedZone == T) %>%
      select(-7) 
    
    nrc_red$Empty <- as.double(nrc_red$Empty)
    
    nrc_red <- nrc_red %>%
      mutate(Empty.color = cell_spec(Empty, "html", bold = T, color = "white", background = if_else(Empty >= 5, "#56b34b", "#c64040", "#1b1c21"))) %>% 
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.color,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
             )
      
    
    kable(nrc_red, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(nrc_red), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
    })
  
  output$nrc_green_flow <- renderText({
    
    nrc_flow.df <- nrc_flow() 
    
    nrc_green <- nrc_flow.df %>%
      filter(RedZone == F) %>%
      select(-7) 
    
    nrc_green$Empty <- as.double(nrc_green$Empty)
    
    nrc_green <- nrc_green %>%
      mutate(Empty.color = cell_spec(Empty, "html", bold = T, color = "white", background = if_else(Empty >= 5, "#56b34b", "#c64040", "#1b1c21"))) %>% 
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.color,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
      )
    
    
    kable(nrc_green, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(nrc_green), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  output$nrc_flow_sum <- renderText({
    df <- nrc_flow()
    
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
    
    rownames(sum_flow) <- NULL
    
    sum_flow <- sum_flow %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved
      )
    
    kable(sum_flow, "html") %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1, align = "center", background = "#c64040", color = "white") %>%
      row_spec(2, align = "center", background = "#56b34b", color = "white") %>%
      row_spec(3, align = "center", background = "#5f6fa2", bold = T, color = "white") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), color = "black")
    
    })
  
  output$trauma_flow <- renderInfoBox({
    req(input$file2)
    trauma_list <- read_excel(input$file2$datapath, sheet = 2, range = "B44:E44", col_names = F)
    
    trauma_list <- trauma_list[, -2]
    
    infoBox(title = "Trauma List", value = trauma_list[1, 3], icon = icon("bone"), color = "blue")
  })
  
  output$SEAL_flow <- renderInfoBox({
    
    df <- nrc_flow()
    
    infoBox(title = "SEAL Electives", value = df[[25, 4]], icon = icon("clipboard-list"), color = "blue")
    
  })
  
  output$nrc_wac <- renderText({
    req(input$file2)
    
    wac_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "B49:G59", col_names = F)
    
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
    
    wac_nrc$Empty <- as.numeric(wac_nrc$Empty)
    
    wac_nrc <- wac_nrc %>%
      mutate(Empty.color = cell_spec(Empty, "html", bold = T, color = "white", background = if_else(Empty >= 5, "#56b34b", "#c64040", "#1b1c21"))) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.color,
             "Electives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges by 1PM" = DC_Achieved
      )
    
    kable(wac_nrc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  au <- reactive({
    req(input$file2)
    
    au1_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I36:M36", col_names = F)
    au2_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I43:M43", col_names = F)
    
    au_nrc <- rbind(au1_nrc, au2_nrc) %>%
      mutate("Ward" = c("AU 1", "AU2"))
    au_nrc <- au_nrc[, c(6, 1:5)]
    
    colnames(au_nrc) <- c("Ward", "Patients", "Required", "DC", "Ongoing", "GPTCI")
    
    return(au_nrc)

    
  })
  
  output$au1_px <- renderInfoBox({
    infoBox("Patients Now", value = au()[[1,2]], color = "blue", icon = icon("procedures"))
  })
  output$au1_beds <- renderInfoBox({
    infoBox("Beds Required", value = au()[[1,3]], color = "yellow", icon = icon("bed"))
  })
  output$au1_dc <- renderInfoBox({
    infoBox("Discharges", value = au()[[1,4]], color = "green", icon = icon("home"))
  })
  output$au1_ongoing <- renderInfoBox({
    infoBox("Ongoing Assessment", value = au()[[1,5]], color = "yellow", icon = icon("clipboard-check"))
  })
  output$au1_gp <- renderInfoBox({
    infoBox("To Come In", value = au()[[1,6]], color = "red", icon = icon("ambulance"))
  })
  
  output$au2_px <- renderInfoBox({
    infoBox("Patients Now", value = au()[[2,2]], color = "blue", icon = icon("procedures"))
  })
  output$au2_beds <- renderInfoBox({
    infoBox("Beds Required", value = au()[[2,3]], color = "yellow", icon = icon("bed"))
  })
  output$au2_dc <- renderInfoBox({
    infoBox("Discharges", value = au()[[2,4]], color = "green", icon = icon("home"))
  })
  output$au2_ongoing <- renderInfoBox({
    infoBox("Ongoing Assessment", value = au()[[2,5]], color = "yellow", icon = icon("clipboard-check"))
  })
  output$au2_gp <- renderInfoBox({
    infoBox("To Come In", value = au()[[2,6]], color = "red", icon = icon("ambulance"))
  })
  
  output$nrc_critcare <- renderText({
    
    req(input$file2)
    
    critcare_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I25:N30", col_names = F)
    
    colnames(critcare_nrc) <- c("Ward", "Empty", "Fit", "Admissions", "Discharges", "Compliment")
    
    cc_wards <- c("ITU Red", "ITU Green", "SHDU Green", "MHDU Red", "RHDU", "CCU/MHDU Green")
    
    critcare_nrc[, 1] <- cc_wards
    
    critcare_nrc <- critcare_nrc %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty,
             "Fit for Discharge" = Fit,
             "Admissions Today" = Admissions,
             "Discharges Expected" = Discharges)
    
    kable(critcare_nrc, "html") %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black")
    
  })
  
  output$COVID_date <- renderText({
    req(input$file2)
    
    report_date <- read_excel(input$file2$datapath, sheet = 2, range = "C4", col_names = F)
    
    report_date <- report_date[[1]]
    
    if(is.character(report_date) == F){
      report_date <- as.character(report_date)
    }else{
      report_date < report_date
    }
    
    return(report_date)
    
    report_date
  })
  
  output$nrc_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 2, range = "I49:M52", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
    })
  
  ed_shc <- reactive({
    req(input$file2)
    
    shc_ed <- read_excel(input$file2$datapath, sheet = 1, range = "B3:E3", col_names = F)
    
    shc_ed <- select(shc_ed, total = 2, DTA = 4)
    
    return(shc_ed)
  })
  
  output$shc_ed1 <- renderInfoBox({
    infoBox("Total in ED", value = ed_shc()[[1,1]], color = "blue", icon = icon("hospital-user"))
  })
  
  output$shc_ed2 <- renderInfoBox({
    infoBox("No. with DTA", value = ed_shc()[[1,2]], color = "blue", icon = icon("hospital"))
  })
  
  output$shc_cc1 <- renderInfoBox({
    req(input$file2)
    shc_icu_red <- read_excel(input$file2$datapath, sheet = 1, range = "C5:C5", col_names = F)
    
    infoBox(title = "ICU Red", value = shc_icu_red[[1,1]], color = "red", fill = T, icon = icon("lungs"))
  })
  
  output$shc_cc2 <- renderInfoBox({
    req(input$file2)
    shc_icu_green <- read_excel(input$file2$datapath, sheet = 1, range = "E5", col_names = F)
    
    infoBox(title = "ICU Green", value = shc_icu_green[[1,1]], color = "green", fill = T, icon = icon("lungs"))
  })
  
  output$shc_cc3 <- renderInfoBox({
    req(input$file2)
    shc_rhdu <- read_excel(input$file2$datapath, sheet = 1, range = "G5", col_names = F)
    
    infoBox(title = "Renal HDU", value = shc_rhdu[[1,1]], color = "green", fill = T, icon = icon("weight"))
  })
  
  output$shc_cc4 <- renderInfoBox({
    req(input$file2)
    shc_mhdu <- read_excel(input$file2$datapath, sheet = 1, range = "C6", col_names = F)
    
    infoBox(title = "MHDU Red", value = shc_mhdu[[1,1]], color = "red", fill = T, icon = icon("stethoscope"))
  })
  
  output$shc_cc5 <- renderInfoBox({
    req(input$file2)
    shc_ccu <- read_excel(input$file2$datapath, sheet = 1, range = "E6", col_names = F)
    
    infoBox(title = "MHDU/CCU Green", value = shc_ccu[[1,1]], color = "green", fill = T, icon = icon("heartbeat"))
  })
  
  output$shc_cc6 <- renderInfoBox({
    req(input$file2)
    shc_shdu <- read_excel(input$file2$datapath, sheet = 1, range = "G6", col_names = F)
    
    infoBox(title = "SHDU Green", value = shc_shdu[[1,1]], color = "green", fill = T, icon = icon("user-injured"))
  })
  
  output$red_wards <- renderInfoBox({
    req(input$file2)
    shc_red_wards <- read_excel(input$file2$datapath, sheet = 1, range = "D8", col_names = F)
    
    infoBox(title = "In-Patient Red Wards", value = shc_red_wards[[1,1]], color = "red", icon = icon("grip-horizontal"))
    
  })
  
  output$red_zones <- renderInfoBox({
    req(input$file2)
    shc_red_zones <- read_excel(input$file2$datapath, sheet = 1, range = "D9", col_names = F)
    
    infoBox(title = "Wards with Red Zones", value = shc_red_zones[[1,1]], color = "maroon", icon = icon("grip-horizontal"))
    
  })
  
  output$shc_occ1 <- renderInfoBox({
    req(input$file2)
    shc_aured_occ <- read_excel(input$file2$datapath, sheet = 1, range = "C10", col_names = F)
    
  infoBox(title = "Red AU1 Occupancy", value = paste0(round(shc_aured_occ[[1,1]]*100, 1), "%"), color ="red", icon = icon("percent"))  
    
  })
  
  output$shc_occ2 <- renderInfoBox({
    req(input$file2)
    shc_red_avail <- read_excel(input$file2$datapath, sheet = 1, range = "C11", col_names = F)    
    
    infoBox(title = "Red Zone Beds Available", value = shc_red_avail[[1,1]], color ="red", icon = icon("bed"))  
    
  })
  
  output$shc_occ3 <- renderInfoBox({
    req(input$file2)
    shc_red_pat <- read_excel(input$file2$datapath, sheet = 1, range = "E11", col_names = F)  
    
    infoBox(title = "No. of Red Zone Patients", value = shc_red_pat[[1,1]], color ="red", icon = icon("procedures"))  
    
  })
  
  output$shc_occ4 <- renderInfoBox({
    req(input$file2)
    shc_totalred_occ <- read_excel(input$file2$datapath, sheet = 1, range = "G11", col_names = F)
    
    infoBox(title = "Total Red Occupancy", value = paste0(round(shc_totalred_occ[[1,1]]*100, 1), "%"), color ="red", icon = icon("percent"))  
    
  })
  
  output$shc_occ5 <- renderInfoBox({
    req(input$file2)
    shc_augreen_occ <- read_excel(input$file2$datapath, sheet = 1, range = "E10", col_names = F)
    
    infoBox(title = "Green AU1 & 2 Occupancy", value = paste0(round(shc_augreen_occ[[1,1]]*100, 1), "%"), color = "green", icon = icon("percent"))
  })
  
  output$shc_occ6 <- renderInfoBox({
    req(input$file2)
    shc_totalgreen_occ <- read_excel(input$file2$datapath, sheet = 1, range = "G10", col_names = F)
    
    infoBox(title = "Total Occupancy", value = paste0(round(shc_totalgreen_occ[[1,1]]*100, 1), "%"), color = "green", icon = icon("percent"))
  })
  
  output$shc_pc <- renderInfoBox({
    req(input$file2)
    shc_pc_urgent <- read_excel(input$file2$datapath, sheet = 1, range = "D13", col_names = F)
    
    infoBox(title = "Urgent Planned Care Admissions", value = shc_pc_urgent[[1,1]], color = "yellow", icon = icon("ambulance"))
  })
  
  output$shc_mat <- renderInfoBox({
    req(input$file2)
    shc_mat_beds <- read_excel(input$file2$datapath, sheet = 1, range = "D16", col_names = F)
    
    infoBox(title = "Maternity Empty Beds", value = shc_mat_beds[[1,1]], color = "blue", icon = icon("female"))
  })
  
  shc_paeds_neo <- reactive({
    req(input$file2)
    
    shc_paedsneo <- read_excel(input$file2$datapath, sheet = 1, range = "C18:G20", col_names = F)%>%
      mutate("Ward" = c("Paeds", NA, "Neonates")) %>%
      filter(!is.na(...1)) %>% 
      select(Ward, "Red_Patients" = ...1,
             "Red_Beds" = ...3, 
             "Green_Beds" = ...5)
    return(shc_paedsneo)
  })
  
  output$shc_paeds1 <- renderInfoBox({
    infoBox(title = "Red Paeds Patients", value = shc_paeds_neo()[[1,2]], color = "red", icon = icon("child"))
  })
  
  output$shc_paeds2 <- renderInfoBox({
    infoBox(title = "Red Paeds Empty Beds", value = shc_paeds_neo()[[1,3]], color = "red", icon = icon("bed"))
  })
  
  output$shc_paeds3 <- renderInfoBox({
    infoBox(title = "Green Paeds Empty Beds", value = shc_paeds_neo()[[1,4]], color = "green", icon = icon("bed"))
  })
  
  output$shc_neo1 <- renderInfoBox({
    infoBox(title = "Red Neonate Patients", value = shc_paeds_neo()[[2,2]], color = "red", icon = icon("baby"))
  })
  
  output$shc_neo2 <- renderInfoBox({
    infoBox(title = "Red Neonate Empty Beds", value = shc_paeds_neo()[[2,3]], color = "red", icon = icon("bed"))
  })
  
  output$shc_neo3 <- renderInfoBox({
    infoBox(title = "Green Neonate Empty Beds", value = shc_paeds_neo()[[2,4]], color = "green", icon = icon("bed"))
  })
  
  shc_care <- reactive({
    req(input$file2)
    shc_concerns <- read_excel(input$file2$datapath, sheet = 1, range = "H3:L15", col_names = F, trim_ws = T) %>%
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
    
    return(shc_concerns)
  })
  
  output$shc_care_con <- renderText({
    care_kable <- shc_care()
    
    kable(care_kable, "html") %>%
      kable_styling(full_width = T, font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#f0e2c3", color = "#090b15") %>%
      row_spec(1:4, align = "left", background = "#c8c26c") %>%
      row_spec(5:6, align = "left", background = "#e8bd8b") %>%
      column_spec(1, bold = T, color = "#1c2039", width = "12em") %>%
      column_spec(2, bold = "F", background = "#ca6454", color = "white")
    
  })
  
  shc_ss <- reactive({
    req(input$file2)
    
    shc_support <- read_excel(input$file2$datapath, sheet = 1, range = "P4:W15", col_names = F, trim_ws = T) %>%
      filter(!is.na(...1)) %>%
      select("Department" = ...1,
             "Details" = ...5)
    
    shc_support[3,1] <- "INFECTION PREVENTION & CONTROL (EXT 28102)"
    
    return(shc_support)
  })
  
  output$shc_ss1 <- renderInfoBox({
    infoBox(title = "Laboratories (Ext 28102)", value = shc_ss()[[1, 2]], color = "navy", icon = icon("microscope"))
  })
  
  output$shc_ss2 <- renderInfoBox({
    infoBox(title = "Radiology (Ext 28325)", value = shc_ss()[[2, 2]], color = "navy", icon = icon("x-ray"))
  })
  
  output$shc_ss3 <- renderInfoBox({
    infoBox(title = "Infection Prevention & Control (Ext 28102)", value = shc_ss()[[3, 2]], color = "fuchsia", icon = icon("shield-virus"))
  })
  
  output$shc_ss4 <- renderInfoBox({
    infoBox(title = "Pharmacy (Ext 21052)", value = shc_ss()[[4, 2]], color = "olive", icon = icon("prescription"))
  })
  
  output$shc_ss5 <- renderInfoBox({
    infoBox(title = "Estates, Portering & Facilities", value = shc_ss()[[5, 2]], color = "teal", icon = icon("wrench"))
  })
  
  output$shc_ss6 <- renderInfoBox({
    infoBox(title = "Discharge Hub (Ext 23990)", value = shc_ss()[[6, 2]], color = "blue", icon = icon("home"))
  })
  
  output$shc_ss7 <- renderInfoBox({
    infoBox(title = "Procurement (Ext 21346)", value = shc_ss()[[7, 2]], color = "teal", icon = icon("shopping-cart"))
  })
  

# COVID 8:30 --------------------------------------------------------------

  c830_glance <- reactive({
    req(input$file2)
    
    covid830_sum <- read_excel(input$file2$datapath, sheet = 3, range = "B7:E14", col_names = F) %>%
      select(1, 4)
    
    return(covid830_sum)
  })  
  
  output$c830_glance1 <- renderInfoBox({
    infoBox(title = "Electives", value = c830_glance()[[1,2]], icon = icon("clipboard-list"), color = "blue", fill = T)
  })
  
  output$c830_glance2 <- renderInfoBox({
    infoBox(title = "Predicted Emergency Admissions", value = c830_glance()[[2,2]], icon = icon("hospital"), color = "yellow", fill = T)
  })
  
  output$c830_glance3 <- renderInfoBox({
    infoBox(title = "Total", value = c830_glance()[[3,2]], icon = icon("plus-square"), color = "navy", fill = T)
  })
  
  output$c830_glance4 <- renderInfoBox({
    infoBox(title = "Emergency Admissions So Far", value = c830_glance()[[4,2]], icon = icon("ambulance"), color = "maroon", fill = T)
  })
  
  output$c830_glance5 <- renderInfoBox({
    infoBox(title = "Remaining Today", value = c830_glance()[[5,2]], icon = icon("clipboard"), color = "maroon", fill = T)
  })
  
  output$c830_glance6 <- renderInfoBox({
    infoBox(title = "Beds Available Now", value = c830_glance()[[6,2]], icon = icon("bed"), color = "navy", fill = T)
  })
  
  output$c830_glance7 <- renderInfoBox({
    infoBox(title = "Expected Discharges", value = c830_glance()[[7,2]], icon = icon("home"), color = "green", fill = T)
  })
  
  output$c830_glance8 <- renderInfoBox({
    infoBox(title = "Predicted Balance", value = c830_glance()[[8,2]], icon = icon("balance-scale"), color = "navy", fill = T)
  })
  
  c830_ed <- reactive({
    req(input$file2)
    
    covid830_ed <- read_excel(input$file2$datapath, sheet = 3, range = "L19:S19", col_names = F)
    
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
    
    return(covid830_ed)
  })
  
  
  
  output$c830_ed1 <- renderInfoBox({
    infoBox(title = "Total in ED", value = c830_ed()[[1,1]], icon = icon("hospital-user"), color = "blue")
  })
  
  output$c830_ed2 <- renderInfoBox({
    infoBox(title = "Longest Wait", value = c830_ed()[[1,2]], icon = icon("clock"), color = "yellow")
  })
  
  output$c830_ed3 <- renderInfoBox({
    infoBox(title = "Time to Assessment", value = c830_ed()[[1,3]], icon = icon("stopwatch"), color = "yellow")
  })
  
  output$c830_ed4 <- renderInfoBox({
    infoBox(title = "No. with DTA", value = c830_ed()[[1,4]], icon = icon("hospital"), color = colour_numbers(c830_ed()[[1,4]]), fill = T)
  })
  
  output$c830_ed5 <- renderInfoBox({
    infoBox(title = "Breaches since Midnight", value = c830_ed()[[1,5]], icon = icon("stopwatch"), color = colour_breaches(c830_ed()[[1,5]]), fill = T)
  })
  
  output$c830_ed6 <- renderInfoBox({
    infoBox(title = "RN Shortfall", value = c830_ed()[[1,6]], icon = icon("user-nurse"), color = colour_rn(c830_ed()[[1,6]]), fill = T)
  })
  
  output$c830_ed7 <- renderInfoBox({
    infoBox(title = "Night RN Shortfall", value = c830_ed()[[1,7]], icon = icon("user-nurse"), color = colour_rn(c830_ed()[[1,7]]), fill = T)
  })
  
  output$c830_ed8 <- renderInfoBox({
    infoBox(title = "Safe to Start", value = c830_ed()[[1,8]], icon = icon("user-nurse"), color = colour_safe(c830_ed()[[1,8]]), fill = T)
  })
  
  output$c830_fl_sum1 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "C47", col_names = F)
    
    infoBox("Total Green Bed Compliment", value = val[[1,1]], color = "green", icon = icon("grip-horizontal"))
  })
  
  output$c830_fl_sum2 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "E47", col_names = F)
    
    infoBox("Total Green Empty Beds", value = val[[1,1]], color = "green", icon = icon("bed"))
  })
  
  output$c830_fl_sum3 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "G47", col_names = F)
    
    infoBox("Green Zone Occupancy", value = paste0(round(val[[1,1]]*100, 1), "%"), color = "green", icon = icon("percent"))
  })
  
  output$c830_fl_sum4 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "I47", col_names = F)
    
    infoBox("Green AU1 & 2 Occupancy", value = paste0(round(val[[1,1]]*100, 1), "%"), color = "green", icon = icon("percent"))
  })
  
  output$c830_fl_sum5 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "C48", col_names = F)
    
    infoBox("Total Red Bed Compliment", value = val[[1,1]], color = "red", icon = icon("grip-horizontal"))
  })
  
  output$c830_fl_sum6 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "E48", col_names = F)
    
    infoBox("Total Red Empty Beds", value = val[[1,1]], color = "red", icon = icon("bed"))
  })
  
  output$c830_fl_sum7 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "G48", col_names = F)
    
    infoBox("Red Zone Patients", value = val[[1,1]], color = "red", icon = icon("procedures"))
  })
  
  output$c830_fl_sum8 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "I48", col_names = F)
    
    infoBox("Red Zone Occupancy", value = paste0(round(val[[1,1]]*100, 1), "%"), color = "red", icon = icon("percent"))
  })
  
  output$c830_fl_sum9 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "M47", col_names = F)
    
    infoBox("Red AU1 Occupancy", value = paste0(round(val[[1,1]]*100, 1), "%"), color = "red", icon = icon("percent"))
  })
  
  output$c830_fl_sum10 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "E43", col_names = F)
    
    infoBox("SEAL Electives", value = val[[1,1]], color = "blue", icon = icon("clipboard-list"))
  })
  
  output$c830_fl_sum11 <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 3, range = "E45", col_names = F)
    
    infoBox("Trauma List", value = val[[1,1]], color = "blue", icon = icon("bone"))
  })
  
  c830_flow <- reactive({
    req(input$file2)
    
    columns_830 <- c("Ward", 
                     "Compliment",
                     "Empty",
                     "Electives",
                     "DC_Expected",
                     "DC_Achieved",
                     "RN",
                     "nRN",
                     "Safe")
    
    covid830_flow <- read_excel(input$file2$datapath, sheet = 3, range = "B19:J42", col_names = F)
    
    colnames(covid830_flow) <- columns_830
    
    covid830_flow[8, 1] <- "22 Red"
    covid830_flow[12, 1] <- "34 Red"
    
    covid830_flow$Empty <- as.numeric(covid830_flow$Empty)
    
    redzones_830 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    covid830_flow <- covid830_flow %>%
      mutate("RedZone" = ifelse(Ward %in% redzones_830, T, F))
    
    return(covid830_flow)
  })
  
  output$c830_red_flow <- renderText({
    
    df <- c830_flow() 
    
    red.total <- c("Total",
                   sum(df[df$RedZone == T, 2], na.rm = T),
                   sum(df[df$RedZone == T, 3], na.rm = T),
                   sum(df[df$RedZone == T, 4], na.rm = T),
                   sum(df[df$RedZone == T, 5], na.rm = T),
                   sum(df[df$RedZone == T, 6], na.rm = T),
                   "NA",
                   "NA",
                   "NA"
    )
    
    red.df <- df %>%
      filter(RedZone == T) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21")),
             RN.col = cell_spec(RN, bold = T, color = "white", background = if_else(RN > 0, "#c64040", "#56b34b", "#1b1c21")),
             nRN.col = cell_spec(nRN, bold = T, color = "white", background = if_else(nRN > 0, "#c64040", "#56b34b", "#1b1c21")),
             Safe.col = cell_spec(Safe, bold = T, color = "white", background = if_else((Safe == "No" | Safe == "N" | Safe == "no" | Safe == "n"), "#c64040", "#56b34b", "#1b1c21"))
             ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved,
             "RN Shortfall" = RN.col,
             "nRN Shortfall" = nRN.col,
             "Safe to Start" = Safe.col)
    
    red.df <- rbind(red.df, red.total)
    
    kable(red.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(red.df), align = "center") %>%
      column_spec(1, bold = T, width = "8em") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      column_spec(7:9, background = "#f4caa1", color = "white") %>%
      row_spec(nrow(red.df), bold = T, color = "white", background = "#A32020")
  })
  
  
  output$c830_green_flow <- renderText({
    
    df <- c830_flow() 
    
    green.total <- c("Total",
                   sum(df[df$RedZone == F, 2], na.rm = T),
                   sum(df[df$RedZone == F, 3], na.rm = T),
                   sum(df[df$RedZone == F, 4], na.rm = T),
                   sum(df[df$RedZone == F, 5], na.rm = T),
                   sum(df[df$RedZone == F, 6], na.rm = T),
                   "NA",
                   "NA",
                   "NA"
                   )
    
    green.df <- df %>%
      filter(RedZone == F) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21")),
             RN.col = cell_spec(RN, bold = T, color = "white", background = if_else(RN > 0, "#c64040", "#56b34b", "#1b1c21")),
             nRN.col = cell_spec(nRN, bold = T, color = "white", background = if_else(nRN > 0, "#c64040", "#56b34b", "#1b1c21")),
             Safe.col = cell_spec(Safe, bold = T, color = "white", background = if_else((Safe == "No" | Safe == "N" | Safe == "no" | Safe == "n"), "#c64040", "#56b34b", "#1b1c21"))
            ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved,
             "RN Shortfall" = RN.col,
             "nRN Shortfall" = nRN.col,
             "Safe to Start" = Safe.col)
    
    green.df <- rbind(green.df, green.total)
    
    kable(green.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(green.df), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      column_spec(7:9, background = "#f4caa1", color = "white") %>%
      row_spec(nrow(green.df), bold = T, color = "white", background = "#004C00")
    
  })
  
  c830_wac <- reactive({
    req(input$file2)
    
    covid830_wac <- read_excel(input$file2$datapath, sheet = 3, range = "B52:J62", col_names = F)
    
    colnames(covid830_wac) <- c("Ward", 
                                "Compliment",
                                "Empty",
                                "Electives",
                                "DC_Expected",
                                "DC_Achieved",
                                "RN",
                                "nRN",
                                "Safe")
    
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
    
    return(covid830_wac)
  })
  
  
  output$c830_wac_flow <- renderText({
    wac.df <- c830_wac() 
    
    wac.df$Empty <- as.numeric(wac.df$Empty)
    
    total <- c("Total",
               sum(wac.df[ , 2], na.rm = T),
               sum(wac.df[ , 3], na.rm = T),
               sum(wac.df[ , 4], na.rm = T),
               sum(wac.df[ , 5], na.rm = T),
               sum(wac.df[ , 6], na.rm = T),
               "NA",
               "NA",
               "NA",
               "NA")
    
    wac.df <- wac.df %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = ifelse(Empty > 5, "#56b34b", "#c64040")),
             RN.col = cell_spec(RN, bold = T, color = "white", background = if_else(RN > 0, "#c64040", "#56b34b", "#1b1c21")),
             nRN.col = cell_spec(nRN, bold = T, color = "white", background = if_else(nRN > 0, "#c64040", "#56b34b", "#1b1c21")),
             Safe.col = cell_spec(Safe, bold = T, color = "white", background = if_else((Safe == "No" | Safe == "N" | Safe == "no" | Safe == "n"), "#c64040", "#56b34b", "#1b1c21"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges by 1PM" = DC_Achieved,
             "RN Shortfall" = RN.col,
             "nRN Shortfall" = nRN.col,
             "Safe to Start" = Safe.col)
    
    wac.df <- rbind(wac.df, total)
    
    
    
    kable(wac.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      column_spec(7:9, background = "#f4caa1", color = "white") %>%
      row_spec(nrow(wac.df), bold = T, color = "white", align = "center", background = "#292e34")
  })
  
  c830_cc <- reactive({
    req(input$file2)
    covid830_cc <- read_excel(input$file2$datapath, sheet = 3, range = "L26:T31", col_names = F)
    
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
    
    covid830_cc[, 1] <- c("ICU Red",
                         "ICU Green",
                         "SHDU Green",
                         "MHDU Red",
                         "RHDU",
                         "CCU/MHDU Green")
    
    return(covid830_cc)
  })
  
  output$c830_cc_flow <- renderText({
    
    df.cc <- c830_cc() %>%
      mutate(RN.col = cell_spec(RN, bold = T, color = "white", background = if_else(RN > 0, "#c64040", "#56b34b", "#1b1c21")),
             nRN.col = cell_spec(nRN, bold = T, color = "white", background = if_else(nRN > 0, "#c64040", "#56b34b", "#1b1c21")),
             Safe.col = cell_spec(Safe, bold = T, color = "white", background = if_else((Safe == "No" | Safe == "N" | Safe == "no" | Safe == "n"), "#c64040", "#56b34b", "#1b1c21"))
            ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty,
             "Ward Fit" = Fit,
             "Admissions Today" = Admissions,
             "Discharges Expected" = DC_Expected,
             "RN Shortfall" = RN.col,
             "nRN Shortfall" = nRN.col,
             "Safe to Start" = Safe.col)
    
    kable(df.cc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      column_spec(7:9, background = "#f4caa1", color = "white")
  })
  
  c830_au1 <- reactive({
    req(input$file2)
    covid830_au1 <- read_excel(input$file2$datapath, sheet = 3, range = "L37:P39", col_names = F)
    
    return(covid830_au1)
  })

  output$c830_au11 <- renderInfoBox({
    df <- c830_au1()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c830_au12 <- renderInfoBox({
    df <- c830_au1()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c830_au13 <- renderInfoBox({
    df <- c830_au1()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c830_au14 <- renderInfoBox({
    df <- c830_au1()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c830_au15 <- renderInfoBox({
    df <- c830_au1()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  c830_au2 <- reactive({
    req(input$file2)
    covid830_au2 <- read_excel(input$file2$datapath, sheet = 3, range = "L43:P44", col_names = F)
    
    return(covid830_au2)
  })
  
  output$c830_au21 <- renderInfoBox({
    df <- c830_au2()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c830_au22 <- renderInfoBox({
    df <- c830_au2()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c830_au23 <- renderInfoBox({
    df <- c830_au2()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c830_au24 <- renderInfoBox({
    df <- c830_au2()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c830_au25 <- renderInfoBox({
    df <- c830_au2()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  output$c830_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 3, range = "L52:P55", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
  })

# COVID 13:00 -------------------------------------------------------------

  c13_glance <- reactive({
    req(input$file2)
    
    covid13_sum <- read_excel(input$file2$datapath, sheet = 4, range = "B7:E14", col_names = F) %>%
      select(1, 4)
    
    return(covid13_sum)
  })  
  
  output$c13_glance1 <- renderInfoBox({
    infoBox(title = "Electives", value = c13_glance()[[1,2]], icon = icon("clipboard-list"), color = "blue", fill = T)
  })
  
  output$c13_glance2 <- renderInfoBox({
    infoBox(title = "Predicted Emergency Admissions", value = c13_glance()[[2,2]], icon = icon("hospital"), color = "yellow", fill = T)
  })
  
  output$c13_glance3 <- renderInfoBox({
    infoBox(title = "Total", value = c13_glance()[[3,2]], icon = icon("plus-square"), color = "navy", fill = T)
  })
  
  output$c13_glance4 <- renderInfoBox({
    infoBox(title = "Emergency Admissions So Far", value = c13_glance()[[4,2]], icon = icon("ambulance"), color = "maroon", fill = T)
  })
  
  output$c13_glance5 <- renderInfoBox({
    infoBox(title = "Remaining Today", value = c13_glance()[[5,2]], icon = icon("clipboard"), color = "maroon", fill = T)
  })
  
  output$c13_glance6 <- renderInfoBox({
    infoBox(title = "Beds Available Now", value = c13_glance()[[6,2]], icon = icon("bed"), color = "navy", fill = T)
  })
  
  output$c13_glance7 <- renderInfoBox({
    infoBox(title = "Expected Discharges", value = c13_glance()[[7,2]], icon = icon("home"), color = "green", fill = T)
  })
  
  output$c13_glance8 <- renderInfoBox({
    infoBox(title = "Predicted Balance", value = c13_glance()[[8,2]], icon = icon("balance-scale"), color = "navy", fill = T)
  })
  
  c13_ed <- reactive({
    req(input$file2)
    
    covid13_ed <- read_excel(input$file2$datapath, sheet = 4, range = "I19:M19", col_names = F)
    
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
    
    return(covid13_ed)
  })
  
  
  
  output$c13_ed1 <- renderInfoBox({
    infoBox(title = "Total in ED", value = c13_ed()[[1,1]], icon = icon("hospital-user"), color = "blue")
  })
  
  output$c13_ed2 <- renderInfoBox({
    infoBox(title = "Longest Wait", value = c13_ed()[[1,2]], icon = icon("clock"), color = "yellow")
  })
  
  output$c13_ed3 <- renderInfoBox({
    infoBox(title = "Time to Assessment", value = c13_ed()[[1,3]], icon = icon("stopwatch"), color = "yellow")
  })
  
  output$c13_ed4 <- renderInfoBox({
    infoBox(title = "No. with DTA", value = c13_ed()[[1,4]], icon = icon("hospital"), color = colour_numbers(c13_ed()[[1,4]]), fill = T)
  })
  
  output$c13_ed5 <- renderInfoBox({
    infoBox(title = "Breaches since Midnight", value = c13_ed()[[1,5]], icon = icon("stopwatch"), color = colour_breaches(c13_ed()[[1,5]]), fill = T)
  })
  
  output$c13_seal <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 4, range = "E43", col_names = F)
    
    infoBox("SEAL Electives", value = val[[1,1]], color = "blue", icon = icon("clipboard-list"))
  })
  
  output$c13_trauma <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 4, range = "E45", col_names = F)
    
    infoBox("Trauma List", value = val[[1,1]], color = "blue", icon = icon("bone"))
  })
  
  
  c13_flow <- reactive({
    req(input$file2)
    
    columns_13 <- c("Ward", 
                    "Compliment",
                    "Empty",
                    "Electives",
                    "DC_Expected",
                    "DC_Achieved")
    
    covid13_flow <- read_excel(input$file2$datapath, sheet = 4, range = "B19:G42", col_names = F)
    
    colnames(covid13_flow) <- columns_13
    
    covid13_flow$Empty <- as.numeric(covid13_flow$Empty)
    
    covid13_flow[8, 1] <- "22 Red"
    covid13_flow[12, 1] <- "34 Red"
    
    redzones_13 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    covid13_flow <- covid13_flow %>%
      mutate("RedZone" = ifelse(Ward %in% redzones_13, T, F))
    
    return(covid13_flow)
  })
  
  output$c13_red_flow <- renderText({
    
    df <- c13_flow() 
    
    red.total <- c("Total",
                   sum(df[df$RedZone == T, 2], na.rm = T),
                   sum(df[df$RedZone == T, 3], na.rm = T),
                   sum(df[df$RedZone == T, 4], na.rm = T),
                   sum(df[df$RedZone == T, 5], na.rm = T),
                   sum(df[df$RedZone == T, 6], na.rm = T)
                   )
    
    red.df <- df %>%
      filter(RedZone == T) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
             ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    red.df <- rbind(red.df, red.total)
    
    kable(red.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(red.df), align = "center") %>%
      column_spec(1, bold = T, width = "8em") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(red.df), bold = T, color = "white", background = "#A32020")
  })
  
  
  output$c13_green_flow <- renderText({
    
    df <- c13_flow() 
    
    green.total <- c("Total",
                     sum(df[df$RedZone == F, 2], na.rm = T),
                     sum(df[df$RedZone == F, 3], na.rm = T),
                     sum(df[df$RedZone == F, 4], na.rm = T),
                     sum(df[df$RedZone == F, 5], na.rm = T),
                     sum(df[df$RedZone == F, 6], na.rm = T)
                     )
    
    green.df <- df %>%
      filter(RedZone == F) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
             ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    green.df <- rbind(green.df, green.total)
    
    kable(green.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(green.df), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(green.df), bold = T, color = "white", background = "#004C00")
    
  })
  
  c13_wac <- reactive({
    req(input$file2)
    
    covid13_wac <- read_excel(input$file2$datapath, sheet = 4, range = "B50:G60", col_names = F)
    
    colnames(covid13_wac) <- c("Ward", 
                                "Compliment",
                                "Empty",
                                "Electives",
                                "DC_Expected",
                                "DC_Achieved")
    
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
    
    return(covid13_wac)
  })
  
  
  output$c13_wac_flow <- renderText({
    wac.df <- c13_wac() 
    
    wac.df$Empty <- as.numeric(wac.df$Empty)
    
    total <- c("Total",
               sum(wac.df[ , 2], na.rm = T),
               sum(wac.df[ , 3], na.rm = T),
               sum(wac.df[ , 4], na.rm = T),
               sum(wac.df[ , 5], na.rm = T),
               sum(wac.df[ , 6], na.rm = T))
    
    wac.df <- wac.df %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = ifelse(Empty > 5, "#56b34b", "#c64040"))
             ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges by 1PM" = DC_Achieved)
    
    wac.df <- rbind(wac.df, total)
    
    kable(wac.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(wac.df), bold = T, color = "white", align = "center", background = "#292e34")
  })
  
  c13_cc <- reactive({
    req(input$file2)
    covid13_cc <- read_excel(input$file2$datapath, sheet = 4, range = "I26:N31", col_names = F)
    
    columns_cc <- c("Ward",
                    "Empty",
                    "Fit",
                    "Admissions",
                    "DC_Expected",
                    "Compliment")
    
    colnames(covid13_cc) <- columns_cc
    
    covid13_cc$Empty <- as.numeric(covid13_cc$Empty)
    
    covid13_cc[, 1] <- c("ICU Red",
                          "ICU Green",
                          "SHDU Green",
                          "MHDU Red",
                          "RHDU",
                          "CCU/MHDU Green")
    
    return(covid13_cc)
  })
  
  output$c13_cc_flow <- renderText({
    
    df.cc <- c13_cc() %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Ward Fit" = Fit,
             "Empty Beds" = Empty,
             "Admissions Today" = Admissions,
             "Discharges Expected" = DC_Expected)
    
    kable(df.cc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") 
  })
  
  
  c13_au1 <- reactive({
    req(input$file2)
    covid13_au1 <- read_excel(input$file2$datapath, sheet = 4, range = "I37:M37", col_names = F)
    
    return(covid13_au1)
  })
  
  output$c13_au11 <- renderInfoBox({
    df <- c13_au1()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c13_au12 <- renderInfoBox({
    df <- c13_au1()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c13_au13 <- renderInfoBox({
    df <- c13_au1()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c13_au14 <- renderInfoBox({
    df <- c13_au1()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c13_au15 <- renderInfoBox({
    df <- c13_au1()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  c13_au2 <- reactive({
    req(input$file2)
    covid13_au2 <- read_excel(input$file2$datapath, sheet = 4, range = "I44:M44", col_names = F)
    
    return(covid13_au2)
  })
  
  output$c13_au21 <- renderInfoBox({
    df <- c13_au2()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c13_au22 <- renderInfoBox({
    df <- c13_au2()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c13_au23 <- renderInfoBox({
    df <- c13_au2()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c13_au24 <- renderInfoBox({
    df <- c13_au2()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c13_au25 <- renderInfoBox({
    df <- c13_au2()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  output$c13_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 4, range = "I50:M53", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
  })
  
  
# COVID 17:00 ---------------------------------------------------------------
  
  
  
  c17_glance <- reactive({
    req(input$file2)
    
    covid17_sum <- read_excel(input$file2$datapath, sheet = 6, range = "B7:E14", col_names = F) %>%
      select(1, 4)
    
    return(covid17_sum)
  })  
  
  output$c17_glance1 <- renderInfoBox({
    infoBox(title = "Electives", value = c17_glance()[[1,2]], icon = icon("clipboard-list"), color = "blue", fill = T)
  })
  
  output$c17_glance2 <- renderInfoBox({
    infoBox(title = "Predicted Emergency Admissions", value = c17_glance()[[2,2]], icon = icon("hospital"), color = "yellow", fill = T)
  })
  
  output$c17_glance3 <- renderInfoBox({
    infoBox(title = "Total", value = c17_glance()[[3,2]], icon = icon("plus-square"), color = "navy", fill = T)
  })
  
  output$c17_glance4 <- renderInfoBox({
    infoBox(title = "Emergency Admissions So Far", value = c17_glance()[[4,2]], icon = icon("ambulance"), color = "maroon", fill = T)
  })
  
  output$c17_glance5 <- renderInfoBox({
    infoBox(title = "Remaining Today", value = c17_glance()[[5,2]], icon = icon("clipboard"), color = "maroon", fill = T)
  })
  
  output$c17_glance6 <- renderInfoBox({
    infoBox(title = "Beds Available Now", value = c17_glance()[[6,2]], icon = icon("bed"), color = "navy", fill = T)
  })
  
  output$c17_glance7 <- renderInfoBox({
    infoBox(title = "Expected Discharges", value = c17_glance()[[7,2]], icon = icon("home"), color = "green", fill = T)
  })
  
  output$c17_glance8 <- renderInfoBox({
    infoBox(title = "Predicted Balance", value = c17_glance()[[8,2]], icon = icon("balance-scale"), color = "navy", fill = T)
  })
  
  c17_ed <- reactive({
    req(input$file2)
    
    covid17_ed <- read_excel(input$file2$datapath, sheet = 6, range = "I19:M19", col_names = F)
    
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
    
    return(covid17_ed)
  })
  
  
  
  output$c17_ed1 <- renderInfoBox({
    infoBox(title = "Total in ED", value = c17_ed()[[1,1]], icon = icon("hospital-user"), color = "blue")
  })
  
  output$c17_ed2 <- renderInfoBox({
    infoBox(title = "Longest Wait", value = c17_ed()[[1,2]], icon = icon("clock"), color = "yellow")
  })
  
  output$c17_ed3 <- renderInfoBox({
    infoBox(title = "Time to Assessment", value = c17_ed()[[1,3]], icon = icon("stopwatch"), color = "yellow")
  })
  
  output$c17_ed4 <- renderInfoBox({
    infoBox(title = "No. with DTA", value = c17_ed()[[1,4]], icon = icon("hospital"), color = colour_numbers(c17_ed()[[1,4]]), fill = T)
  })
  
  output$c17_ed5 <- renderInfoBox({
    infoBox(title = "Breaches since Midnight", value = c17_ed()[[1,5]], icon = icon("stopwatch"), color = colour_breaches(c17_ed()[[1,5]]), fill = T)
  })
  
  output$c17_seal <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 6, range = "E43", col_names = F)
    
    infoBox("SEAL Electives", value = val[[1,1]], color = "blue", icon = icon("clipboard-list"))
  })
  
  output$c17_trauma <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 6, range = "E45", col_names = F)
    
    infoBox("Trauma List", value = val[[1,1]], color = "blue", icon = icon("bone"))
  })
  
  
  c17_flow <- reactive({
    req(input$file2)
    
    columns_17 <- c("Ward", 
                    "Compliment",
                    "Empty",
                    "Electives",
                    "DC_Expected",
                    "DC_Achieved")
    
    covid17_flow <- read_excel(input$file2$datapath, sheet = 6, range = "B19:G42", col_names = F)
    
    colnames(covid17_flow) <- columns_17
    
    covid17_flow$Empty <- as.numeric(covid17_flow$Empty)
    
    covid17_flow[8, 1] <- "22 Red"
    covid17_flow[12, 1] <- "34 Red"
    
    redzones_13 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    covid17_flow <- covid17_flow %>%
      mutate("RedZone" = ifelse(Ward %in% redzones_13, T, F))
    
    return(covid17_flow)
  })
  
  output$c17_red_flow <- renderText({
    
    df <- c17_flow() 
    
    red.total <- c("Total",
                   sum(df[df$RedZone == T, 2], na.rm = T),
                   sum(df[df$RedZone == T, 3], na.rm = T),
                   sum(df[df$RedZone == T, 4], na.rm = T),
                   sum(df[df$RedZone == T, 5], na.rm = T),
                   sum(df[df$RedZone == T, 6], na.rm = T)
    )
    
    red.df <- df %>%
      filter(RedZone == T) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    red.df <- rbind(red.df, red.total)
    
    kable(red.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(red.df), align = "center") %>%
      column_spec(1, bold = T, width = "8em") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(red.df), bold = T, color = "white", background = "#A32020")
  })
  
  
  output$c17_green_flow <- renderText({
    
    df <- c17_flow() 
    
    green.total <- c("Total",
                     sum(df[df$RedZone == F, 2], na.rm = T),
                     sum(df[df$RedZone == F, 3], na.rm = T),
                     sum(df[df$RedZone == F, 4], na.rm = T),
                     sum(df[df$RedZone == F, 5], na.rm = T),
                     sum(df[df$RedZone == F, 6], na.rm = T)
    )
    
    green.df <- df %>%
      filter(RedZone == F) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    green.df <- rbind(green.df, green.total)
    
    kable(green.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(green.df), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(green.df), bold = T, color = "white", background = "#004C00")
    
  })
  
  c17_wac <- reactive({
    req(input$file2)
    
    covid17_wac <- read_excel(input$file2$datapath, sheet = 6, range = "B50:G60", col_names = F)
    
    colnames(covid17_wac) <- c("Ward", 
                               "Compliment",
                               "Empty",
                               "Electives",
                               "DC_Expected",
                               "DC_Achieved")
    
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
    
    return(covid17_wac)
  })
  
  
  output$c17_wac_flow <- renderText({
    wac.df <- c17_wac() 
    
    wac.df$Empty <- as.numeric(wac.df$Empty)
    
    total <- c("Total",
               sum(wac.df[ , 2], na.rm = T),
               sum(wac.df[ , 3], na.rm = T),
               sum(wac.df[ , 4], na.rm = T),
               sum(wac.df[ , 5], na.rm = T),
               sum(wac.df[ , 6], na.rm = T))
    
    wac.df <- wac.df %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = ifelse(Empty > 5, "#56b34b", "#c64040"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges by 1PM" = DC_Achieved)
    
    wac.df <- rbind(wac.df, total)
    
    kable(wac.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(wac.df), bold = T, color = "white", align = "center", background = "#292e34")
  })
  
  c17_cc <- reactive({
    req(input$file2)
    covid17_cc <- read_excel(input$file2$datapath, sheet = 6, range = "I26:N31", col_names = F)
    
    columns_cc <- c("Ward",
                    "Empty",
                    "Fit",
                    "Admissions",
                    "DC_Expected",
                    "Compliment")
    
    colnames(covid17_cc) <- columns_cc
    
    covid17_cc$Empty <- as.numeric(covid17_cc$Empty)
    
    covid17_cc[, 1] <- c("ICU Red",
                         "ICU Green",
                         "SHDU Green",
                         "MHDU Red",
                         "RHDU",
                         "CCU/MHDU Green")
    
    return(covid17_cc)
  })
  
  output$c17_cc_flow <- renderText({
    
    df.cc <- c17_cc() %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Ward Fit" = Fit,
             "Empty Beds" = Empty,
             "Admissions Today" = Admissions,
             "Discharges Expected" = DC_Expected)
    
    kable(df.cc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") 
  })
  
  
  c17_au1 <- reactive({
    req(input$file2)
    covid17_au1 <- read_excel(input$file2$datapath, sheet = 6, range = "I37:M37", col_names = F)
    
    return(covid17_au1)
  })
  
  output$c17_au11 <- renderInfoBox({
    df <- c17_au1()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c17_au12 <- renderInfoBox({
    df <- c17_au1()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c17_au13 <- renderInfoBox({
    df <- c17_au1()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c17_au14 <- renderInfoBox({
    df <- c17_au1()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c17_au15 <- renderInfoBox({
    df <- c17_au1()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  c17_au2 <- reactive({
    req(input$file2)
    covid17_au2 <- read_excel(input$file2$datapath, sheet = 6, range = "I44:M44", col_names = F)
    
    return(covid17_au2)
  })
  
  output$c17_au21 <- renderInfoBox({
    df <- c17_au2()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c17_au22 <- renderInfoBox({
    df <- c17_au2()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c17_au23 <- renderInfoBox({
    df <- c17_au2()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c17_au24 <- renderInfoBox({
    df <- c17_au2()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c17_au25 <- renderInfoBox({
    df <- c17_au2()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  output$c17_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 6, range = "I50:M53", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
  })
  

# COVID 19:00 -------------------------------------------------------------

  
  c19_glance <- reactive({
    req(input$file2)
    
    covid19_sum <- read_excel(input$file2$datapath, sheet = 7, range = "B7:E14", col_names = F) %>%
      select(1, 4)
    
    return(covid19_sum)
  })  
  
  output$c19_glance1 <- renderInfoBox({
    infoBox(title = "Electives", value = c19_glance()[[1,2]], icon = icon("clipboard-list"), color = "blue", fill = T)
  })
  
  output$c19_glance2 <- renderInfoBox({
    infoBox(title = "Predicted Emergency Admissions", value = c19_glance()[[2,2]], icon = icon("hospital"), color = "yellow", fill = T)
  })
  
  output$c19_glance3 <- renderInfoBox({
    infoBox(title = "Total", value = c19_glance()[[3,2]], icon = icon("plus-square"), color = "navy", fill = T)
  })
  
  output$c19_glance4 <- renderInfoBox({
    infoBox(title = "Emergency Admissions So Far", value = c19_glance()[[4,2]], icon = icon("ambulance"), color = "maroon", fill = T)
  })
  
  output$c19_glance5 <- renderInfoBox({
    infoBox(title = "Remaining Today", value = c19_glance()[[5,2]], icon = icon("clipboard"), color = "maroon", fill = T)
  })
  
  output$c19_glance6 <- renderInfoBox({
    infoBox(title = "Beds Available Now", value = c19_glance()[[6,2]], icon = icon("bed"), color = "navy", fill = T)
  })
  
  output$c19_glance7 <- renderInfoBox({
    infoBox(title = "Expected Discharges", value = c19_glance()[[7,2]], icon = icon("home"), color = "green", fill = T)
  })
  
  output$c19_glance8 <- renderInfoBox({
    infoBox(title = "Predicted Balance", value = c19_glance()[[8,2]], icon = icon("balance-scale"), color = "navy", fill = T)
  })
  
  c19_ed <- reactive({
    req(input$file2)
    
    covid19_ed <- read_excel(input$file2$datapath, sheet = 7, range = "I19:M19", col_names = F)
    
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
    
    return(covid19_ed)
  })
  
  
  
  output$c19_ed1 <- renderInfoBox({
    infoBox(title = "Total in ED", value = c19_ed()[[1,1]], icon = icon("hospital-user"), color = "blue")
  })
  
  output$c19_ed2 <- renderInfoBox({
    infoBox(title = "Longest Wait", value = c19_ed()[[1,2]], icon = icon("clock"), color = "yellow")
  })
  
  output$c19_ed3 <- renderInfoBox({
    infoBox(title = "Time to Assessment", value = c19_ed()[[1,3]], icon = icon("stopwatch"), color = "yellow")
  })
  
  output$c19_ed4 <- renderInfoBox({
    infoBox(title = "No. with DTA", value = c19_ed()[[1,4]], icon = icon("hospital"), color = colour_numbers(c19_ed()[[1,4]]), fill = T)
  })
  
  output$c19_ed5 <- renderInfoBox({
    infoBox(title = "Breaches since Midnight", value = c19_ed()[[1,5]], icon = icon("stopwatch"), color = colour_breaches(c19_ed()[[1,5]]), fill = T)
  })
  
  output$c19_seal <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 7, range = "E43", col_names = F)
    
    infoBox("SEAL Electives", value = val[[1,1]], color = "blue", icon = icon("clipboard-list"))
  })
  
  output$c19_trauma <- renderInfoBox({
    req(input$file2)
    
    val <- read_excel(input$file2$datapath, sheet = 7, range = "E45", col_names = F)
    
    infoBox("Trauma List", value = val[[1,1]], color = "blue", icon = icon("bone"))
  })
  
  
  c19_flow <- reactive({
    req(input$file2)
    
    columns_19 <- c("Ward", 
                    "Compliment",
                    "Empty",
                    "Electives",
                    "DC_Expected",
                    "DC_Achieved")
    
    covid19_flow <- read_excel(input$file2$datapath, sheet = 7, range = "B19:G42", col_names = F)
    
    colnames(covid19_flow) <- columns_19
    
    covid19_flow$Empty <- as.numeric(covid19_flow$Empty)
    
    covid19_flow[8, 1] <- "22 Red"
    covid19_flow[12, 1] <- "34 Red"
    
    redzones_13 <- c("AU1", "22 Red", "34 Red", "41", "43", "51", "53")
    
    covid19_flow <- covid19_flow %>%
      mutate("RedZone" = ifelse(Ward %in% redzones_13, T, F))
    
    return(covid19_flow)
  })
  
  output$c19_red_flow <- renderText({
    
    df <- c19_flow() 
    
    red.total <- c("Total",
                   sum(df[df$RedZone == T, 2], na.rm = T),
                   sum(df[df$RedZone == T, 3], na.rm = T),
                   sum(df[df$RedZone == T, 4], na.rm = T),
                   sum(df[df$RedZone == T, 5], na.rm = T),
                   sum(df[df$RedZone == T, 6], na.rm = T)
    )
    
    red.df <- df %>%
      filter(RedZone == T) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    red.df <- rbind(red.df, red.total)
    
    kable(red.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(red.df), align = "center") %>%
      column_spec(1, bold = T, width = "8em") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(red.df), bold = T, color = "white", background = "#A32020")
  })
  
  
  output$c19_green_flow <- renderText({
    
    df <- c19_flow() 
    
    green.total <- c("Total",
                     sum(df[df$RedZone == F, 2], na.rm = T),
                     sum(df[df$RedZone == F, 3], na.rm = T),
                     sum(df[df$RedZone == F, 4], na.rm = T),
                     sum(df[df$RedZone == F, 5], na.rm = T),
                     sum(df[df$RedZone == F, 6], na.rm = T)
    )
    
    green.df <- df %>%
      filter(RedZone == F) %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = if_else(Empty > 5, "#56b34b", "#c64040", "#1b1c21"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges Achieved" = DC_Achieved)
    
    green.df <- rbind(green.df, green.total)
    
    kable(green.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:nrow(green.df), align = "center") %>%
      column_spec(1, bold = T) %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(green.df), bold = T, color = "white", background = "#004C00")
    
  })
  
  c19_wac <- reactive({
    req(input$file2)
    
    covid19_wac <- read_excel(input$file2$datapath, sheet = 7, range = "B50:G60", col_names = F)
    
    colnames(covid19_wac) <- c("Ward", 
                               "Compliment",
                               "Empty",
                               "Electives",
                               "DC_Expected",
                               "DC_Achieved")
    
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
    
    return(covid19_wac)
  })
  
  
  output$c19_wac_flow <- renderText({
    wac.df <- c19_wac() 
    
    wac.df$Empty <- as.numeric(wac.df$Empty)
    
    total <- c("Total",
               sum(wac.df[ , 2], na.rm = T),
               sum(wac.df[ , 3], na.rm = T),
               sum(wac.df[ , 4], na.rm = T),
               sum(wac.df[ , 5], na.rm = T),
               sum(wac.df[ , 6], na.rm = T))
    
    wac.df <- wac.df %>%
      mutate(Empty.col = cell_spec(Empty, bold = T, color = "white", background = ifelse(Empty > 5, "#56b34b", "#c64040"))
      ) %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Empty Beds" = Empty.col,
             "Elecives" = Electives,
             "Discharges Expected" = DC_Expected,
             "Discharges by 1PM" = DC_Achieved)
    
    wac.df <- rbind(wac.df, total)
    
    kable(wac.df, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1:3, 9, 11), align = "center", background = "#c64040") %>%
      row_spec(c(4:8, 10), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") %>%
      row_spec(nrow(wac.df), bold = T, color = "white", align = "center", background = "#292e34")
  })
  
  c19_cc <- reactive({
    req(input$file2)
    covid19_cc <- read_excel(input$file2$datapath, sheet = 7, range = "I26:N31", col_names = F)
    
    columns_cc <- c("Ward",
                    "Empty",
                    "Fit",
                    "Admissions",
                    "DC_Expected",
                    "Compliment")
    
    colnames(covid19_cc) <- columns_cc
    
    covid19_cc$Empty <- as.numeric(covid19_cc$Empty)
    
    covid19_cc[, 1] <- c("ICU Red",
                         "ICU Green",
                         "SHDU Green",
                         "MHDU Red",
                         "RHDU",
                         "CCU/MHDU Green")
    
    return(covid19_cc)
  })
  
  output$c19_cc_flow <- renderText({
    
    df.cc <- c19_cc() %>%
      select("Ward" = Ward,
             "Bed Compliment" = Compliment,
             "Ward Fit" = Fit,
             "Empty Beds" = Empty,
             "Admissions Today" = Admissions,
             "Discharges Expected" = DC_Expected)
    
    kable(df.cc, "html", escape = F) %>%
      kable_styling(full_width = T, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(c(1, 4), align = "center", background = "#c64040") %>%
      row_spec(c(2, 3, 5:6), align = "center", background = "#56b34b") %>%
      column_spec(1, bold = T, color = "white") %>%
      column_spec(c(2:6), background = "#edf5f9", color = "black") 
  })
  
  
  c19_au1 <- reactive({
    req(input$file2)
    covid19_au1 <- read_excel(input$file2$datapath, sheet = 7, range = "I37:M37", col_names = F)
    
    return(covid19_au1)
  })
  
  output$c19_au11 <- renderInfoBox({
    df <- c19_au1()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c19_au12 <- renderInfoBox({
    df <- c19_au1()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c19_au13 <- renderInfoBox({
    df <- c19_au1()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c19_au14 <- renderInfoBox({
    df <- c19_au1()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c19_au15 <- renderInfoBox({
    df <- c19_au1()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  c19_au2 <- reactive({
    req(input$file2)
    covid19_au2 <- read_excel(input$file2$datapath, sheet = 7, range = "I44:M44", col_names = F)
    
    return(covid19_au2)
  })
  
  output$c19_au21 <- renderInfoBox({
    df <- c19_au2()
    
    df <- filter(df, !is.na(...1)) %>%
      select(...1)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Patients Now", value = val, color = "blue", icon = icon("hospital-user"))
  })
  
  output$c19_au22 <- renderInfoBox({
    df <- c19_au2()
    
    df <- filter(df, !is.na(...2)) %>%
      select(...2)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "yellow")
    
    infoBox(title = "Bed Required", value = val, color = colour, icon = icon("bed"))
  })
  
  output$c19_au23 <- renderInfoBox({
    df <- c19_au2()
    
    df <- filter(df, !is.na(...3)) %>%
      select(...3)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Discharges", value = val, color = "green", icon = icon("home"))
  })
  
  output$c19_au24 <- renderInfoBox({
    df <- c19_au2()
    
    df <- filter(df, !is.na(...4)) %>%
      select(...4)
    
    val <- df[[1, 1]]
    
    infoBox(title = "Ongoing Assessment", value = val, color = "yellow", icon = icon("clipboard-check"))
  })
  
  output$c19_au25 <- renderInfoBox({
    df <- c19_au2()
    
    df <- filter(df, !is.na(...5)) %>%
      select(...5)
    
    val <- df[[1, 1]]
    
    colour <- ifelse(val == 0, "green", "red")
    
    infoBox(title = "To Come In", value = val, color = colour, icon = icon("ambulance"))
  })
  
  output$c19_add <- renderText({
    req(input$file2)
    
    add_nrc <- read_excel(input$file2$datapath, sheet = 7, range = "I50:M53", col_names = F)
    
    colnames(add_nrc) <- c("Ward", "Agreed1", "Agreed2", "Used1", "Used2")
    
    add_nrc <- add_nrc %>%
      select("Ward" = Ward,
             "Agreed Additional" = Agreed1,
             "Capacity" = Agreed2,
             "Additional Beds" = Used1,
             "in Used" = Used2)
    
    kable(add_nrc, "html") %>%
      kable_styling(full_width = F, position = "center", bootstrap_options = "condensed", font_size = 16) %>%
      row_spec(0, bold = T, align = "center", background = "#d8dfe4", color = "black") %>%
      row_spec(1:4, align = "center", background = "#d8dfe4") %>%
      column_spec(1, bold = T, color = "black") %>%
      column_spec(c(2:5), background = "#edf5f9", color = "black")
  })
  
  
  
  
  
}


shinyApp(ui, server)