#Exam 2
dat = read.csv('unicef-u5mr.csv')
View(dat)
library(tidyverse)
library(ggplot2)

#Cleaning the data
clean_dat = dat %>%
  pivot_longer(starts_with('U5MR.'),
               names_to = 'Year', values_to = 'U5MR') %>%
  mutate(Year = as.numeric(str_remove(Year, 'U5MR\\.')))
View(clean_dat)

#U5MR plot over time, by each country
clean_dat %>%
  ggplot(aes(x = Year, y = U5MR, group = CountryName)) +
  facet_wrap(~Continent) +
  geom_line()
ggsave('MURPHY_Plot_1.png')
#Note to self, if geom_line gives vertical lines instead of wanted horizontal, use group = CountryNames or whatever metric

#Mean U5MR per continent plot ???
clean_dat %>%
  group_by(Year, Continent) %>%
  summarise(Mean_U5MR = mean(U5MR, na.rm = T)) %>%
  ggplot(aes(x = Year, y = Mean_U5MR, color = Continent, group = Continent)) +
  geom_line()
ggsave('MURPHY_Plot_2.png')

#Creating models of the data
library(easystats)
mod1 = glm(formula = U5MR ~ Year, data = clean_dat)
summary(mod1)
report(mod1)

mod2 = glm(formula = U5MR ~ Year + Continent, data = clean_dat)
summary(mod2)
report(mod2)

mod3 = glm(formula = U5MR ~ Year*Continent, data = clean_dat)
summary(mod3)
report(mod3)

compare_models(mod1, mod2, mod3)
compare_performance(mod1, mod2, mod3)
#The third model takes the most into account and has the highest R^2 value, this is the model that I think is best

#Predictions of the models
dat_predictions = clean_dat
dat_predictions$pred1 = predict(mod1, dat_predictions)
dat_predictions$pred2 = predict(mod2, dat_predictions)
dat_predictions$pred3 = predict(mod3, dat_predictions)

#Tidying the predictions in preparation for plotting them
dat_predictions_colated = dat_predictions %>%
  pivot_longer(cols = c('pred1', 'pred2', 'pred3'), 
               names_to = 'Model', values_to = 'Predicted_U5MR')

#Plotting the model predictions
dat_predictions_colated %>%
  ggplot(aes(x = Year, y = Predicted_U5MR, color = Continent, group = Continent)) +
  facet_wrap(~Model) +
  geom_line() +
  labs(title = "Model predictions")
ggsave("MURPHY_Plot_3.png")
