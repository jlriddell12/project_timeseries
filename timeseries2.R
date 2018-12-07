#ONE SITE ONLY

#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")

#Read in data

HATCH <- read_xlsx("data/HATCH.xlsx")
sheets <- excel_sheets("data/HATCH.xlsx")
test <-setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Date_Time", "TempF", "TempC"))

#Write loop to read in each indvidual sheet, eliminate empty rows, and ouput each indvidual sheet.
  for(sheet_name in sheets){
    HATCH <- read_excel("data/HATCH.xlsx", sheet = sheet_name)[,1:3] #note that warnings will appear notifying user of gaps in data, the next line remedies that.
    data_comp <- HATCH[complete.cases(HATCH), ] 
    t1 <- as.POSIXct(strptime(data_comp$`Date-Time`, "%Y-%m-%d %H:%M:%S"))
    t2 <- julian(t1, origin = "2015-01-01 00:00:00")
    t3 <- t2/365.25
    time_calc <- as.numeric(t3)
    data_comp$time_calc <- time_calc
    temp <- lm(TempC ~ sin(2*pi*time_calc) + cos(2*pi*time_calc),data=data_comp)
    TempModel <- temp$fitted.values
    data_comp$TempModel <- TempModel
    test <- rbind(test, data_comp)
    assign(paste0("Hatch"), test)
  }
source("ggplot_function.R")
cosine_plot(Hatch)
 







#Notes explaining each step
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
