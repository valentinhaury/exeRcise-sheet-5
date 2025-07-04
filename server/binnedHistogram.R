# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# function to create the binned histogram
create_binnedHistogram <- function(data, sex, year, binSize, plot_colorscheme) {
  
  
  selected_pop <- data %>%
    mutate(age = as.numeric(str_extract(age_group, "^[0-9]+"))) %>% #numeric values for geom_histogram
    mutate(count = ifelse(is.na(count), 0, count)) # looking for empty values
  
  # creating histogram and using weight = count because we dont have to count entries we already have the values (this took me like 20 minutes to figure out)
  ggplot(selected_pop, aes(x = age, weight = count)) +
    geom_histogram(binwidth = binSize, boundary = 0, fill = "#A2B9A7", color = "#BB3E00") +
    labs(
      title = paste(sex, "Population by Age in", year),
      x = "Age Group",
      y = "Count in 1k inhabitants"
    ) +
    plot_colorscheme() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
}