#Class example 3 Modeling and Statistics
library(palmerpenguins)
library(tidyverse)
library(ggplot2)

#Linear models
#T test
penguins %>%
  drop_na() %>%
  ggplot(aes(x = body_mass_g,
             fill = sex)) +
  geom_density(alpha = 0.5)

t.test(body_mass_g ~ sex, data = penguins)

#aov test
aov1 = aov(formula = body_mass_g ~ species, data = penguins)
summary(aov1)

#GLM and LM general linear model
mod2 = glm(formula = body_mass_g ~ species, data = penguins)
lm(formula = body_mass_g ~ species, data = penguins)

penguins %>%
  group_by(species) %>%
  summarise(avg = mean(body_mass_g, na.rm =TRUE))

penguins$species = relevel(penguins$species, ref = "Gentoo") %>%
  glm(formula = body_mass_g ~ species, data = penguins)

#Model predicting
install.packages("easystats")
library(easystats)

dat_pen = penguins
dat_pen = data.frame(species = c(rep("Gentoo", 3),
                     rep('Adelie', 5),
                     rep('Chinstrap', 3)))
dat_pen$predict = predict(mod2, dat_pen)
summary(dat_pen$predict)

View(mpg)
mod3 = glm(formula = cty ~ displ, data = mpg)
summary(mod3)
summary(aov(formula = cty ~ displ, data = mpg))
report(mod3)

mpg %>%
  ggplot(aes(x = displ,
             y = cty,
             label = 'R^2 = 0.64')) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

dat_car = data.frame(displ = 0:100)
dat_car$pred_mpg = predict(mod3, dat_car)
View(dat_car)

#building a model to predict cty will crash laptop, do not run!
mod4 = glm(formula = cty ~ class*displ*year*cyl*model*manufacturer*drv*trans*fl*hwy, data = mpg)
summary(mod4)
report(mod4)

compare_models(mod3, mod4)
compare_performance(mod3, mod4) %>% plot

#model above too heavy, creating some simpler models
mod5 = glm(formula = cty ~ cyl, data = mpg)
mod6 = glm(formula = cty ~ cyl + displ, data = mpg)
mod7 = glm(formula = cty ~ cyl*displ, data = mpg)
report(mod5)
report(mod6)
report(mod7)
compare_models(mod5, mod6, mod7)

mpg2 = mpg
mpg2$pred1 = predict(mod5, mpg2)
mpg2$pred2 = predict(mod6, mpg2)
mpg2$pred3 = predict(mod7, mpg2)

mpg2 %>%
  ggplot(aes(x = displ, y = cty, color = factor(cyl))) +
  geom_point() + 
  geom_smooth()

mpg2 %>%
  ggplot(aes(x = displ, y = pred2, color = factor(cyl))) +
  geom_point() +
  geom_smooth()

mpg2 %>%
  ggplot(aes(x = displ, y = pred3, color = factor(cyl))) +
  geom_point() +
  geom_smooth()

#combining all three models into one graph
mpg_comb = mpg2  %>%
  pivot_longer(cols = c('pred1', 'pred2', 'pred3',..), names_to = "Prediction")
View(mpg_comb)

mpg_comb = mpg2 %>%
  pivot_longer(starts_with('pred'))
View(mpg_comb)

mpg_comb %>%
ggplot(aes(x = displ, y = cty, color = factor(cyl))) +
  geom_point() +
  geom_point(aes( y = value), color = 'black') +
  facet_wrap(~name)

#revisiting the best model
mod8 = glm(formula = cty ~ class*displ*year*cyl*trans*fl, data = mpg)
summary(mod8)
report(mod8)

#penguin simple model
modelp = glm(formula = body_mass_g ~ species + sex, data = penguins)
summary(modelp)
report(modelp)

#Logistic regression models, outcome is true or false and not continous
peng = penguins
peng2 = peng %>%
  mutate(Gentoo = case_when(species == 'Gentoo' ~ TRUE, TRUE ~ FALSE))
  View(peng2)

mod_log = glm(data = peng2, 
              formula = Gentoo ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g,
              family = 'binomial')
summary(mod_log)

peng2$pred = predict(mod_log, peng2, type = 'response')
View(peng2)

#validating a model
peng3 = peng2 %>%
  mutate(Outcome = case_when(pred > 0.75 ~ 'Gentoo',
                              pred < 0.25 ~ 'Not Gentoo',
                              TRUE ~ 'IDK'))
View(peng3)

