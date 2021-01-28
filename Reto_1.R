install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")


dbListTables(MyDataBase)
dbListFields(MyDataBase, "CountryLanguage")
data <- dbGetQuery(MyDataBase,'SELECT * FROM CountryLanguage')

porcentajes_español <- data %>% filter(Language == "Spanish")
head(porcentajes_español)
porcentajes_español %>% ggplot() + 
  aes(x = Percentage, y = CountryCode, fill = IsOfficial) +
  geom_bin2d() 
  
