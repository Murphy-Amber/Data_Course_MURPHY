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

library(tidyverse)
library(palmerpenguins)

penguins_big = penguins %>%
  filter(body_mass_g > 5000, bill_length_mm > mean(bill_length_mm, na.rm = TRUE)) %>%
  filter(!is.na(sex)) %>%
  group_by(island, sex) %>%
  summarise(max_weight = max(body_mass_g, na.rm = TRUE), 
            max_length = max(bill_length_mm, na.rm = TRUE), n())
print(penguins_big)

penguins %>%
  drop_na %>%
  mutate(realative_size = case_when(body_mass_g > 5000 & bill_length_mm > mean(bill_length_mm) ~'big', 
                             TRUE ~ 'small')) %>%
  View()

#making a plot
library(ggplot2)
?gglot()

ggplot(data = penguins,
       aes(x = body_mass_g,
           y = bill_length_mm,
           color = sex,
           shape = island)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)

ggplot(data = penguins_big,
       aes(x = max_weight,
           y = max_length,
           color = island,
           shape = sex, na.rm = TRUE)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

ggsave()

ggplot(data = penguins,
       aes(x = sex,
           y = body_mass_g,
           color = island)) +
  geom_boxplot()
ggsave('Penguin size by island and sex boxplot.png')

ggplot(data = penguins,
       aes(x = island,
           color = sex)) +
  geom_bar()
ggsave('Penguin sex count per island.png')

ggplot(data = penguins,
       aes(x = bill_length_mm)) +
  geom_histogram()
ggsave('Penguins bill length comparison.png')

ggplot(data = penguins,
       aes(x = bill_depth_mm,
           fill = species)) +
  geom_density(alpha = 0.7, linetype = 'dashed') +
  labs(title = 'Penguins')
ggsave('Penguins bill depth species comparison.png')

ggplot(data = penguins,
       aes(x = species,
           y = body_mass_g,
           fill = sex)) +
  geom_bar(stat = 'identity',
           position = 'dodge')

#more advanced plot

library(tidyverse)
penguins %>%
  drop_na(sex) %>%
  group_by(sex, body_mass_g, island) %>%
  summarise(avg = mean(body_mass_g)) %>%
  ggplot(aes(x = island,
             y = avg,
             fill = sex)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  stat_summary(fun.data = mean_se, geom = 'errorbar') +
  theme_bw()

#fix with a scatter plot
library(palmerpenguins)
scale_color_viridis_d(option = 'rocket', end = -1) +
  facet_wrap(species) +
  geom_point

  
#new penguins data plot
library(palmerpenguins)
library(tidyverse)
penguins %>%
  drop_na(sex) %>%
  group_by(sex, bill_depth_mm, body_mass_g) %>%
  summarise(avgmass = mean(body_mass_g), avgdepth = mean(bill_depth_mm)) %>%
  ggplot(aes(x = avgmass,
             y = avgdepth,
             fill = sex)) +
  geom_area() +
  geom_smooth() +
  labs(title = 'Penguins size vs bill depth', 
       x = 'average mass g',
       y = 'average bill depth mm',
       color = 'Sex') +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(angle = 20, size = 10)) +
  scale_y_continuous(limits = c(0, 40))

#timing
sys.time()
as.date('10/6/2026', format = '%m/%d/%y')
str(dat)
str('10/6/2026')

#patchwork for easier graph modification
install.packages('patchwork')
library(patchwork)

#dino data plot
read.delim('Data/DatasaurusDozen.tsv')
read.csv('Data/DatasaurusDozen.tsv')
dinodf = read.delim('Data/DatasaurusDozen.tsv')
str(dinodf)
names(dinodf)
dinodf %>%
  group_by(x, y) %>%
  summarise(avgx = mean(x), avgy = mean(y), 
            maxx = max(x), maxy = max(y), 
            minx = min(x), miny = min(y),
            sdx = sd(x), sdy = sd(y))


dinodf %>%
ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_text(aes(label = 'dino')) +
  annotate('text', label = 'y=mx+b',
           y = 100, x = 100) +
  facet_wrap(~dataset)

#vjust and hjust vertical and horizontal adjustment

#GGally package to make things easier only for small datasets
install.packages('GGally')
library(GGally)
library(palmerpenguins)
ggpairs(penguins)

penguins  %>%
  drop_na(sex) %>%
  ggplot(aes(x = bill_depth_mm,
             y = body_mass_g,
             color = sex)) +
  theme_bw() +
  theme(strip.background = element_blank()) +
  geom_point(size = 4, alpha = 0.75) +
  facet_wrap('species') +
  labs(x ='Bill depth (mm)', y = 'Body mass (g)', color = 'Sex') +
  scale_color_viridis_d(option = 'rocket', end = 0.5)

#ggmap
install.packages('ggmap')
library(ggmap)
ggmap(world.map)

#leaflet
install.packages('leaflet')
library(leaflet)

#animations
install.packages('gapminder')
install.packages('gganimate')
install.packages('gifski')
install.packages('av')
library(gapminder)
library(gganimate)
library(ggmap)
library(ggplot2)
library(tidyverse)
library(gifski)
library(av)

names(gapminder)
gapminder %>%
group_by('continent', 'LifeExp', 'gdpPercap') %>%
ggplot(aes(x = lifeExp,
           y = gdpPercap,
           color = continent)) +
  facet_wrap(~ continent) +
  labs(title = 'year{frame_time}') +
  transition_time(time = year) +
  geom_point() +
  geom_text(aes(label = country), vjust = 1.5)
  
anim_save("gdp_and_lifeexp_by_year_by_continent.gif")
ggsave("gdp and life expectancy separated by continent.png")

unique(gapminder$country)
range(gapminder$year)
unique(gapminder$lifeExp)
range(gapminder$lifeExp)

my_country = c('Kuwait', "France","Taiwan", 'Switzlerland')
gapminder %>%
  mutate(my_label = case_when(country %in% my_country))  #!#
ggplot(aes(x = lifeExp,
           y = gdpPercap,
           color = continent)) +
  facet_wrap(~ continent) +
  labs(title = 'year{frame_time}') +
  transition_time(time = year) +
  geom_point() +
  geom_text(aes(label = my_label), vjust = 1.5)
