#Assignment 4 ggplot
#Acute respiratory data across all states for the last week
library(ggplot2)
library(tidyverse)
#Must be in Rproject Data_Course_MURPHY for the next line of code to work
ARI = read.csv('Assignments/Assignment_4/nssp_ari_baseline_metric_map.csv') 
str(ARI)
names(ARI)

ARI %>%
  group_by('Location', 'Respiratory.Illness.level') %>%
  ggplot(aes(x = Location,
             y = Respiratory.Illness.Level,
             fill = Respiratory.Illness.Level,
             color = Location)) +
  geom_bar(stat = 'identity', position = 'dodge')
#I have gotten an ugly plot from this, good for the contest but this kind of data is not usable, I will try my other dataset

#Fluview data there are three datasets I could use from this, a clinical labs and a net, they are all giving me an error.
#This is due to the first row containing names / descriptor which throws off R, we will learn how to clean this later.
Fluv = read.csv('Assignments/Assignment_4/FluViewPhase2Data/ICL_NREVSS_Public_Health_Labs.csv', quote = "\"", row.names = 1)
read_lines(Fluv, n = 2) #error in argument 2
str(Fluv)
#the ggplot I would use would be either a bar plot, box plot, or scatter plot, depending on the data and how I wanted it arranged.