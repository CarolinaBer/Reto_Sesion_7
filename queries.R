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

#Explorando la BD
dbListTables(MyDataBase)

#Escogiendo el campo deseado
dbListFields(MyDataBase, 'CountryLanguage')

# Para realizar una consulta tipo MySQL sobre la tabla seleccionada haremos lo 
# siguiente

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(DataDB)


Esp <- DataDB %>% filter(Language == "Spanish")
DF.Esp <- as.data.frame(Esp) 
head(DF.Esp)

#Tienen que colocarse las etiquetas "al revés"
DF.Esp %>% ggplot(aes( x = CountryCode, y= Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()