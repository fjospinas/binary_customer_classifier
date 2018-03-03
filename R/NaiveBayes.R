print(Sys.time())
print("Inicio de Proceso")
####################################################################
#Eliminamos limites de memoria

memory.size(max = FALSE)

memory.limit(size = NA)


#####################################################################
# Comenzamos validando si se cuentan con las librerias necesarias,
# en caso de no ser asi , se instalan.

if (!require("MASS")) install.packages("MASS")
if (!require("RODBC")) install.packages("RODBC")
if (!require("plyr")) install.packages("plyr")
if (!require("sqldf")) install.packages("sqldf")


#Cargamos las librerias necesarias.

library(RODBC)
library(plyr)
library(sqldf)
library(MASS)
install.packages("pbkrtest")
install.packages("caret")
install.packages("e1071")
install.packages("pROC")
library(pROC)
library(e1071)
library(caret)
library(pbkrtest)



# Obtenemos los datos ctualizados de nuestras tablas fuente de SQL
Customer <- read.csv("data/Customer_train.txt", sep=",", header=T)

# Obtenemos los datos ctualizados de nuestras tablas para test
customer_test <-read.csv("data/Customer_test.csv", sep=",", header=T)
customer_test <- customer_test[,2:6]
customer_test

#creamos el modelo 
model <- naiveBayes(buys_computer ~ ., data=Customer, laplace = 1)

#generamos la predicción
predict(model, customer_test)



#unimos ambas tablas
predicciones1 <- predict(model, customer_test)
customer_predicciones<-cbind(customer_test, predicciones1)
customer_predicciones

pred_train = predict(model, Customer[,1:4])
pred_train==Customer[5]
aa =Customer[5]
aa = as.vector(aa)
sum(as.vector(pred_train) ==aa) /nrow(Customer)*100
