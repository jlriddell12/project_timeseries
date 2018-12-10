# Fitting a Cosine Model to Long Term Temperature Data

## Included 
- Project rationale and objectives
- Explanation of cosine model
- Getting started and description of data
- Example code 
- Potential challenges and tips
- Future work

## Project rationale and objectives
Temperature data of springs is an integral parameter in understanding spring connection to surface inputs. However, long-term temperature collection results in large data sets that often have gaps and inconsistent time-stamps; because of this, traditional time-series evaluation of data cannot be completed unless data are synthesized to fill in gaps and create evenly spaced data. Recently, researchers have begun to apply cosine models and fourier series to long-term temperature data as these models can predict values at a given time regardless of data spacing or gaps. Spring temperature data is expected to follow a sine or cosine type curve based on seasonal fluctuations of rainfall temperature - the similarities of the cosine model of spring temperature to the cosine model of rainfall temperature is indicative of the spring's connection to surface inputs.

The objective of the following code is to complete the first and most time consuming portion of the previously described technique: 
 *Combine excel files that have multiple sheets of data for one spring into single data frames; for the data here, each sheet represents one year of data. The combination of the data into one sheet allows the model to evaluate all of the data together.
 *Calculate a linear of model of temperature based on time using a fourier series and append a vector of predicted values to the dataframes.
 *Write a plotting function using ggplot2 that will graph the colleted temperature points and predicted values across a series of dataframes.

## Explanation of cosine model

## Getting started and description of data
If using this code as an example, download the files in the data folder to the working directory that will be used or R project. Next, install the necessary packages (note: be sure that the most recent version of R is being used so that packages like tidyverse and ggplot2 will be compatible with R).

          install.packages("tidyverse")
          install.packages("readxl")
          install.packages("car") 
          install.packages("ggplot2")
          install.packages("dplyr")

 
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

 
 

