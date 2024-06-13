library(tidyverse)
library(dplyr)

setwd('/Users/oysik10/Desktop/oysik_datalab/datalab_2024/cleaningds')

unclean_dives<- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/whales-dives-messy.csv')
messy_dives <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/whales-dives-messy.csv')
names(messy_dives)
messy_dives<-na.omit(messy_dives)
names(messy_dives)<-(c('species',
    'behavior',
    'prey.volume',
    'prey.depth',
    'dive.time',
    'surface.time',
    'blow.interval',
    'blow.number',
    'year',
    'month',
    'day',
    'sit'
  ))

messy_dives<-messy_dives %>% 
  mutate(species=ifelse(species %in% c('FinW','fw','FinWhale','fin','finderbender'), 'FW', species)) %>%
  mutate( behavior = ifelse( behavior == "FE", "FEED", behavior) )


messy_dives<-messy_dives %>% 
  mutate(year=ifelse(nchar(year)<4, paste0("20", year), year)) %>% 
  mutate(day=ifelse(nchar(day)<2, paste0("0", day), day)) %>% 
  mutate(month=ifelse(nchar(month)<2, paste0("0", month), month)) %>% 
  mutate(id=paste0(year, month, day, substr(sit, 10, 12))) 
messy_dives<-messy_dives%>% 
  mutate(behavior=toupper(behavior)) %>% 
  mutate(species=toupper(species)) %>% 
  relocate( id, .before = species ) %>% 
  arrange(id) %>% 
  distinct() %>%
  select( -year, -month, -day, -sit )


dives <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/whales-dives.csv')

identical(messy_dives, dives)

unclean_dives %>% 
  group_by(Species.ID) %>% 
  tally
dives %>% 
  group_by(species) %>% 
  tally

messy_dives %>% 
  group_by(species) %>% 
  tally

dives %>% 
  group_by(species) %>% 
  tally

messy_dives %>% 
  group_by(species) %>% 
  tally

test <- messy_dives %>% 
  filter(id %in% dives$id)
