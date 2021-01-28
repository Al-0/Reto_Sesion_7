# install.packages("rvest")
library(rvest)
# Introducimos una dirección URL donde se encuentre una tabla

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    # Leemos el html
# Selecciona pedazos dentro del HTML para identificar la tabla

tables <- html_nodes(file, "table")  
# Hay que analizar 'tables' para determinar cual es la posición en la lista 
# que contiene la tabla, en este caso es la no. 4

# Extraemos la tabla de acuerdo a la posición en la lista
tables
table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   # Quitamos NA´s que meten filas extras 
# y convertimos la lista en un data frame para su manipulación con R

str(table)  # Vemos la naturaleza de las variables
# Por último realizamos una conversión de una columna tipo chr a num, se pueden 
# hacer las conversiones que se requieran

View(table)

library(dplyr)
table_clean <- table %>% mutate(Sueldo = as.numeric(gsub("\\D","",Sueldo)))

table_clean[which.max(table_clean$Sueldo),]
table_clean[which.min(table_clean$Sueldo),]
