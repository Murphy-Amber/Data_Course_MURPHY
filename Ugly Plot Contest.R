#Ugly Plot Contest
library(ggplot2)
library(tidyverse)
ARI = read.csv('Assignments/Assignment_4/nssp_ari_baseline_metric_map.csv') 
ARI %>%
  group_by('Location', 'Respiratory.Illness.level') %>%
  ggplot(aes(x = Location,
             y = Respiratory.Illness.Level,
             fill = Respiratory.Illness.Level,
             color = Location)) +
  labs(title ='Ugly', x = 'USA, USA, USA', y = 'The Plague, aka Respiratory.Illness.Level', color = 'Loco') +
  theme_linedraw() +
  theme(axis.title.x = element_text(hjust = 0.5, angle = 37, size = 17)) +
  theme(axis.title.y = element_text(vjust = 0.7, angle = 47, size = 2)) +
  theme(title = element_text(angle = 93, size = 20)) +
  theme(legend.text = element_text(vjust = 5, hjust = 2, angle = 180, size = 5)) +
  geom_bar(stat = 'identity', position = 'dodge')
