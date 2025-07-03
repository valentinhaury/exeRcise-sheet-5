# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# Librarys
library(shiny)
library(ggplot2)
library(tidyverse)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source("ui.R")
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)
