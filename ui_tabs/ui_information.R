# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# this tab holds the information about the app (Manual and Observations)
tabPanel( 
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
)