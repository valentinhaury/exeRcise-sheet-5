# Exercise Sheet 5 
# Authors: Valentin Haury (12686340)

# Librarys
library(shiny)
library(ggplot2)
library(tidyverse)
library(shinyWidgets)
library(shinycssloaders)
library(bslib)

# source for the ui-elements and colorscheme
source("themes.R")
histogram <- source("ui_tabs/ui_histogramm.R")$value
binnedHistogram <- source("ui_tabs/ui_binnedHistogramm.R")$value
information <- source("ui_tabs/ui_information.R")$value
contact <- source("ui_tabs/ui_contact.R")$value
modification <- source("ui_tabs/ui_modifications.R")$value
pyramid <- source("ui_tabs/ui_pyramidPlot.R")$value


# the ui part of the code organizes everything that is to be displayed. It contains static elements directly defined in the ui and placeholders for dynamic elements created in the server.
ui <- fluidPage( 
  theme = app_theme,
  titlePanel("Age distribution of German population"), # displays the title 
  tagList("Author: ", "Valentin Haury", tags$br()),
  uiOutput("source"), # displays the output$source from the server
  
  selectInput(
    inputId = "sex", label = "Select population subset:", choices = c("total", "female", "male"), selected = "total"
  ), # dropdown menu to select the gender to be displayed
  
  sliderInput(
    "year", "Choose year:", min = 1950, max = 2021, value = 1985, step = 1, sep = ""
  ), # sliderInput so users can input a year (starting value is in the middle)
  
  tabsetPanel( # can hold differnet tabs
    histogram,
    binnedHistogram,
    pyramid,
    information,
    contact,
    modification
  )
)