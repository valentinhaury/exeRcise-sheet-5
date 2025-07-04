# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

#function to create a pyramid plot
create_pyramidPlot <- function(data, year, plot_colorscheme) {
  
  # selecting male and female data respectively
  male_data <- data %>%
    select(age_group, male) %>%
    mutate(male = -male) # make male data negative so the bars go to the left
  
  female_data <- data %>%
    select(age_group, female)
  
  # creating male plot
  p_male <- ggplot(male_data, aes(x = male, y = age_group)) +
    geom_bar(stat = "identity", fill = "#A2B9A7", color = "#657C6A") +
    scale_x_continuous(labels = abs) +
    labs(x = "Male Population", y = NULL) +
    plot_colorscheme() +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
  
  # creating female plot
  p_female <- ggplot(female_data, aes(x = female, y = age_group)) +
    geom_bar(stat = "identity", fill = "#A2B9A7", color = "#BB3E00") +
    labs(x = "Female Population", y = NULL) +
    plot_colorscheme() +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
  
  # arrange them next to each other
  grid.arrange(p_male, p_female, ncol = 2)
}