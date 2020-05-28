fluidRow(
  box(title = "OVERVIEW", width = 12, collapsible = T,
      column(width = 4,
             box(title = "Emergency Care", width = 12, collapsible = T,
                 infoBoxOutput("ec1900_1", width = 12),
                 infoBoxOutput("ec1900_2", width = 12),
                 infoBoxOutput("ec1900_3", width = 12),
                 infoBoxOutput("ec1900_4", width = 12),
                 infoBoxOutput("ec1900_5", width = 12),
                 infoBoxOutput("ec1900_6", width = 12),
                 infoBoxOutput("ec1900_7", width = 12),
                 infoBoxOutput("ec1900_8", width = 12)
             )
      ), #/column
      column(width = 4,
             box(title = "Planned Care", width = 12, collapsible = T,
                 infoBoxOutput("pc1900_1", width = 12),
                 infoBoxOutput("pc1900_2", width = 12),
                 infoBoxOutput("pc1900_3", width = 12),
                 infoBoxOutput("pc1900_4", width = 12),
                 infoBoxOutput("pc1900_5", width = 12),
                 infoBoxOutput("pc1900_6", width = 12),
                 infoBoxOutput("pc1900_7", width = 12),
                 infoBoxOutput("pc1900_8", width = 12)
             )
      ), #/column
      column(width = 4,
             box(title = "Totals", width = 12, collapsible = T,
                 infoBoxOutput("tot1900_1", width = 12),
                 infoBoxOutput("tot1900_2", width = 12),
                 infoBoxOutput("tot1900_3", width = 12),
                 infoBoxOutput("tot1900_4", width = 12),
                 infoBoxOutput("tot1900_5", width = 12),
                 infoBoxOutput("tot1900_6", width = 12),
                 infoBoxOutput("tot1900_7", width = 12),
                 infoBoxOutput("tot1900_8", width = 12)
             )
      )
  ) #/ box - Summary
), #/fluidRow
fluidRow(
  box(title = "EMERGENCY DEPARTMENT", width = 8, collapsible = T,
      infoBoxOutput("ed1900_1", width = 4),
      infoBoxOutput("ed1900_2", width = 4),
      infoBoxOutput("ed1900_3", width = 4),
      infoBoxOutput("ed1900_4", width = 4),
      infoBoxOutput("ed1900_5", width = 4),
      infoBoxOutput("ed1900_6", width = 4),
      infoBoxOutput("ed1900_7", width = 4)
  ),
  
  box(title = "ASSESSMENT UNITS", width = 4, collapsible = T,
      box(title = "AU One", width = 12, collapsible = T,
          infoBoxOutput("au1_1900_1", width = 6),
          infoBoxOutput("au1_1900_2", width = 6),
          infoBoxOutput("au1_1900_3", width = 8),
          infoBoxOutput("au1_1900_4", width = 8)
      ),
      box(title = "AU Two", width = 12, collapsible = T,
          infoBoxOutput("au2_1900_1", width = 6),
          infoBoxOutput("au2_1900_2", width = 6),
          infoBoxOutput("au2_1900_3", width = 8),
          infoBoxOutput("au2_1900_4", width = 8)
      )
  ),
  
  box(title = "CRITICAL CARE", width = 8, collapsible = T,
      htmlOutput("cc1900")
  )
),
fluidRow(
  box(title = "FLOW", width = 12, collapsible = T,
      box(title = "Medicine", width = 12, collapsible = T,
          htmlOutput("med1900")),
      box(title = "Surgery and Trauma", width = 12, collapsible = T,
          htmlOutput("sx1900"),
          htmlOutput("ot1900")),
      box(title = "Additional Capacity", width = 5, collapsible = T,
          htmlOutput("add1900"))
  )
)
