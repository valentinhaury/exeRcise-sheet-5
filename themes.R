# Exercise Sheet 5
# Authors: Valentin Haury (12686340)
library(ggplot2)
library(showtext)

font_add_google("Raleway", "raleway")

# this part sets the theme for the ui
app_theme <- bs_theme(
  bg = "#A2B9A7",
  fg = "#657C6A",
  primary = "#BB3E00",
  base_font = font_google("Raleway")
)

showtext_auto()
# this part sets the theme for the graphs
plot_colorscheme <- function() {
    theme_minimal(base_family = "raleway") +
      theme(
        panel.background = element_rect(fill = "#A2B9A7", color = NA),
        plot.background = element_rect(fill = "#A2B9A7", color = NA),
        panel.grid.major = element_line(color = "#657C6A", size = 0.2),
        panel.grid.minor = element_blank(),
        
        axis.text = element_text(color = "#657C6A", size = 12),
        axis.title = element_text(color = "#657C6A", size = 14),
        plot.title = element_text(color = "#BB3E00", size = 18, face = "bold"),
        
        legend.background = element_rect(fill = "#A2B9A7", color = NA),
        legend.key = element_rect(fill = "#A2B9A7"),
        legend.title = element_text(color = "#657C6A"),
        legend.text = element_text(color = "#657C6A")
      )
}