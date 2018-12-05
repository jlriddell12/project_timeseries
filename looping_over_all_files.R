#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")

#Make a list of the data files
files <- list.files("./data")

#Loop to apply bind all sheets together, adjust date and time into a numeric format, and execute Fourier series across all files.

for (file_name in files){
  data_s <- read_excel(paste0("data/", file_name))
  sheets <- excel_sheets(paste0("data/", file_name))
  
  for(sheet_name in sheets){
    data_raw <- read_excel(paste0("data/", file_name), sheet = sheet_name)[,1:3] #note that warnings will appear notifying user of gaps in data, the next line remedies that.
    data_comp <- data_raw[complete.cases(data_raw), ]                                                                                                 
    assign(paste0(file_name, sheet_name), data_comp)
    all_data <- rbind(file_name, sheet_name)
    assign(paste0(file_name), all_data)
  }
}

GMILL <- rbind(GMILL.xlsx2015, GMILL.xlsx2016, GMILL.xlsx2017, GMILL.xlsx2018)
HANCK <- rbind(HANCK.xlsx2015, HANCK.xlsx2016, HANCK.xlsx2017, HANCK.xlsx2018)
HATCH <- rbind(HATCH.xlsx2015, HATCH.xlsx2016, HATCH.xlsx2017)
OLSON <- rbind(OLSON.xlsx2015, OLSON.xlsx2016, OLSON.xlsx2017, OLSON.xlsx2018)

sites <-ls(GMILL, HANCK, OLSON, HATH)


x <- grep("G\\w+\\.", ls(), value=TRUE)

for (file in x) {
  GMILL <- rbind.data.frame(get(file)) 
  assign(paste0("GMILL"), GMILL) 
  }


#files grep("\\w", ls(), value = TRUE)

