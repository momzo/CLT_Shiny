#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    n<-input$n
    r<-input$r
    rdist <- switch(input$dist,
                   "exponential" = rexp, 
                   "normal" = rnorm, 
                   "log normal" = rlnorm, 
                   "uniform" = runif)
    ddist <- switch(input$dist,
                    "exponential" = dexp, 
                    "normal" = dnorm, 
                    "log normal" = dlnorm, 
                    "uniform" = dunif)
    samples <- matrix(rdist(n*r),r)
    sim_means <- apply(samples,1,mean)
    sim_mu<-mean(sim_means)
    sim_sd<-sd(sim_means)
    
    par(mfrow=c(2,1))
    h1<-hist(samples[1,],freq=FALSE, main=paste("1st Simulation of ",as.character(r)), breaks = 50)
    xfit<-seq(min(samples),max(samples),length=500) 
    yfit<-ddist(xfit) 
    lines(xfit, yfit, col="blue", lwd=2)
    
    
    h2<-hist(sim_means, main=paste("Distribution of Means of samples, mu = ", format(sim_mu, digits = 5), ", sd = ", format(sim_sd,digits = 5)) , breaks = 50)
    xfit<-seq(min(sim_means),max(sim_means),length=500) 
    yfit<-dnorm(xfit,mean=sim_mu,sd=sim_sd) 
    yfit <- yfit*diff(h2$mids[1:2])*length(sim_means) 
    lines(xfit, yfit, col="blue", lwd=2)
  })
})
