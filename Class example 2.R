#Class Example 2
#Data cleaning
WIR = read.csv('Data/Wide_income_rent.csv')
str(WIR)
library(tidyverse)
library(ggplot2)

WIRT = t(WIR)
View(WIRT)
WIRT2 = WIRT[-1, ]
View(WIRT2)
WIRT2df = as.data.frame(WIRT2)
names(WIRT2df) = c('income', 'rent')
WIRT2df$state = rownames(WIRT2df)
View(WIRT2df)

WIRT2df %>%
  group_by(rent, income, state) %>%
  ggplot(aes(x = income,
             y = rent,
             color = state)) +
  geom_point()
  
#Pivot longer Pivot Wider
Wdf = WIRT2df %>%
  pivot_wider(names_from = 'income',
              values_from = 'rent')
View(Wdf)

#cleaning data
library(tidyverse)
Wdff = Wdf %>%
  pivot_longer(cols = c('state', '32940'),
               names_to = 'states',
               values_to = 'finances')
View(Wdff)

WIR1 = WIR %>%
  pivot_longer(-variable, names_to = 'state')
View(WIR1)

WIR2 = WIR1 %>%
  pivot_wider(names_from = 'variable',
              values_from = 'value')
View(WIR2)

table1
table2
table3

clean_table2 = table2 %>%
  pivot_wider(names_from = 'type' ,
              values_from ='count')
View(clean_table2)

clean_table2 %>%
ggplot(aes(x = cases,
           y = population,
           shape = country,
           color = year)) +
  geom_point()

clean_table3 = table3 %>%
  separate(rate, into = c('cases', 'population'))
View(clean_table3)

table4a
table4b

merge()
join_by()
full_join(x,y)

clean_table4a = table4a %>%
pivot_longer(cols = c('1999', '2000'),
  names_to = 'year', values_to = 'cases')
View(clean_table4a)

clean_table4b = table4b %>%
  pivot_longer(cols = c('1999', '2000'),
               names_to = 'year', values_to = 'population')
View(clean_table4b)

full_join(clean_table4a, clean_table4b)

table5
clean_table5 = table5 %>%
  separate(rate, into = c('cases', 'population')) %>%
  unite('year', century:year, remove = TRUE)
View(clean_table5)
#or you can do it this way
table5 %>%
  mutate(year = paste0(table5$century, table5$year, sep = ''))  %>%
  select(-century) %>%
  separate(rate, into = c('cases', 'population'))

#Real data cleaning
install.packages("readxl")
library(readxl)
read.csv('Assignments/Assignment_4/FluViewPhase2Data/ICL_NREVSS_Public_Health_Labs.csv', skip = 1)
range = 'A2:M420'

install.packages('janitor')
library(janitor)
