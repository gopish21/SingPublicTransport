library(shiny)




shinyUI <- fluidPage(
    
    headerPanel("Singapore Transportation Data"),
    sidebarLayout(
        sidebarPanel(
            selectInput("category", label="Select Transport Type", choices=list("All"=1, "Bus"=2, "LRT"=3, "MRT"=4, "Taxi"=5), selected=1),
            radioButtons("chart", label="Select Chart Type", choices=list("Bar"=1, "Line"=2), selected=1)
            
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", plotOutput("plot1")),
                tabPanel("Table","Daily Singapore Public Transportation usage vs Total Population by Year", tableOutput("table")),
                tabPanel("Description", 
                         h2("Singapore Public Transportation Analysis"),
                         hr(),
                         p("Following are the steps on using this application:"),
                         p("a) Select type of transportation to view (All, Bus, LRT, MRT or Taxi."),
                         p("b) Select chart type to view."),
                         p("Information related to to the transportation type is processed and display in the Plot tab.Data for the selected choices is processed using the reactive function in R shiny and displayed in the plot tab."),
                         p("The Table tab shows the total number of public transport usage, the population and the percentage of public transport in Singapore."),
                         hr(),
                         p("Data source: Singapore open data portal.")
                         
                )
               
                
                
            )
        )
    )
)
