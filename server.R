library(ggplot2)

sing_transport <- read.csv("Average-Daily-Public-Transport.csv")
sing_population <- read.csv("population.csv")
sing_transport <- sing_transport[order(sing_transport$type_of_public_transport),]

names(sing_transport) <- c("year", "type", "average")
sing_table <- aggregate(average ~ year, data=sing_transport, FUN=sum)
sing_table$average <- sing_table$average*1000 
sing_pop_transport <- merge(sing_table, sing_population, by="year")
sing_pop_transport$percentage <- sing_pop_transport$average/sing_pop_transport$total_population * 100

shinyServer <- function(input, output) {
    
    output$plot1 <- renderPlot({
        
        if(input$category==1)
            selected_data <- sing_transport
        else if(input$category==2)
            selected_data <- sing_transport[sing_transport$type==" Bus", ]
        else if(input$category==3)
            selected_data <- sing_transport[sing_transport$type=="LRT", ]
        else if(input$category==4)
            selected_data <- sing_transport[sing_transport$type=="MRT", ]
        else if(input$category==5)
            selected_data <- sing_transport[sing_transport$type=="Taxi", ]
        
        if(input$chart==1)
            ggplot(selected_data, aes(x=year, y=average, fill=type, group=type)) +geom_bar(stat="identity") + xlab("Year") + ylab("Average Daily Users in '000")  + labs(fill="Transport Type") + ggtitle("Average Daily Users of Public Transportion by Year in Singapore")
        
        else if(input$chart==2)
            ggplot(selected_data, aes(x=year, y=average, colour=type, group=type)) +geom_line() + xlab("Year") + ylab("Average Daily Users in '000") + ggtitle("Average Daily Users of Public Transportion by Year in Singapore")
        
    })
    
    
    output$table <- renderTable({
        sing_pop_transport
    })
}