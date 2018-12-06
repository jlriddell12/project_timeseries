#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")

#Read in data. Eventually this will be a loop for 4 files in a data folder.

GMILL <- read_xlsx("data/GMILL.xlsx")
sheets <- excel_sheets("data/GMILL.xlsx")

#What I want my first loop to do for each year, that is 2015, 2016, 2017, 2018
#GMILL <- read_xlsx("data/GMILL.xlsx")[,1:3]
#GMILL_2015 <- GMILL[complete.cases(GMILL), ]

#Write loop to read in each indvidual sheet, eliminate empty rows, and ouput each indvidual sheet.
  for(sheet_name in sheets){
    GMILL <- read_excel("data/GMILL.xlsx", sheet = sheet_name)[,1:3] #note that warnings will appear notifying user of gaps in data, the next line remedies that.
    GMILL_sheet_name <- GMILL[complete.cases(GMILL), ]                                                                                                 
    assign(paste0("S", sheet_name), GMILL_sheet_name)
  }
 
#Bind each sheet together
GMILL <- rbind(S2015, S2016, S2017, S2018)

#Convert 'Date-Time' column to a fraction of year if 0 years = Jan 1, 2015.
t1 <- as.POSIXct(strptime(GMILL$`Date-Time`, "%Y-%m-%d %H:%M:%S"))
t2 <- julian(t1, origin = "2015-01-01 00:00:00")
t3 <- t2/326.25

#Convert time to a numeric vector so calculations can be performed and add vector ro the data frame.
time_calc <- as.numeric(t3)
GMILL$time_calc <- time_calc

#Calculate the linear model of temperature based on time using a fourier series and add the modeled output to the data frame.
GMILL_temp <- lm(TempC ~ sin(2*pi*time_calc) + cos(2*pi*time_calc),data=GMILL)
TempModel <- GMILL_temp$fitted.values
GMILL$TempModel <- TempModel

#Calculate summary statistics
summary(GMILL_temp)

#Plot results
#plot(GMILL$`Date-Time`,GMILL$TempC, cex =.25, main = "Cosine Model of Temperature at Gap Mills", ylab = "Temp, C", xlab = "Year")

#Plot results 2
  ggplot(GMILL, aes(x=GMILL$'Date-Time', y=TempModel))+
  geom_line(col="red",lwd=0.5)+
  geom_point(aes(y=TempC), size=0.5)+
  ggtitle("Gap Mills Temperature Model")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="Year", y="Temp C")
