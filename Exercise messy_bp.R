library(readxl)
library(tidyverse)
df = read_xlsx('Data/messy_bp.xlsx', skip = 3)
View(df)
names(df)

bp_cleandf = df %>%
mutate(birthdate = paste(`Year birth`, `Month of birth`, `Day birth`)) %>%
  select(-`Month of birth`, -`Day birth`, -`Year birth`) %>%
  select(-HR...9, -HR...11, -HR...13) %>%
  pivot_longer(cols = starts_with('BP'),
               names_to = 'visit', values_to = 'BP') %>%
  mutate(visit = case_when(visit == 'BP...8' ~ '1',
                           visit == 'BP...10' ~ '2',
                           visit == 'BP...12' ~ '3')) %>%
  separate(BP, into = c('sys', 'dia')) 
View(bp_cleandf)

hr_cleandf = df %>%
  mutate(birthdate = paste(`Year birth`, `Month of birth`, `Day birth`)) %>%
  select(-`Month of birth`, -`Day birth`, -`Year birth`) %>%
  select(-BP...8, -BP...10, -BP...12) %>%
  pivot_longer(cols = starts_with('HR'),
               names_to = 'visits', values_to = 'HR') %>%
  mutate(visits = case_when(visits == 'HR...9' ~ '1',
                           visits == 'HR...11' ~ '2',
                           visits == 'HR...13' ~ '3'))
View(hr_cleandf)

full_cleandf = full_join(bp_cleandf, hr_cleandf)
View(full_cleandf)

full_cleandf  %>%
  mutate(Races = case_when(Race == 'Caucasion'| race == 'WHITE' ~ 'White',
                           TRUE ~ Race, ))
library(ggplot2)
full_cleandf %>%
  ggplot(aes(x = visit,
             y = hr,
             color = race)) +
  geom_point() +
  geom_smooth()


  