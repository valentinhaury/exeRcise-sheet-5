# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# function to create the standard bar chart - histogram 
create_histogram <- function(data, year, sex, plot_colorscheme) {

  
  ggplot(data, aes(x = age_group, y = count)) +
    geom_bar(stat = "identity", fill = "#A2B9A7", color = "#BB3E00") +
    labs(
      title = paste(sex, "Population by Age Groups in", year), # adds the slider input to the title so the correct year appears
      x = "Age Groups",
      y = "population count in 1k inhabitants"
    ) +
    plot_colorscheme() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) # rotation and alignment of the x-achsis labels
}
