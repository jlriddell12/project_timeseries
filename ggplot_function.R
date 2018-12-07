cosine_plot <- function(file_name){
    testplot <-(ggplot(file_name, aes(x=file_name$'Date-Time', y=TempModel))+
    geom_line(col="red",lwd=0.5)+
    geom_point(aes(y=TempC), size=0.5)+
    ggtitle("Temperature Model")+
    labs(x="Year", y="Temp C")+
    theme(plot.title = element_text(hjust = 0.5)))+
  return(testplot)
}