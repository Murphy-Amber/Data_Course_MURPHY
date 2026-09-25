mtcars
data()
df_car = mtcars
print(df_car)
nrow(df_car)
ncol(df_car)
str(df_car)
dim(df_car)
names(df_car)

ma = max(df_car$mpg)
mi = min(df_car$mpg)
me = mean(df_car$mpg)
vec = c(ma, mi, me)
name(car) = c('dazzle', 'vroom')

df_car[df_car$mpg >20, ]
good_car = df_car[df_car$mpg >20 & df_car$cyl == 4,]

mean(df_car$mpg)
df_car[1, 1]
df_mpg_20 = df_car[df_car$mpg > mean(df_car$mpg),]
View(df_mpg_20)

df_car[,-1]
dim(df_car[,-c(1, 3, 5)])
sort()

names(mtcars)
df_new = df_car[df_car$mpg >20 & df_car$cyl == 4,]
df_newcar = df_new[,  -c(4, 6)]
names(df_newcar)
dim(df_newcar)
print(df_newcar)

install.packages('qrcode')
library(qrcode)
url = 'https://gzahn.github.io/data-course/' 
qr = qr_code(url)
plot(qr)

install.packages('tidyverse')
library(tidyverse)

filter()
stats::filter()

#%>% pipe
df_car %>%
  names()
df_car$mpg %>%
  mean()
df_car$mpg %>%
  median()
df_car$mpg %>%
  min()
df_car$mpg %>%
  max()

df_best = df_car[df_car$mpg >22, df_car$cyl != 4, df_car$wt <3, df_car$hp >90,]

df_best = df_car %>%
  filter(mpg > 22, cyl == 4, wt < 3, hp > 90) %>%
  select(-mpg, -cyl)

df_best %>%
  pluck('mpg') %>%
  mean()

df_car %>%
  filter(cyl != 4) %>%
  pluck ('mpg') %>%
  mean()

getwd()
cbd = read.csv('Data/cleaned_bird_data.csv')
cbd$Egg_mass
str(cbd)
megg = mean(cbd$Egg_mass, na.rm = TRUE)
big_egg = cbd[cbd$Egg_mass >(megg),]
dim(big_egg)
write.csv(big_egg, 'Assignments/Assignment_3/big_egg.csv')

megg = cbd$Egg_mass %>%
  mean(, na.rm = TRUE)

big_egg = cbd %>%
  filter(Egg_mass >megg)
View(big_egg)

write.csv(big_egg, 'Assignments/Assignment_3/big_egg.csv')

cbd %>%
  filter(Egg_mass >megg) %>%
  group_by(Mating_System) %>%
  summarise(min_egg = min(Egg_mass),
            max_egg = max(Egg_mass),
            avg_egg = mean(Egg_mass),
            N = n())

install.packages('palmerpenguins')
library(palmerpenguins)
penguins
View(penguins)
names(penguins)
avg = penguins$bill_length_mm %>%
  mean( na.rm = TRUE)
View(avg)

penguins %>%
  filter(!is.na(sex)) %>%
  group_by(species, year, island, body_mass_g, sex, bill_length_mm,flipper_length_mm) %>%
  summarise(avg = mean(bill_length_mm, na.rm = TRUE)) %>%
  summarise(avgf = mean(flipper_length_mm, na.rm = TRUE)) %>%
  arrange(avg) %>%
  relocate(sex, .after = species) %>%
  relocate(island, .after = sex) %>%
  arrange(match(sex, c('male'))) %>%
  select(island, species, body_mass_g, sex) %>%
  mutate(new_col = case_when(avg >50 ~ 'big_guy', TRUE ~ 'normal'))

vec = c(1, 2, NA)
!is.na(vec)

penguins %>%
  filter(!is.na(bill_length_mm)) %>%
  pluck('bill_length_mm') %>%
  mean()

case_when()