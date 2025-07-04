# Exercise Sheet 5
# Authors: Valentin Haury (12686340)

# Reaction to the contact input
observeEvent(input$goButton, {
  if (nzchar(input$message)) { # checks if message is empty 
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