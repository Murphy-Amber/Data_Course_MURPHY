#Exam 2
dat = read.csv('unicef-u5mr.csv')
View(dat)
library(tidyverse)
library(ggplot2)

#Cleaning the data
clean_dat = dat %>%
  