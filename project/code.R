install.packages("tidyverse")
install.packages("plotly")
library(plotly)
library(tidyverse)
indiator_1 <- read_csv("indiator 1.csv")
indicator2 <- read_csv("indicator2.csv")
unicef_metadata <- read_csv("unicef_metadata.csv")
colnames(unicef_metadata)[8] <- 'GDP_Per_Capita'
colnames(data_join)[18] <- 'GDP_Per_Capita'
colnames(data_join)[21] <- 'Life_Exp'
colnames(data_join)[17] <- 'pop'
colnames(data_join)[7] <- 'Women_Subjected_to_Violence'
colnames(indiator_1)[7] <- 'Women_Subjected_to_Violence'
data_join<- full_join(indiator_1, unicef_metadata)

map_world<- map_data("world")

#map
map_data_join <- full_join(indiator_1, map_world, by=c("country"="region"))

ggplot(map_data_join) +
  aes(x = long, y = lat, group = group, fill = Women_Subjected_to_Violence ) +
  scale_fill_gradient(low = "pink", high = "red") +
  geom_polygon()
  

#timeseries
data_join %>%
  ggplot() +
  aes(year , GDP_Per_Capita  , group = country, color = "red") +
  geom_line()
  

#scatterplot

ggplot(data_join) +
  aes(GDP_Per_Capita, Life_Exp , color = year) +
  geom_point(alpha = 0.2) +
  scale_x_continuous(limits = c(0,10000)) +
  scale_color_gradient(low = "pink", high = "red")

   

#barchart

data_join %>%
  group_by(Women_Subjected_to_Violence, GDP_Per_Capita) %>%
 ggplot() +
  aes(Women_Subjected_to_Violence, GDP_Per_Capita,  fill = Women_Subjected_to_Violence) +
  scale_fill_gradient(low="pink",high='red') +
  scale_y_continuous(limits = c(0,100000),
                     labels = scales::unit_format(unit = "k", scale = 0.001))+
  geom_col(width = 0.5) 
  

