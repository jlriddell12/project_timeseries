cosine_plot <- function(data_comp){
  testplot <- ggplot(data_comp, aes(x=data_comp$'Date-Time', y=TempModel))+
    geom_line(col="red",lwd=0.5)+
    geom_point(aes(y=TempC), size=0.5)+
    ggtitle(file_name, "Temperature Model")+
    theme(plot.title = element_text(hjust = 0.5))+
    labs(x="Year", y="Temp C")
  return(testplot)
}