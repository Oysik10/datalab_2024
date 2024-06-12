library(tidyverse)
library(sf)
library(tmap)
library(rnaturalearth)
library(rnaturalearthhires)
library(rnaturalearthdata)
setwd('/Users/oysik10/Desktop/oysik_datalab/datalab_2024/proj')
sewanee_weather<-read_csv('sewanee_weather.csv')

updated<- sewanee_weather %>%
  filter(year>=2000 & year<=2025) %>% 
  mutate(year = year(DATE),
         month = month(DATE)) %>%
  mutate(period = cut(year, breaks = seq(2000, 2025, by = 5))) %>%
  group_by(period, month) %>%
  summarize(mean_prcp = mean(PRCP, na.rm = TRUE))

updated<-na.omit(updated)
  
ggplot(data=updated, aes(x=month, y=mean_prcp, col=month))+
  geom_line()+
  facet_wrap(~period)
