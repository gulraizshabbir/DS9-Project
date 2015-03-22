library(shiny)

shinyUI(fluidPage(
      titlePanel("Stock Charts"),
      
      sidebarLayout(
            sidebarPanel(
                  
                  textInput("symb", "Symbol", "SPY"),
                  
                  dateRangeInput("dates", 
                                 "Date range",
                                 start = "2014-9-01", 
                                 end = as.character(Sys.Date())),

                  h5("Select a stock and date range to view. Results will automatically update."),
                  br(),
                  
                  
                  radioButtons("stats",
                               label = "Intraday Range Type",
                               choices = list("Open to Close" = 1, "Low to High" = 2)),

                  h5("Calculate statistics on a stock's daily activity in one of two ways:"),
                  tags$ul(
                        tags$li("Open to Close will measure the general performance of the stock over the selected time period."),
                        tags$li("Low to High will measure the relative volatility in the stock. (A stock can have wild movements during the day while still closing very close to the open.) Low to High metrics will always exceed Open to Close.")
                  ),
                  h5("Changing the Intraday Range Type changes the calculations displayed in the Statistics table."),
                  br(),

                  
                  numericInput(inputId = "ma", label = "Moving Average - Days", value = 20),
                  h5("Modify the moving average appearing on the chart. Note: The day parameter for the moving average cannot exceed the total number of days in the chart.)"),
                  
                  textOutput("error"),
                  tags$head(tags$style("#error{color: red;
                                 font-size: 13px;
                                 font-style: italic;
                                 text-align: center;
                                 }"
                  )
                  )
            ),
            
            mainPanel(
                  plotOutput("plot"),
                  helpText("All stock data comes from Yahoo Finance."),
                  
                  h3("General Performance"),
                  dataTableOutput("table1"),
                  
                  h3("Statistics"),
                  dataTableOutput("table2")
                  
#                   h2("Average Daily Price Movement"),
#                   textOutput("mean"),
#                   h2("Median Daily Price Movement"),
#                   textOutput("median"),
#                   h2("Standard Deviation of Daily Price Movement"),
#                   textOutput("sd")
            )
      )
))