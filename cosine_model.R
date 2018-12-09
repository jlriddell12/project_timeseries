#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")
library("dplyr")
source("ggplot_function.R")

#List all files and make a test data frame
files <- list.files("./data")

for (file_name in files){
  test <-setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Date_Time", "TempF", "TempC"))
  data_s <- read_excel(paste0("data/", file_name))[,1:3]
  sheets <- excel_sheets(paste0("data/", file_name))
  
  for (sheet_name in sheets){
    data_s <- read_excel(paste0("data/", file_name), sheet = sheet_name)[,1:3] #note that warnings will appear notifying user of gaps in data, the next line remedies that.
    data_comp <- data_s[complete.cases(data_s), ]
    t1 <- as.POSIXct(strptime(data_comp$`Date-Time`, "%Y-%m-%d %H:%M:%S"))
    t2 <- julian(t1, origin = "2015-01-01 00:00:00")
    t3 <- t2/365.25
    time_calc <- as.numeric(t3)
    data_comp$time_calc <- time_calc
    temp <- lm(TempC ~ sin(2*pi*time_calc) + cos(2*pi*time_calc),data=data_comp)
    #summary(temp)
    TempModel <- temp$fitted.values
    data_comp$TempModel <- TempModel
    test <- rbind(test, data_comp)
    assign(paste0(file_name,"2"), test)
    data_frame_list = (grep("\\w+\\.+\\w+2", ls(), value = TRUE))
  }
}
      for (file in data_frame_list){
      cosine_plot(get(file))
}



#Before moving forward, remove some unecessary stuff from the environment. These files were created in order to execute the loop but now they are unneeded.
rm(data_comp, data_raw, data_s, temp, test)


#source("ggplot_function.R")
#cosine_plot(file_name)

