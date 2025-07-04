# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# this tab holds the binned histogram
tabPanel( 
  "Binned Histogram",
  sliderTextInput(
    "binSize", "Choose the size of age-groups:", choices = c(1:10, 20, 25, 33, 50, 100), selected = 1
  ), # sliderInput so users can input a year. Only years that create somehow good partitions of 100 are possible to select
  withSpinner(plotOutput("binnedHistogramPlot"), color = "#BB3E00"), # displays the plot from output$binnedHistogramPlot created in the server (also displays waiting animation until its finnished because at my laptop it took a few seconsd every time)
)