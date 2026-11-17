#Assignment 7 Correct one for canvas assignment posting
dat = read.csv('Utah_Religions_by_County.csv')
View(dat)
library(tidyverse)
library(ggplot2)

#Cleaning up the data Not sure what needs cleaning
clean_dat = dat %>%
  pivot_longer(cols = c('Assemblies.of.God', 'Episcopal.Church', 'Pentecostal.Church.of.God', 'Greek..Orthodox', 'LDS', 'Southern.Baptist.Convention', 'United.Methodist.Church', 'Buddhism.Mahayana', 'Catholic', 'Evangelical', 'Muslim', 'Non.Denominational', 'Orthodox')
               )
#Making figures
dat %>%
  group_by(Pop_2010, Religious, County) %>%
  ggplot(aes(x = Religious, y = Pop_2010)) +
  facet_wrap(~County) +
  geom_point()
#Overall religious of a county does not seem to have an effect on the population rather certain counties are merely more populated than others

dat %>%
  group_by(Pop_2010, LDS, County) %>%
  ggplot(aes(x = LDS, y = Pop_2010)) +
  facet_wrap(~County) +
  geom_point()
#Likewise the proportion of LDS, the dominant religion does not seem to have an effect either

dat %>%
  group_by(Non.Religious, LDS, County) %>%
  ggplot(aes(x = LDS, y = Non.Religious)) +
  facet_wrap(~County) +
  geom_point()
#The proportion of LDS does seem to have a negative assosiation with the amount of non.religious people, the more LDS the less non.religious which makes sense

dat %>%
  group_by(Non.Religious, Catholic, County) %>%
  ggplot(aes(x = Catholic, y = Non.Religious)) +
  facet_wrap(~County) +
  geom_point()
#This trend is similar for the proportion of Catholics, but not quite as clear cut as with LDS proportions

dat %>%
  group_by(Non.Religious, Southern.Baptist.Convention, County) %>%
  ggplot(aes(x = Southern.Baptist.Convention, y = Non.Religious)) +
  facet_wrap(~County) +
  geom_point()
#The proportion of Southern Baptists does not seem to follow this same trend, but their proportions are smaller which could be skewing the data

dat %>%
  group_by(Non.Religious, Non.Denominational, County) %>%
  ggplot(aes(x = Non.Denominational, y = Non.Religious)) +
  facet_wrap(~County) +
  geom_point()
#Non.demonimational proportions only follow the pattern in certain counties, in some like Kane county, the inverse is true, the more non.denominational the more non.religious
