#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")

#Make a list of the data files
files <- list.files("./data")

#Loop to bind all sheets together.

for (file_name in files){
  data_s <- read_excel(paste0("data/", file_name))
  sheets <- excel_sheets(paste0("data/", file_name))
  
  for(sheet_name in sheets){
    data_raw <- read_excel(paste0("data/", file_name), sheet = sheet_name)[,1:3] #note that warnings will appear notifying user of gaps in data, the next line remedies that.
    data_comp <- data_raw[complete.cases(data_raw), ]                                                                                                 
    assign(paste0(file_name, sheet_name), data_comp)
    #all_data <- rbind(file_name)
    #assign(paste0(file_name), all_data)
  }
}

#GMILL <- rbind(GMILL.xlsx2015, GMILL.xlsx2016, GMILL.xlsx2017, GMILL.xlsx2018)
#HANCK <- rbind(HANCK.xlsx2015, HANCK.xlsx2016, HANCK.xlsx2017, HANCK.xlsx2018)
#HATCH <- rbind(HATCH.xlsx2015, HATCH.xlsx2016, HATCH.xlsx2017)
#OLSON <- rbind(OLSON.xlsx2015, OLSON.xlsx2016, OLSON.xlsx2017, OLSON.xlsx2018)

#sites <-ls(GMILL, HANCK, OLSON, HATH)


#x <- grep("G\\w+\\.", ls(), value=TRUE)

for (file in x) {
  GMILL <- rbind(get(file)) 
  assign(paste0("GMILL", file), GMILL) 
  }
#files grep("\\w", ls(), value = TRUE)

#Create empty dataframe, read in data, bind to test dataframe. WORKS!
test <-setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Date_Time", "TempF", "TempC"))
GMILL <- read_xlsx("data/GMILL.xlsx")[,1:3]
sheets <- excel_sheets("data/GMILL.xlsx")
all <- rbind(test, GMILL)

#Now try for all sheets at one site. WORKS! Now try for all files!
for(sheet_name in sheets){
  GMILL <- read_excel("data/GMILL.xlsx", sheet = sheet_name)[,1:3] 
  data_comp <- GMILL[complete.cases(GMILL), ] 
  #assign(paste0("GMILL", sheet_name), GMILL)
  test <- rbind (test, GMILL)
}

