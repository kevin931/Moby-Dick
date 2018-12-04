#######

# This is the application file. Please do not modify.

#######

library(shiny)
library(tidyverse)
library(tidytext)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Moby-Dick, the Ditigal Portal"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     
     sidebarPanel(
       radioButtons("plot_select",
                    "Type of Plot",
                    c("QTF", "TF-IDF")),
       selectInput("chap_select",
                   "Choose the Chapter",
                   c(1:135))
       ), 
     
      mainPanel(
         plotOutput("tf_idf")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  
  moby_data<-read_csv("tf_idf.csv")
  
  output$a<-renderPrint("A work in progress. Stay Tuned.")
   
   output$tf_idf<- renderPlot({
     
     if (input$plot_select=="QTF") {
       
       moby_data %>% 
         anti_join(stop_words) %>%
         filter(chapter==as.character(input$chap_select)) %>%
         arrange(desc(tf_weighted)) %>%
         slice(1:10) %>%
         mutate(word=reorder(word, tf_weighted)) %>%
         ggplot(aes(x=word, y=tf_weighted, fill=tf_idf)) +
         geom_bar(stat="identity")+
         labs(title=paste("Chapter", input$chap_select, "QTF", sep=" "),
              subtitle="Statistics: QTF and TF-IDF",
              x="word",
              y="tf",
              fill="TF-IDF")+
         coord_flip()+
         ylim(0,0.039)+
         scale_fill_gradient(low="black", high="blue")
       
     } else {
       
       moby_data %>% 
         filter(chapter==as.character(input$chap_select)) %>%
         arrange(desc(tf_idf)) %>%
         slice(1:10) %>%
         mutate(word=reorder(word, tf_idf)) %>%
         ggplot(aes(x=word, y=tf_idf, fill=tf_weighted)) +
         geom_bar(stat="identity")+
         labs(title=paste("Chapter", input$chap_select, "TF-IDF", sep=" "),
              subtitle="Statistics: TF-IDF and Queequeg Term Frequency",
              x="word",
              y="tf-idf",
              fill="QTF")+
         coord_flip()+
         ylim(0,0.07)+
         scale_fill_gradient(low="black", high="red")
     }
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

