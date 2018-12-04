#Begin by clearing the environment
rm(list=ls())

#Next load necessary packages. If these packages aren't already installed on your machine, do so using install.packages()
library("tidyverse")
library("readxl")
library("car")
library("ggplot2")

#Make a list of the data files
files <- list.files("./data")