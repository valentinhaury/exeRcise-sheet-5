# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# this tab is for contacting the apps author
tabPanel( 
  "Contact",
  h3("Contact form"),
  textInput("name", "Your Name:"),
  textAreaInput("message", "Write us a message:", rows = 3),
  actionButton("goButton", "send"),
  hr(),
  
  h3("Github"),
  p("If you are interested in this project have a look at the ",
    tags$a(href = "https://github.com/valentinhaury/exeRcise-sheet-5", 
           "GitHub repository", 
           target = "_blank")
  )
)