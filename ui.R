#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

distributions<- c("exponential", "normal", "log normal", "uniform")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  # Application title
  titlePanel("Shiny App for Demonstrating Central Limit Theory"),
  
  # Sidebar with a slider input for number of simulations 
  sidebarLayout(
    sidebarPanel(
         helpText("Instructions:"),
         helpText("1. Select a number of Simulations to run via Sliding Bar."),
         helpText("2. Input a positive number for number of iterates per simulation."),
         helpText("3. Select an underlying distribution "),
         sliderInput("r", "Number of simulations to run:", min = 1, max = 4000, value = 2000),
         numericInput("n", "number of iterates of iid random variables in a simulation:", 300, min=1),
         selectInput('dist', 'Select the distribution to simulate', choices = distributions, selectize = FALSE)
    ),
    # Show the plot for distribution and CLT
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
