# project_timeseries
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
1. converts all time to fraction of the period in question; 
2. performs the cosine mathematical model and outputs the results in column ammended to the table
3. can be written as a loop to reiterate the process over however many parameters or sites the user selects.
4. execute the script using R-studio so that the built in statistical packages in R can compare
the model results to the data; and,
5. use ggplot to output the results to a graph(s) that represent the raw data, modeled data, and
statistical analysis.

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
for different types of analysis.

6. Questions for instructor (informal)
a) I'm thinking I need to use bash and R to achieve this but it may be possible to do it all in R?
What are your thoughts?
b) I know we haven't covered ggplot and that you are more partial to base R but I find ggplot's 
ability to combine multiple graphs useful for this sort of comparison. That being said I haven't
 worked in base-R plotting as much. Do you think I should plotting in both to see which
is more effective?
c) I'm sure I'll think of other questions as I progress. 

 
 

