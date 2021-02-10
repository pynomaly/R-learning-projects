library(tidyverse)
library(RSQLite)
library(DBI)

setwd("~/projects/R_learning/dataquest/SQL")

# Leer base de datos
conn <- dbConnect(SQLite(), 'jobs.db')

# Listar contenido de base de datos (tablas)
dbListTables(conn)

query <- "SELECT * from recent_grads"

result <- dbGetQuery(conn, query)
result

# pasar una query a un objeto conn
query <- "SELECT Major FROM recent_grads"
majors <- dbGetQuery(conn, query)
majors

# dbSendQuery() solo ejecuta la consulta, no devuelve nada
query <- "SELECT Major FROM recent_grads"
result <- dbSendQuery(conn, query)
majors <- dbFetch(result)

# podemos limitar lo que extrae con dbFetch()
query <- "SELECT Major FROM recent_grads"
result <- dbSendQuery(conn, query)
majors_2 <- dbFetch(result, n = 10)
majors_2

# dbConnect(lenguaje, base.bd)
# dbGetQuery(conn, query)
# dbSendQuery(conn, query)
# dbFetch(result, n = 1)

# Desconectar después de la consulta
dbClearResult(result)
result

dbDisconnect(conn)
conn

# Proceso completo
conn <- dbConnect(SQLite(), 'jobs.db')
query <- "SELECT Major FROM recent_grads ORDER BY 1 DESC"
result <- dbSendQuery(conn, query)
reverse_alphabetical <- dbFetch(result)
dbClearResult(result)
dbDisconnect(conn)

# SQLite shell in the command line ------------------

# sqlite3 chinook.db
# .headers on
# .mode column
# .tables
# .shell clear
# .quit

# CREATE TABLE [table_name] (
#   [column1_name] [column1_type],
#   [column2_name] [column2_type],
#   [column3_name] [column3_type],
#   [...]
# );
# 
# DROP TABLE [table_name];
# 
# .schema [table_name]

# CREATE TABLE <name> (
#   columna TIPO PRIMARY KEY,
#   columna TIPO,
#   columna TIPO,
#   FOREIGN KEY (columna) REFERENCES tabla(columna)
# );

# CREATE TABLE [table_name] (
#   [column_one_name] [column_one_type],
#   [column_two_name] [column_two_type],
#   [column_three_name] [column_three_type],
#   [column_four_name] [column_four_type],
#   PRIMARY KEY (column_one_name, column_two_name),
#   FOREIGN KEY (columna) REFERENCES tabla(columna)
# );

# Insertar filas en una tabla
# INSERT INTO [table_name] (
#   [column1_name],
#   [column2_name],
#   [column3_name]
# ) VALUES (
#   [value1],
#   [value2],
#   [value3]
# );

# Insertar columnas en una tabla
# ALTER TABLE [table_name]
# ADD COLUMN [column_name] [column_type];

# Cambias el valor de una columna
# UPDATE [table_name]
# SET [column_name] = [expression]
# WHERE [expression]

