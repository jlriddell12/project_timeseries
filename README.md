# Fitting a Cosine Model to Long Term Temperature Data

## Included 
- Project rationale and objectives
- Getting started and description of data
- Example code 
- Potential challenges and tips
- Future work

## Project rationale and objectives
Temperature data of springs is an integral parameter in understanding spring connection to surface inputs. However, long-term temperature collection results in large data sets that often have gaps and inconsistent time-stamps; because of this, traditional time-series evaluation of data cannot be completed unless data are synthesized to fill in gaps and create evenly spaced data. Recently, researchers have begun to apply cosine models and fourier series to long-term temperature data as these models can predict values at a given time regardless of data spacing or gaps. The fourier series applies sine and cosine curves to the data to model oscillating patterns. Spring temperature data is expected to follow a sine or cosine type curve based on seasonal fluctuations of rainfall temperature - the similarities of the cosine model of spring temperature to the cosine model of rainfall temperature is indicative of the spring's connection to surface inputs.

The objective of the following code is to complete the first and most time consuming portion of the previously described technique: 
 1. Combine excel files that have multiple sheets of data for one spring into single data frames; for the data here, each sheet represents one year of data. The combination of the data into one sheet allows the model to evaluate all of the data together.
 1. Calculate a linear of model of temperature based on time using a fourier series and append a vector of predicted values to the dataframes.
 1. Write a plotting function using ggplot2 that will graph the collected temperature points and predicted values across a series of dataframes.

## Getting started and description of data
If using this code as an example, download the files in the data folder to the working directory that will be used or R project. Next, install the necessary packages (note: be sure that the most recent version of R is being used so that packages like tidyverse and ggplot2 will be compatible with R).

          install.packages("tidyverse")
          install.packages("readxl")
          install.packages("car") 
          install.packages("ggplot2")
          install.packages("dplyr")

The data in the data folder represents temperature data from three springs in Monroe County, WV (GMILL, HATCH, and OLSON) collected from late 2015 through early 2018.

### Example Code
 ```R 
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
    data_s <- read_excel(paste0("data/", file_name), sheet = sheet_name)[,1:3] #Read in data from each sheet for each file; note that warnings will appear notifying user of gaps in data, the next line remedies that
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


#Note that "34 warnings message", this is because there are gaps when reading in the inital sheets. This is remedied by line 26 in the loop, line 59 above.
```
### ggplot Function
```R
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
```

## Potential Challenges and Tips
1. When downloading data over a series of years from a datalogger, gaps may result in the downloaded data during the period of off-loading the logger. In these instances, it is necessary to use complete.cases in R to remove these rows. If these rows represent actual missing data and not just pauses in logging, it would be up to the researcher to decide if they need to be eliminated or otherwise evaluated. 
1. To ensure each file is generated as new data frame with the appended data and stored in the environment, be sure to use the assign function.
1. When calling the cosing plotting function, use get() to allow the function to find the data in the data frames and not just the list of data frames created at the end of the loop.

## Future Work
This project contains a future work folder that will eventually include several R Markdown files using different examples of this fourier series technique for data types collected over different time frames (years, days, and months). Moving forward, the plots will be improved upon by adding the rainfall fourier series (to compare between springs and rainfall) as well as statistical analysis in their differences.




 
 

