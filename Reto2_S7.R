#Reto 2. Extracci�n de tablas en un HTML

library(rvest)

#De la siguiente direcci�n donde se muestran los sueldos para Data Scientists

#(https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), realiza las siguientes acciones:
  
# 1. Extraer la tabla del HTML
url  <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(url) 

tables <- html_nodes(file, "table") # Selecciona pedazos dentro del HTML para identificar la tabla
#Hay que encontras en donde est� la tabla, s�lo hay un nodo
tables

table <- html_table(tables[1], fill = TRUE)

tabla <- na.omit(as.data.frame(table)) #Omitimos las repeticiones

str(tabla)  # Vemos la naturaleza de las variables
names(tabla)

# 2. Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea n�mero), 
#para dejar solamente la cantidad mensual (Hint: la funci�n gsub podr�a ser de utilidad)
?gsub 

#Vemos lo que hay en sueldo 
tabla$Sueldo #Encontramos que es de la forma MXN$29,822/mes
nuevo <- gsub("MXN","",tabla$Sueldo)
nuevo <- gsub("/mes","",nuevo) 
nuevo <- gsub("\\$","",nuevo)
nuevo <- gsub(",","",nuevo)

# 3. Asignar �sta columna como tipo num�rico para poder realizar operaciones con ella.

nuevo.num <- as.numeric(nuevo)
tabla$Sueldo <- nuevo.num

#La nueva tabla es:
tabla

# 4. Ahora podr�s responder esta pregunta �Cu�l es la empresa que m�s paga y la que menos paga?

sueldo.max <- which.max(tabla$Sueldo) #La posici�n del sueldo m�x 
m�ximo.sueldo <- tabla[sueldo.max,]

sueldo.min <- which.min(tabla$Sueldo) #La posici�n del sueldo m�x 
m�nimo.sueldo <- tabla[sueldo.min,]
