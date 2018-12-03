#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")


#Read in data
GMILL <- read_xlsx("GMILL.xlsx")

Date <- GMILL$`Date-Time`

Date <- as.numeric(Date)

Date <- as.integer(Date)

GMILL$'Date-Time' <- as. numeric(GMILL$'Date-Time')

#create vector of Date-Time and convert to numeric
Date_Time <- GMILL$'Date-Time'

Date_Time <- as.numeric(as.POSIXct(begin))

#Add converted date and time to data frame
GMILL$Date_Time_conv <- Date_Time_conv
  
#still ger erorr that date time is non binary...
GMILL_temp <- lm(TempC ~ sin(2*pi*"Date_Time_conv") + cos(2*pi*"Date_Time_conv"),data=GMILL)
TempModel <- GMILL_temp$fitted.values
GMILL$TempModel <- TempModel
