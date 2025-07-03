# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# Librarys
library(shiny)
library(ggplot2)
library(tidyverse)
library(shinyWidgets)
library(shinycssloaders)
library(bslib)

# this part sets the theme for the ui
app_theme <- bs_theme(
  bg = "#A2B9A7",
  fg = "#657C6A",
  primary = "#BB3E00",
  base_font = font_google("Raleway")
)

# the ui part of the code organizes everything that is to be displayed. It contains static elements directly defined in the ui and placeholders for dynamic elements created in the server.
ui <- fluidPage( 
  theme = app_theme,
  titlePanel("Age distribution of German population"), # displays the title 
  tagList("Author: ", "Valentin Haury"),
  uiOutput("source"), # displays the output$source from the server
  
  selectInput(
    inputId = "sex", label = "Select population subset:", choices = c("total", "female", "male"), selected = "total"
  ), # dropdown menu to select the gender to be displayed
  
  sliderInput(
    "year", "Choose year:", min = 1950, max = 2021, value = 1985, step = 1, sep = ""
  ), # sliderInput so users can input a year (starting value is in the middle)
  
  tabsetPanel( # can hold differnet tabs
    tabPanel( # a single tab that holds a Histogramm in this case
      "Histogram",
      plotOutput("histogramPlot"), # displays the plot from output$histogramPlot created in the server
    ),
    tabPanel( # a single tab that holds the binned Histogramm 
      "Binned Histogram",
      sliderTextInput(
        "binSize", "Choose the size of age-groups:", choices = c(1:10, 20, 25, 33, 50, 100), selected = 1
      ), # sliderInput so users can input a year (starting value is in the middle)
      withSpinner(plotOutput("binnedHistogramPlot")), # displays the plot from output$binnedHistogramPlot created in the server (also displays waiting animation until its finnished because at my laptop it took a few seconsd every time)
    ),
    tabPanel( # this tab holds the information about the app (Manual and Observations)
      "Information",
      h3("Manual:"),
      p("This app shows the age-distribution for the german population in the years 1950-2021"),
      p("In the Histogram tab you see a graph representing the age-distribution in one year"),
      p("Select the total population or a specific gender from the dropdown menu to view a subset of the data"),
      p("Select a year on the slider to see visualisation of the data for that specific year"),
      p("In the Binned Histogram tab you can also choose the size of the age-groups to divide the data by"),
      
      h3("Observations:"),
      p("There is a huge peak around the people born in 1963/1964 where a lot of people were born because of the \"Wirtschaftswunder\"."),
      p("After that the birthrates decreased rapidly until 1972 and even further between 1990 and 2012."),
      p("There is a difference in the male and female population in the older generations because a lot of males that were 20 or older in 1945
        had to fight in at least one world war")
    ),
    tabPanel( # this tab holds the information about modifications 
      "Modifications",
      p("Moved the slider and dropdown menu out of the tab to also use them on the binned Histogramm"),
      p("Added a waiting animation while the binned histogram is created"),
      p("Changed the color of the \"histogram\" according to the height of the bars"),
      p("Added an ui-scheme with color and a font"),
    )
  )
)