# Fitting a Cosine Model to Long Term Temperature Data

## Included 
- Project rationale and objectives
- Getting started and description of data
- Example code 
- Potential challenges and tips
- Future work

## Project rationale and objectives
Temperature data of springs is an integral parameter in understanding spring connection to surface inputs. However, long-term temperature collection results in large data sets that often have gaps and inconsistent time-stamps; because of this, traditional time-series evaluation of data cannot be completed unless data are synthesized to fill in gaps and evenly spaced data. Recently, researchers have begun to apply cosine models and fourier series to long-term temperature data as these models can predict values at a given time regardless of data spacing or gaps. The fourier series applies sine and cosine curves to the data to model oscillating patterns. Spring temperature data is expected to follow a sine or cosine type curve based on seasonal fluctuations of rainfall temperature - the similarities of the cosine model of spring temperature to the cosine model of rainfall temperature is indicative of the spring's connection to surface inputs.

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
1. To ensure each file or dataframe as an output, be sure to use the assign function.
1. When calling the cosing plotting function, use get() to allow the function to find the data frames and not just the list of data frames created at the end of the loop.

## Future Work
This project contains a future work folder that will eventually include several R Markdown files using different examples of this fourier series technique for data types collected over different timeframes (years, days, and months). Moving forward, the plots will be improved upon by adding the rainfall fourier series (to compare between springs and rainfall) as well as statistical analysis in their differences.



### Proposal
The collection of long-term temperature data in springs is a common yet
integral technique in understanding spring connection to surface inputs. However,
temperature collection often results in large data sets that are difficult to manage and
characterize. Traditional time-series analyses require no data-gaps and for data to be 
evenly spaced; when data-gaps are present the research is forced to synthesize data which
may result in misinterpreted relationships of springs to surface connection. Recently, 
researchers have begun to apply cosine models and fourier series to model cyclical 
data (daily, seasonally, and yearly) as long as the parameter in question
has consistent maximum and minimum values. Cosine and fourier series are more robust when it 
comes to missing data and data collected at uneven intervals as the model can still fit data
whether these conditions are met or not. The current techniques for cosine and fourier 
series modeling involve lengthy data manipulation and calculations (typically doen in Excel); 
followed by statistical analysis to compare the modeled outcome to the raw data. Finally, these
results must be represented in some form of graph or figure that requires even further manipulation.
Jill Riddell
October 26, 2018
ESDA

1. Introduction
The collection of long-term temperature data in springs is a common yet
integral technique in understanding spring connection to surface inputs. However,
temperature collection often results in large data sets that are difficult to manage and
characterize. Traditional time-series analyses require no data-gaps and for data to be 
evenly spaced; when data-gaps are present the research is forced to synthesize data which
may result in misinterpreted relationships of springs to surface connection. Recently, 
researchers have begun to apply cosine models and fourier series to model cyclical 
data (daily, seasonally, and yearly) as long as the parameter in question
has consistent maximum and minimum values. Cosine and fourier series are more robust when it 
comes to missing data and data collected at uneven intervals as the model can still fit data
whether these conditions are met or not. The current techniques for cosine and fourier 
series modeling involve lengthy data manipulation and calculations (typically doen in Excel); 
followed by statistical analysis to compare the modeled outcome to the raw data. Finally, these
results must be represented in some form of graph or figure that requires even further manipulation.

2. Objectives
When using a cosine model or fourier series to model changeds in a parameter over time, the time
must be represented as number that is a fraction of the period in question. For example, if the
equations are being used to model changes over a twenty-four period then each time must be a 
number as a fraction of 24 hours. The objective to this project is to write a bash script that:
1. Write a function(s) in R that will:
  * converts all time to fraction of the period in question (_I think this will be easier in R_)
  * performs the cosine mathematical model and outputs the results in column ammended to the table
  * can be written as a loop to reiterate the process over however many parameters or sites the user selects.
  * use ggplot to output the results to a graph(s) that represent the raw data, modeled data, and
statistical analysis.
2. Script could be executed from bash such that it can loop over files or sites or variables.

3. Data Source
This project will use temperature data collected from a series of springs in Monroe County West
Virginia from March 2015 through August 2018. Temperature data exists for approximately fourteen
springs that represent clastic, carbonate, and thermal signatures. For the course of this project
1-2 representative springs will be selected from each category. The temperature data has been
manipulated in Excel several times but the most basic and raw data forms will be used in this
project with manipulations occuring in bash and R. 

4. Implementation
This project will use a combination of UNIX shell bash script to create a loop to manipulate 
the data into the necessary format. Then these data will be read into R using the read xl package
and either the linear model (lm) or cosinor package to model the data. To graph the data, ggplot
will be used. Other usefulpackages may be discovered over the course of the project that may be
added or used instead of the ones listed here. Further, it may also be possible for R to recongnize
the date-time format as a number, in which case the manipulation in bash would not be necessary. 
However, it is this step will still likely be completed as it may be useful in future analyses.
Finally, the final code will added to github for other researchers to use to model temperature and
other cyclical data. This will aid in reproducibility of results and more comparison across study
sites tha has not been easily available previously.

5. Expected Outcomes
The outcomes of this project are to produce graphs that represent the raw temperature data, model
results, and statistical comparison (likely an f-test) of the model to the data. The ideal graphs
or plots will show the results of multiple springs in a watershed for easy comparison and discussion.
The bash script to maniuplate the date should be able to be easily changed for daily, monthly, or 
yearly analysis. Again, packages may exist in R to bypass this step, however, it could be useful 
for different types of analysis. _You might need to explain this bit to me.  Aggregate in R will allow you to aggregate easily at different time steps_

6. Questions for instructor (informal)
a) I'm thinking I need to use bash and R to achieve this but it may be possible to do it all in R?
What are your thoughts? _Start in R and see if there is a way to loop over files in bash_
b) I know we haven't covered ggplot and that you are more partial to base R but I find ggplot's 
ability to combine multiple graphs useful for this sort of comparison. That being said I haven't
 worked in base-R plotting as much. Do you think I should plotting in both to see which
is more effective? _Yes, feel free to use either.  Whichever works better for the types of plots you wnat to make.  Base R is more customizable, but ggplot can be faster for plotting lots of sites/stations/samples etc._
c) I'm sure I'll think of other questions as I progress. 

 
 

