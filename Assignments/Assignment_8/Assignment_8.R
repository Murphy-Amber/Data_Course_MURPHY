#Assignment 8
dat = read.csv('../../Data/mushroom_growth.csv')
View(dat)
library(tidyverse)
library(ggplot2)
library(easystats)

#Plots for the data
dat %>%
  ggplot(aes(x = Light,
             y = GrowthRate)) +
  geom_point()

dat %>%
  ggplot(aes(x = Nitrogen,
             y = GrowthRate)) +
  geom_point()

dat %>%
  ggplot(aes(x = Humidity,
             y = GrowthRate)) +
  geom_point()

dat %>%
  ggplot(aes(x = Temperature,
             y = GrowthRate)) +
  geom_point()

#Modeling the data
aov1 = aov(formula = GrowthRate ~ Temperature, data = dat)
summary(aov1)
aov2 = aov(formula = GrowthRate ~ Humidity, data = dat)
summary(aov2)
aov3 = aov(formula = GrowthRate ~ Nitrogen, data = dat)
summary(aov3)
aov4 = aov(formula = GrowthRate ~ Light, data = dat)
summary(aov4)

mod1 = glm(formula = GrowthRate ~ Temperature, data = dat)
summary(mod1)
report(mod1)
mean(mod1$residuals^2)

mod2 = glm(formula = GrowthRate ~ Humidity, data = dat)
summary(mod2)
report(mod2)
mean(mod2$residuals^2)


mod3 = glm(formula = GrowthRate ~ Nitrogen, data = dat)
summary(mod3)
report(mod3)
mean(mod3$residuals^2)

mod4 = glm(formula = GrowthRate ~ Light, data = dat)
summary(mod4)
report(mod4)
mean(mod4$residuals^2)

compare_performance(mod1, mod2)
compare_performance(mod3, mod4)
compare_performance(mod2, mod4)

#Making a good model based upon the prior model and plot results
goodmod = glm(formula = GrowthRate ~ Light*Humidity, data = dat)
summary(goodmod)
report(goodmod)
mean(goodmod$residuals^2)

#Predictions based upon this good model and the two models that comprise it
dat2 = dat
dat2$pred1 = predict(goodmod, dat2)
dat2$pred2 = predict(mod2, dat2)
dat2$pred3 = predict(mod4, dat2)
View(dat2)

#Plotting the predictions and data
dat2 %>%
  ggplot(aes(x = Light,
             y = GrowthRate,
             color = factor(Humidity))) +
  geom_point()

dat2 %>%
  ggplot(aes(x = Light,
             y = pred1,
             color = factor(Humidity))) +
  geom_point()

dat2 %>%
  ggplot(aes(x = Light,
             y = pred2,
             color = factor(Humidity))) +
  geom_point()

dat2 %>%
  ggplot(aes(x = Light,
             y = pred3,
             color = factor(Humidity))) +
  geom_point()

#Combining the predictions into one graph
dat_comb = dat2 %>%
  pivot_longer(starts_with('pred'))
View(dat_comb)

dat_comb %>%
  ggplot(aes(x = Light, y = GrowthRate, color = factor(Humidity))) +
  geom_point() +
  geom_point(aes( y = value), color = 'black') +
  facet_wrap(~name)

#Code for the final response question
PolyLinear = lm(formula = GrowthRate ~ poly(Nitrogen, 5, raw = TRUE), data = dat)
summary(PolyLinear)
report(PolyLinear)
mean(PolyLinear$residuals^2)
#The above gives you a better fit, but the below model is simpler
SimpleGeneralLinear = glm(formula = GrowthRate ~ Nitrogen, data = dat)
summary(SimpleGeneralLinear)
report(SimpleGeneralLinear)
mean(SimpleGeneralLinear$residuals^2)
