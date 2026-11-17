#Assignment 7 Wrong data did the assignment listed in the files
library(tidyverse)
library(ggplot2)
airlines = read.csv('airlines.csv')
airports = read.csv('airports.csv')
flights = read.csv('jan_flights.csv')
snow = read.csv('Jan_snowfall.csv')
View(airlines)
View(airports)
View(flights)
View(snow)

#Cleaning the data keep on wrangling this, I am nearly there
#First I am going to combine year, month, and day columns in the flight dataset
flights2 = flights %>%
  unite("MD", MONTH:DAY, remove = TRUE) %>%
  unite("Date", MD:YEAR, remove = TRUE) %>%
  mutate(DATE = as.Date(Date, format = '%m_%d_%Y')) %>%
  select(-Date) %>%
  rename(AIRLINEABV = AIRLINE)
View(flights2)

#Second to clean up is airlines, so I can join it neatly with flights
airlines2 = airlines %>%
  rename(AIRLINEABV = IATA_CODE)
View(airlines2)

#next I am going to clean up the airports dataset
#This ended up not being needed since I had to group by state later
#but to get the most clean dataset this is what I would do.
airports2 = airports %>%
  unite('CS', CITY:STATE, remove = TRUE) %>%
  unite("Location", CS:COUNTRY, remove = TRUE) %>%
  unite('Coordinates_LAT_LON', LATITUDE:LONGITUDE, remove = TRUE)
View(airports2)
  
#Now to rename the iata in snow to get a cleaner join
snow2 = snow %>%
  rename(IATA_CODE = iata) %>%
  mutate(DATE = as.Date(Date, format = '%Y-%m-%d')) %>%
  select(-Date)
View(snow2)

#Combining the data
#First I am going to combine snow and flights2 using Date
combine_flights2_snow2 = full_join(flights2, snow2)
View(combine_flights2_snow2)

#Next I am going to combine airlines and the combined flights and snow
combine_3 = full_join(combine_flights2_snow2, airlines2)
View(combine_3)

#Now I am going to combine both these two joined datasets, to put them all into one large dataset
#My computer cannot handle this and crashes here everytime.
combine_all = full_join(combine_3, airports)
View(combine_all)

#Here is the plotting section of the assignment
#I was not able to test or run this code myself due to the aforementioned computer crashing
#Delay by state
combine_all %>%
  group_by(DEPARTURE_DELAY, STATE, DATE) %>%
  summarise(AVG_DELAY = mean(DEPARTURE_DELAY)) %>%
  ggplot(aes(x = DATE,
             y = AVG_DELAY)) +
  facet_wrap(STATE) +
  geom_point()

#Delay by airline
combine_all %>%
  group_by(DEPARTURE_DELAY, ARRIVAL_DELAY, STATE, DATE) %>%
  summarise(AVG_DELAY = mean(DEPARTURE_DELAY + ARRIVAL_DELAY)) %>%
  ggplot(aes(x = DATE,
             y = AVG_DELAY)) +
  facet_wrap(AIRLINE) +
  geom_point()

#Departure delay by snowfall
combine_all %>%
  group_by(DEPARTURE_DELAY, ARRIVAL_DELAY, DATE, snow_percip_cm) %>%
  ggplot(x = snow_percip_cm,
         y = DEPARTURE_DELAY,
         color = ARRIVAL_DELAY) +
  geom_point()
#or the last one could be done like this
combine_all %>%
  group_by(DEPARTURE_DELAY, ARRIVAL_DELAY, DATE, snow_percip_cm) %>%
  ggplot(x = DEPARTURE_DELAY,
         y = ARRIVAL_DELAY,
         color = snow_percip_cm) +
  geom_point()
#or this
combine_all %>%
  group_by(DEPARTURE_DELAY, ARRIVAL_DELAY, DATE, snow_percip_cm) %>%
  ggplot(x = DEPARTURE_DELAY,
         y = ARRIVAL_DELAY,
         color = WEATHER_DELAY) +
  facet_wrap(snow_percip_cm)
  geom_point()