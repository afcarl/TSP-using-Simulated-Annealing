library(shiny)

ui <- fluidPage(
  HTML("<h1 align='center'>Function Minimization using Simulated Annealing</h1>"),
  br(),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "temperature", label = "Starting Temperature", value = 1e5, min = 1, max = 1e5, step = 10),
      numericInput(inputId = "coolFactor", label = "Cooling Factor", value = 0.9, min = 0, max = 1, step = 0.01)
    ),
    mainPanel(
      plotOutput(outputId = "trainingPlot")
    )
  )
)
server <- function(input, output) {
  #t <- reactive(input$temperature)
  
  objFun <- function(x) {
    return (x^2 + 9 * x + 8)
  }
  
  genFun <- function(t) {
    return (rnorm(1, sd = abs(t)))
  }
  
  accptFun <- function(delE, t) {
    return(1/(1+exp(delE/t)))
  }
  
  x <- rnorm(1, sd = 10)
  t <- 100
  E <- objFun(x)
  iter <- 1
  Error <- c(E)
  delE <- 1000
  
  while(abs(delE) > 0.01){
    delx <- genFun(t)
    newX <- x + delx
    newE <- objFun(newX)
    
    rand <- runif(1, min = 0, max = 1)
    acpt <- accptFun(newE - E, t)
    
    if(rand <= acpt) {
      delE <- newE - E
      
      cat("Iteration: ", iter, "Temp: ", t, "\n")
      cat("X: ", x, "Del X: ", delx, ", New X: ", newX, "\n")
      cat("E: ", E, "Del E: ", delE, ", New E: ", newE, "\n")
      cat("\n\n")
      
      E <- newE
      x <- newX
      t <- t * 0.9
      iter <- iter + 1
      Error[iter] = E
      
    }
  }
  
  output$trainingPlot <- renderPlot({
    title <- "Objective Function vs Iterations"
    plot(1:iter, Error, xlab = "Iterations", ylab = "Objective Function", type = "l", main = title)
  })
}

shinyApp(ui = ui, server = server)

