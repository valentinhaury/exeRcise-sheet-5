# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# this tab shows the simple bar chart
tabPanel( 
  "Histogram",
  withSpinner(plotOutput("histogramPlot"), color = "#BB3E00") # displays the plot from output$histogramPlot created in the server
)