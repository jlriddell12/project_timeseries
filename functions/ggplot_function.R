cosine_plot <- function(file){
  testplot <- print(ggplot(file, aes(x=file$'Date-Time', y=TempModel))+ 
                      geom_line(col="red",lwd=0.5)+ 
                      geom_point(aes(y=TempC), size=0.5)+ 
                      labs(x="Year", y="Temp C")+ 
                      ggtitle("Temperature Model")+ 
                      theme(plot.title = element_text(hjust = 0.5))) 
   return(testplot) 
}
#GGplot does not run efficiently with commented lines. Above, the standard ggplot aesthetics were used to create an object called testplot and print this object according to the files in plot_list. This creates a graph with the x axis as date-time and the y axis as Temperature. It plots the raw data as points (geom_point) and the modeled data as a lione (geom_line). Next, it assingns axis labels, title, and centers the title.