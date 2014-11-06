library(shiny)
library(ggplot2)
library(gtable)

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
     

    dataInput <- reactive({
        param = ""
        if(input$uin != "") { 
            param <- paste(param," -u ", input$uin, sep="")   
        }
                
        if(input$rin != "") { 
          param <- paste(param, " -r ", input$rin, sep="")
        }

        print(input$time)

        syscommand <- paste(getwd(),"/Both -f ",input$nummut,":",input$base," -m e ", param, " -t ", input$time, " -N ", input$N, sep="" )

        print(syscommand)

        system(syscommand, wait=TRUE)

        return(read.csv("temp.txt", sep = "\t", header=T))
    })

    binInput <- reactive({

      return(read.csv("temp.bin", sep = "\t", header=F))  

    })



    #output$plot <- renderPlot({

    #graphDisplacement = ggplot(data, aes(Time, Displacement, col=Label)) + geom_line()
    #graphR = ggplot(data, aes(Time, R, col=Label)) + geom_line()
    #graphU = ggplot(data, aes(Time, U, col=Label)) + geom_line()
    #graphVelocity = ggplot(data, aes(Time, Velocity, col=Label)) + geom_line()
    #graphAcceleration = ggplot(data, aes(Time, Acceleration, col=Label)) + geom_line()
    #graphVariance = ggplot(data, aes(Time, Variance, col=Label)) + geom_line()
    #grphD = ggplotGrob(graphDisplacement)
    #grphR = ggplotGrob(graphR)
    #grphU = ggplotGrob(graphU)
    #grphVel = ggplotGrob(graphVelocity)
    #grphAccel = ggplotGrob(graphAcceleration)
    #grphVar = ggplotGrob(graphVariance)
    
    #a = gtable:::rbind_gtable(grphD, grphR, "first")
    #b = gtable:::rbind_gtable(a, grphU, "first")
    #d = gtable:::rbind_gtable(b, grphVel, "first")
    #e = gtable:::rbind_gtable(d, grphAccel, "first") 
    #f = gtable:::rbind_gtable(e, grphVar, "first")

    #grid.draw(f) 
    #})


    output$plotD <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$Displacement[b[1]])
        p<-ggplot(dataInput(), aes(Time, Displacement, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotR <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$R[b[1]])
        p<-ggplot(dataInput(), aes(Time, R, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotU <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$U[b[1]])
        p<-ggplot(dataInput(), aes(Time, U, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotV <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$Velocity[b[1]])
        p<-ggplot(dataInput(), aes(Time, Velocity, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotA <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$Acceleration[b[1]])
        p<-ggplot(dataInput(), aes(Time, Acceleration, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotVar <- renderPlot({
        b<-which(dataInput()$Time > input$timecur)
        sf<-data.frame(long=dataInput()$Time[b[1]],lat=dataInput()$Variance[b[1]])
        p<-ggplot(dataInput(), aes(Time, Variance, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)
    })
    output$plotN <- renderPlot({
        b<-which(binInput()$V1 > input$timecur)
        
        p<-ggplot(dataInput(), aes(Time, Variance, col=Label)) + geom_line() + geom_point(data=sf,aes(long,lat),colour="blue",size=4)
        print(p)  
    })
})