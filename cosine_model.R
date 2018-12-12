#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")
library("dplyr")

#Source the plotting function
source("functions/ggplot_function.R")

#Create a vector of files of interest
files <- list.files("./data")

#Loop to read in files and sheets
for (file_name in files){
  test <-setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Date_Time", "TempF", "TempC")) #creates an empty data frame that works as a template that can be filled in with data that will be read in 
  data_s <- read_excel(paste0("data/", file_name))[,1:3] #reads in first 3 columns of files. Note that temperature fahrenheit and temperature celsius are read in. The following analyses address celsius but users can adjust to use fahrenheit
  sheets <- excel_sheets(paste0("data/", file_name)) #Create a vector list of sheets for each file. Files consist of a series of sheets that represent a certain year of data.

#Loop to eliminate empty rows in sheets; adjust time to a number; use fourier series analysis; and ammend values to data frames  
  for (sheet_name in sheets){
    data_s <- read_excel(paste0("data/", file_name), sheet = sheet_name)[,1:3] #Read in data from each sheet for each file; note that warnings will appear notifying user of gaps in data, the next line remedies that.
    data_comp <- data_s[complete.cases(data_s), ] #Eliminates empty rows of data in each sheet
    t1 <- as.POSIXct(strptime(data_comp$`Date-Time`, "%Y-%m-%d %H:%M:%S")) #Convert Date-Time to an actual date using posix and indicating the format of the date time stamp
    t2 <- julian(t1, origin = "2015-01-01 00:00:00") #Convert Date-Time to a Julian date using the January 1, 2015 as the origin - this was the first year data were collected in this example
    t3 <- t2/365.25 #Convert Julian dates to a fraction of a year
    time_calc <- as.numeric(t3) #Create a vector of year fractions dates
    data_comp$time_calc <- time_calc #Add vector of year fraction dates to sheet data frames
    temp <- lm(TempC ~ sin(2*pi*time_calc) + cos(2*pi*time_calc),data=data_comp) #Use linear model function to estimate temperature based on the date-time yearly fraction using a fourier series
    TempModel <- temp$fitted.values #Create a vector of the estimated values
    data_comp$TempModel <- TempModel #Add the estimated values to the data frames. These are the modeled values based on time
    test <- rbind(test, data_comp) #Bind all the sheets of a file together with the newly calculated model data
    assign(paste0(file_name,"2"), test) #Assign the file name with a 2 to indicate files to which data have been added. Use assign to ensure there is output for each file
    plot_list <-  (grep("\\w+\\.+\\w+2", ls(), value = TRUE)) #Create a list of files that the function will call on to plot
  }
}
  
  #Loop that calls in the ggplot function to plot the raw data and modeled results for each file.
  
for (file in plot_list){
    cosine_plot(get(file)) #Calls in plot function, get ensures plots read from data frame
}


#Note that "34 warnings message", this is because there are gaps when reading in the inital sheets. This is remedied by line 26 in the loop.

