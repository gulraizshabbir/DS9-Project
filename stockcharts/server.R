# server.R

library(quantmod)
library(scales)

shinyServer(function(input, output) {
      #---------------------------------------------------
      #     Reactive data functions
      #     Only run when underlying dataset changes
      #---------------------------------------------------
      dataInput <- reactive({
            getSymbols(input$symb, src = "yahoo",
                       from = input$dates[1],
                       to = input$dates[2],
                       auto.assign = F)
      })
      
      up <- reactive({
            nrow(dataInput()[dataInput()[,1] < dataInput()[,4],])
      })
      
      stats <- reactive ({
            dt <- data.frame(nrow(dataInput()))
            dt$up <- up()
            dt$down <- nrow(dataInput()) - up()
            dt$percent <- percent(up() / nrow(dataInput()))
            
            colnames(dt) <- c("Total Days", "Up Days", "Down Days", "Percent Up")
            dt
      })
      
      metrics <- reactive ({
            dat <- if (input$stats == 1) # Open-Close
                  dataInput()[,4] - dataInput()[,1]
            else
                  dataInput()[,2] - dataInput()[,3]
            
            df <- data.frame(round(mean(dat), 4))
            df$median <- round(median(dat), 4)
            df$min <- round(min(dat), 4)
            df$max <- round(max(dat), 4)
            df$sd <- round(sd(dat), 4)
            
            colnames(df) <- c("Mean", "Median", "Min", "Max", "Standard Deviation")
            
            df
      })
      

      #----------------------------------
      #     Modify output widgets
      #----------------------------------
      output$error <- renderText({
            if (input$ma > nrow(dataInput()))
                  "Moving Average will not appear if Day parameter is greater than total days in graph."
      })
      
      output$plot <- renderPlot({
            chartSeries(dataInput(),
                        theme = chartTheme("white"), 
                        type = "candle",
                        log.scale = F,
                        TA = NULL,
                        name = input$symb)
            
            if (input$ma <= nrow(dataInput()))
                  addSMA(n = input$ma, col = "blue")
      })
      
      output$table1 <- renderDataTable(
            stats(), options = list(paging = F, searching = F))

      output$table2 <- renderDataTable(
            metrics(), options = list(paging = F, searching = F))
      
#       output$mean <- renderText({
#             if (input$stats == 1) # Open-Close
#                   mean(dataInput()[,4] - dataInput()[,1])
#             else
#                   mean(dataInput()[,2] - dataInput()[,3])
#       })
#       
#       output$median <- renderText({
#             if (input$stats == 1) # Open-Close
#                   median(dataInput()[,4] - dataInput()[,1])
#             else
#                   median(dataInput()[,2] - dataInput()[,3])
#       })
#       
#       output$sd <- renderText({
#             if (input$stats == 1) # Open-Close
#                   sd(dataInput()[,4] - dataInput()[,1])
#             else
#                   sd(dataInput()[,2] - dataInput()[,3])
#       })
})


