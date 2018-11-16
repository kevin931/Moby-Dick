#######

# This is the application file. Please do not modify.

#######

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Moby-Dick, the Ditigal Portal"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     
     sidebarPanel(textOutput("a")), 
     
      mainPanel(
         textOutput("full_text")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  text<-read_lines("Moby_Dick_Full_Text.txt")
  
  output$a<-renderPrint("A work in progress. Stay Tuned.")
   
   output$full_text <- renderText({
      
     text
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

