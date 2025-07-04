# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# Librarys
library(shiny)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(dplyr)
library(stringr)
library(tidyr)

source("themes.R")

# this function loads the data from a given file-path. It then changes age_group- and year-variable to a factor for easier use later on. 
load_and_prepare_data <- function(path_to_file) { # the function is created
  pop_data <- read_csv(path_to_file) # reads the data
  
  pop_data <- pop_data %>%
    mutate(age_group = gsub("pop_", "", age_group),# removes substring pop_ from all entries in age_group
           age_group = gsub("_", "-", age_group),# changes substring "_" to "-" in all entries in age_group 
           age_group = factor(age_group, levels = unique(age_group[order(as.numeric(str_extract(age_group, "^[0-9]+")))]))) %>% # creates a factor with all unique age-groups as levels ordered by the age
    mutate(year = factor(year, levels = unique(year))) # makes year a factor, probably to be able to use it as a non continuous variable later
  
}


# the server part of the code contains logic for loading data, creating plots and reacting to dynamically creating/changing elements after receiving user inputs
server <- function(input, output, session) {
  
  pop_data <- load_and_prepare_data("data/pop_data_1950-2021.csv") # uses the function from above to load and prepare the population data
  url <- a("Federal Statistical Office of Germany", href="https://service.destatis.de/bevoelkerungspyramide/index.html#!") # defines and names an url for display
  output$source <- renderUI({ # outputs the url for display in the ui
    tagList("Data source:", url) # lists a title for the url and the above defined url
  })
  
  # Filter data for specific year
  pop_year <- reactive({
    pop_data %>% filter(year == input$year) # takes the sliderinput and filters the population data for that year
  })
  
  # Create a Count variable depending on the selected gender
  pop_gender <- reactive({
    pop_year() %>%  # nutze direkt pop_year()
      mutate(count = case_when(
        input$sex == "male" ~ male,
        input$sex == "female" ~ female,
        input$sex == "total" ~ total
      )) %>%
      mutate(count = ifelse(is.na(count), 0, count))
  })
  
  source("server/pyramidPlot.R", local = TRUE)
  # Render the pyramid plot
  output$popPyramidPlot <- renderPlot({
    create_pyramidPlot(
      data = pop_year(), 
      year = input$year,
      plot_colorscheme = plot_colorscheme)
  })
  
  source("server/histogram.R", local = TRUE)
  # Render the histogram plot
  output$histogramPlot <- renderPlot({
    create_histogram(
      data = pop_gender(),
      year = input$year,
      sex = input$sex,
      plot_colorscheme = plot_colorscheme
    )
  })
  
  source("server/binnedHistogram.R", local = TRUE)
  # Render the binned histogram plot
  output$binnedHistogramPlot <- renderPlot({
      create_binnedHistogram(
          data = pop_gender(),
          sex = input$sex,
          year = input$year,
          binSize = input$binSize,
          plot_colorscheme = plot_colorscheme)
  })
  
  source("server/contact_handler.R", local = TRUE) # loading the code that handels the contact form
  
}
  