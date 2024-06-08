library(shiny)
library(ggplot2)
library(DT)

# Memuat dataset yang telah dibersihkan sebelumnya
dataset <- read.csv("cleaned_dataset.csv")

# Membuat tampilan UI
ui <- fluidPage(
  titlePanel("Aplikasi Visualisasi Data Interaktif Tugas 3"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Pilih Variabel X:", choices = names(dataset)),
      selectInput("yvar", "Pilih Variabel Y:", choices = names(dataset)),
      radioButtons("plotType", "Pilih Jenis Plot:", choices = c("Scatter Plot", "Line Plot", "Bar Plot"))
    ),
    mainPanel(
      plotOutput("plot"),
      DTOutput("dataTable")
    )
  )
)

# Membuat logika server
server <- function(input, output, session) {
  selectedData <- reactive({
    dataset[, c(input$xvar, input$yvar)]
  })
  
  output$plot <- renderPlot({
    req(input$xvar, input$yvar)
    p <- ggplot(selectedData(), aes_string(x = input$xvar, y = input$yvar, group = 1, color=input$yvar, fill=input$yvar))
    if (input$plotType == "Scatter Plot") {
      p <- p + geom_point(size=6)
    } else if (input$plotType == "Line Plot") {
      p <- p + geom_line() + geom_point()
    } else if (input$plotType == "Bar Plot") {
      p <- p + geom_bar(stat = "identity")
    }
    p + theme_minimal()
  })
  
  output$dataTable <- renderDT({
    datatable(dataset)
  })
}

# Jalankan aplikasi shiny
shinyApp(ui = ui, server = server)