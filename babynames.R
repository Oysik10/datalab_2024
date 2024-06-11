#babynames library

library(babynames)
babynames -> bb_names

library(ggplot2)
library(dplyr)
library(tidyverse)

ggplot(data=bb_names %>% filter(name=='Marie') %>% filter(year>1982), aes(x=year))+
         geom_density()

ggplot(data=bb_names %>% filter(name=='Joe'), aes(x=year, y=prop, col=sex))+
  geom_line(alpha=.5, linewidth=1)+
  labs(
    title='Proportion of Joe Names', 
    x='Years', 
    y='Proportion'
  )
top_5<-bb_names %>% 
  filter(sex=='F') %>% filter(year==2002) %>% arrange(desc(prop)) %>% head(5) %>% 
  mutate(name=fct_reorder(factor(name), desc(prop)))

ggplot(data=top_5, aes(x=name, y=prop))+
  geom_col(color='Blue', fill='Blue', alpha=.5)

the_nineties<-bb_names %>% 
  filter(1990<=year) %>% 
  filter(year<2000)

write.csv(the_nineties, 'the_nineties.csv')
