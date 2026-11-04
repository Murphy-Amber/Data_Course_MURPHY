#Assignment 6
library(tidyverse)
dat = read.csv('../../Data/Biolog_Plate_Data.csv')
View(dat)
#cleaning up the data, combining Hr
clean_dat = dat %>%
pivot_longer(cols = starts_with('Hr_'),
             names_to = 'Hours', values_to = 'Absorbance') %>%
  mutate(Hours = case_when(Hours == 'Hr_24' ~ '24',
                           Hours == 'Hr_48' ~ '48',
                           Hours == 'Hr_144' ~ '144'))
View(clean_dat)

#Creating a column for sample source
unique(clean_dat$Sample.ID)

Complete_dat = clean_dat %>%
  mutate(Sample_type = case_when(Sample.ID %in% c('Soil_1', 'Soil_2') ~ 'Soil',
                                 Sample.ID %in% c('Clear_Creek', 'Waste_Water') ~ 'Water'))
View(Complete_dat)

#Making a ggplot of the data not quite right
library(ggplot2)
Graph_dat = Complete_dat %>%
  mutate(Hours = as.numeric(as.character(Hours)))
View(Graph_dat)

Graph_dat %>%  
  filter(Dilution == 0.1) %>%
  group_by(Hours, Absorbance, Sample_type, Substrate) %>%
  summarise(avgAB = mean(Absorbance, na.rm = TRUE)) %>%
  ggplot(aes(x = Hours,
             y = avgAB,
             color = Sample_type)) +
  facet_wrap(~Substrate) +
  geom_smooth(method = loess, se = FALSE)
  scale_x_continuous(limits = c(0, 150), breaks = c(0, 50, 150)) +
  scale_y_continuous(limits = c(0.0, 2.0), breaks = c(0.0, 0.5, 1.0, 1.5, 2.0)) +
  labs(title = 'Just dilution 0.1', x = 'Time')

#Animated plot. Sorry I could not get it to exactly match,
#how did you handle the dips in the absorbance data, especially for the 0.001 dilution. 
#Geom_smooth I could not get to work. No matter what I tried the graph dips down.
library(gganimate)
Graph_dat %>%
  filter(Substrate == 'Itaconic Acid') %>%
  group_by(Substrate, Sample.ID, Hours, Absorbance, Dilution) %>%
  summarise(avgAB = mean(Absorbance, na.rm = TRUE)) %>%
  ggplot(aes(x = Hours,
             y = avgAB,
             color = Sample.ID,
             group = Sample.ID)) +
  facet_wrap(~Dilution) +
  labs(title = 'Hours{frame_time}', x = 'Time') +
  transition_reveal(Hours) +
  geom_path() +
  scale_x_continuous(limits = c(0, 150), breaks = c(50, 150)) +
  scale_y_continuous(limits = c(0.0, 2.5), breaks = c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5))
