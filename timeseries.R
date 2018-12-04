#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")


#Read in data
GMILL_2015 <- read_xlsx("data/GMILL.xlsx", sheet = "2015")[,1:3]
GMILL_2015 <- GMILL_2015[complete.cases(GMILL_2015), ]

GMILL_2016 <- read_xlsx("data/GMILL.xlsx", sheet = "2016")[,1:3]
GMILL_2016 <- GMILL_2016[complete.cases(GMILL_2016), ]

GMILL_2017 <- read_xlsx("data/GMILL.xlsx", sheet = "2017")[,1:3]
GMILL_2017 <- GMILL_2017[complete.cases(GMILL_2017), ]

GMILL_2018 <- read_xlsx("data/GMILL.xlsx", sheet = "2018")[,1:3]
GMILL_2018 <- GMILL_2018[complete.cases(GMILL_2018), ]

GMILL_both <- rbind(GMILL_2015, GMILL_2016)

sheets <- excel_sheets("GMILL.xlsx")

for (sheet_name in sheets){
  GMILL_sheet_name <- read_xlsx("GMILL.xlsx" , sheet = sheet_name)[,1:3]
  GMILL_sheet_name <- GMILL_sheet_name[complete.cases(GMILL_sheet_name), ]

}



Date <- GMILL$`Date-Time`

Date <- as.numeric(Date)

Date <- as.integer(Date)

GMILL$'Date-Time' <- as.numeric(GMILL$'Date-Time')

#create vector of Date-Time and convert to numeric
Date_Time <- GMILL$'Date-Time'

Date_Time <- as.numeric(as.POSIXct(begin))

#Add converted date and time to data frame
GMILL$Date_Time_conv <- Date_Time_conv
  
#still ger erorr that date time is non binary...
GMILL_temp <- lm(TempC ~ sin(2*pi*"Date_Time_conv") + cos(2*pi*"Date_Time_conv"),data=GMILL)
TempModel <- GMILL_temp$fitted.values
GMILL$TempModel <- TempModel
