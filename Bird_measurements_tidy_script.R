bm = read.csv('Data/Bird_Measurements.csv')
View(bm)

install.packages('skimr')
library(skimr)
library(tidyverse)
bms = skim(bm)
print(bms)

bms6 = bms %>%
  filter(complete_rate > 0.6) %>% 
  pluck('skim_variable')
print(bms6)

bm2 = bm %>% 
  select(bms6)
View(bm2)

combine_mass = bm2 %>%
  select(M_mass, F_mass) %>%
  pivot_longer(cols = c('F_mass', 'M_mass'), names_to = 'mass_sex', values_to = 'mass')
  View(combine_mass)
  
  combine_wing = bm2 %>%
    select(M_wing, F_wing) %>%
    pivot_longer(cols = c('F_wing', 'M_wing'), names_to = 'wing_sex', values_to = 'wing_size')
  View(combine_wing)
  
  combine_wing_N = bm2 %>%
    select(M_wing_N, F_wing_N) %>%
    pivot_longer(cols = c('F_wing_N', 'M_wing_N'), names_to = 'wing_count_sex', values_to = 'wing_count')
  View(combine_wing_N)
  
  combine_tarsus = bm2 %>%
    select(M_tarsus, F_tarsus) %>%
    pivot_longer(cols = c('F_tarsus', 'M_tarsus'), names_to = 'tarsus_sex', values_to = 'tarsus_size')
  View(combine_tarsus)
  
  combine_tarsus = bm2 %>%
    select(M_tarsus, F_tarsus) %>%
    pivot_longer(cols = c('F_tarsus', 'M_tarsus'), names_to = 'tarsus_sex', values_to = 'tarsus_size')
  View(combine_tarsus)
  
  combine_bill = bm2 %>%
    select(M_bill, F_bill) %>%
    pivot_longer(cols = c('F_bill', 'M_bill'), names_to = 'bill_sex', values_to = 'bill_size')
  View(combine_bill)
  
  combine_bill_N = bm2 %>%
    select(M_bill_N, F_bill_N) %>%
    pivot_longer(cols = c('F_bill_N', 'M_bill_N'), names_to = 'bill_count_sex', values_to = 'bill_count')
  View(combine_bill_N)
  
  combine_tail = bm2 %>%
    select(M_tail, F_tail) %>%
    pivot_longer(cols = c('F_tail', 'M_tail'), names_to = 'tail_sex', values_to = 'tail_size')
  View(combine_tail)
  
  combine_tail_N = bm2 %>%
    select(M_tail_N, F_tail_N) %>%
    pivot_longer(cols = c('F_tail_N', 'M_tail_N'), names_to = 'tail_count_sex', values_to = 'tail_count')
  View(combine_tail_N)
  
  full_join = 
mutate(sex = paste())

# or it can be done this way
bm2_M = bm2 %>%
  select(-starts_with('F_')) %>%
  mutate(sex = 'male')
View(bm2_M)

bm2_F = bm2 %>%
  select(-starts_with('M_')) %>%
  mutate(sex = 'female')
View(bm2_F)

names(bm2_M) = names(bm2_M) %>% str_remove("M_")
names(bm2_F) = names(bm2_F) %>% str_remove('F_')
identical(names(bm2_F), names(bm2_M))
clean_bm =  full_join(bm2_M, bm2_F)
View(clean_bm)

#removing ugly portions and NA
clean_bm %>%
  ggplot(aes(x = mass,
             y = wing,
             color = tail,
             fill = tarsus,
             shape = sex)) +
geom_point()