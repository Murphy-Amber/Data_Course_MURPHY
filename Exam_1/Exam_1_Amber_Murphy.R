#Exam 1 Amber Murphy run through R project Exam_1
#Task 1 read file and data frame
df = read.csv('cleaned_covid_data.csv')
print(df)

#Task 2 subtype A states
library(tidyverse)
A_states = df %>%
filter(grepl('^A', Province_State, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE))
print(A_states)
#I could only use one column with grepl, the only column that had names was the Province_state column thus it fell to reason to use that column

#Task 3 plot of A_states deaths over time
library(ggplot2)
A_states %>%
  ggplot(aes(x = Last_Update,
             y = Deaths,)) +
  facet_wrap(~Province_State, scales = 'free') +
  geom_point() +
  geom_smooth(method = 'loess', se = FALSE) +
  labs(title = 'Deaths Over Time', x = 'Time', y = 'Deaths')

#Task 4 Peak fatalities
state_max_fatality_rate = df %>%
  drop_na(Case_Fatality_Ratio) %>%
  group_by(Province_State) %>%
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio)) %>%
  arrange(desc(Maximum_Fatality_Ratio))
print(state_max_fatality_rate)

#Task 5 Plot of state_max_fatality_rate 
#simple nonfactor way
state_max_fatality_rate %>%
  ggplot(aes(x  = reorder(Province_State, -Maximum_Fatality_Ratio),
             y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  theme(axis.text.x = element_text(angle = 90))

#I had a hard time figuring out the factor dplyr stuff, so I found a simpler way first, here is the messy factor way
library(dplyr)
state_max_fatality_rate_descending = state_max_fatality_rate %>%
  arrange(desc(Maximum_Fatality_Ratio)) %>%
  mutate(Province_State_descend = factor(Province_State, levels = Province_State))

  ggplot(state_max_fatality_rate_descending, aes(x  = Province_State_descend,
             y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  theme(axis.text.x = element_text(angle = 90))

#Bonus Task 6 Cumulative deaths for US over time
df %>%
  group_by(Last_Update) %>%
  summarise(cumulative_deaths = sum(Deaths)) %>%
  ggplot(aes(x = Last_Update,
             y = cumulative_deaths,)) +
  geom_point() +
  geom_smooth(method = 'loess', se = FALSE) +
  labs(title = 'Deaths Over Time Cumulative', x = 'Time', y = 'Deaths')
