# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# Librarys
library(shiny)
library(ggplot2)
library(tidyverse)

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
server <- function(input, output) {
  
  pop_data <- load_and_prepare_data("data/pop_data_1950-2021.csv") # uses the function from above to load and prepare the population data
  url <- a("Federal Statistical Office of Germany", href="https://service.destatis.de/bevoelkerungspyramide/index.html#!") # defines and names an url for display
  output$source <- renderUI({ # outputs the url for display in the ui
    tagList("Data source:", url) # lists a title for the url and the above defined url
  })
  
  
  
  # Filter data for specific year
  pop_year <- reactive({
    pop_data %>% filter(year == input$year) # takes the sliderinput and filters the population data for that year
  })
  
  
  # Render the histogram plot
  output$histogramPlot <- renderPlot({
    
    #select the gender specific data
    y_var <- switch(input$sex,
                    "male" = pop_year()$male,
                    "female" = pop_year()$female,
                    "total" = pop_year()$total) # selects the variable to use in the histogram based on the dropdown menu input
    
    ggplot(pop_year(), aes(x = age_group, y = y_var, fill = y_var)) +
      geom_bar(stat = "identity") +
      scale_fill_gradient(low = "#A2B9A7", high = "#BB3E00") +
      labs(
        title = paste("Population by Age Groups in", input$year), # adds the slider input to the title so the correct year appears
        x = "Age Groups",
        y = "population count in 1k inhabitants"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
            legend.position = "none") # rotation and alignment of the x-achsis labels
  })
  
  
  
  # Render the binned histogram plot
  output$binnedHistogramPlot <- renderPlot({
    
    # prepare the gender specific data and add rows according to numbers in variable for later use as numeric
    selected_pop <- switch(input$sex,
                           "male" = pop_data %>% mutate(male = ifelse(is.na(male), 0, male)) %>% uncount(male),
                           "female" = pop_data %>% mutate(female = ifelse(is.na(female), 0, female)) %>% uncount(female),
                           "total" = pop_data %>% mutate(total = ifelse(is.na(total), 0, total)) %>% uncount(total))
    
    #filter by year and add a numeric age variable
    selected_pop <- selected_pop %>%
      mutate(age = as.numeric(str_extract(age_group, "^[0-9]+"))) %>%
      filter(year == input$year)
    
    ggplot(selected_pop, aes(x = age)) +
      geom_histogram(binwidth = input$binSize, boundary = 0, fill = "#F7AD45", color = "black") + # bin size from input and boundary 0 so the age-groups stay inside possible range for ages (negative is not possible)
      labs(
        title = paste("Population by Age in", input$year),
        x = "Age-Groups",
        y = "Count in 1k inhabitants"
      ) +
      theme_minimal()
  })
  
  # Reaction to the contact input
  observeEvent(input$goButton, {
    if (nzchar(input$message)) {
      showModal(modalDialog(
        title = "Message received",
        paste0(
          "Hello ", ifelse(nzchar(input$name), input$name, "there"), ",\n", # checks if name is empty and adresses the user personally
          "Thank you for your message,\n",
          "the author of this page will respond as\n",
          "soon as he figures out how to make this contact-form \n",
          "actually work."
        ),
        easyClose = TRUE,
        footer = modalButton("Close")
      ))
    } else {
      showModal(modalDialog(
        title = "No Message received",
        paste0(
          "Hello ", ifelse(nzchar(input$name), input$name, "there"), ",\n", # checks if name is empty and adresses the user personally
          "Please enter a message to be forwarded to the author.")
      ))
    }
  })
  
}
  