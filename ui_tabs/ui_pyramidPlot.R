# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# tab that shows the population pyramid
tabPanel("Population Pyramid",
         withSpinner(plotOutput("popPyramidPlot"), color = "#BB3E00")
)