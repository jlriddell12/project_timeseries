cosine_plot <- function(file){
  testplot <- print(ggplot(file, aes(x=file$'Date-Time', y=TempModel))+
                      geom_line(col="red",lwd=0.5)+
                      geom_point(aes(y=TempC), size=0.5)+
                      labs(x="Year", y="Temp C", title = paste("Temperature Model", plot_list, sep = " "))+
                      theme(plot.title = element_text(hjust = 0.5)))
  return(testplot)
}