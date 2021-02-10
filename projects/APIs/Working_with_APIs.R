library(httr)

# modify_url(url, path)

wb_api_json_get_df <- function(endpoint){
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  return(url)
}

wb_country_url <- wb_api_json_get_df("v2/country")

# Edit this function with respect to the first instruction
wb_api_json_get_df <- function(endpoint) {
  
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  
  # TODO 1: add code to query the API
  response <- GET(url)
  # TODO 2: modify to return the API response
  return(response)
}

# Type the answer to the second instruction below
wb_indicator_response <- wb_api_json_get_df("v2/indicator?format=json")
wb_indicator_response

# status response
# 200: OK
# 301: The server is redirecting us to a different endpoint. REDIRECCIÓN
# 401: The server thinks we're not authenticated. AUTENTICACIÓN
# 400: bad request. PETICIÓN INCORRECTA
# 403: resource forbidden. FALLO PERMISOS
# 404: didn't find. NO ENCONTRADO

# http_error(response): TRUE, FALSE
# status_code(response): 404
# http_type(response): format of the content

# Check if an error occurs
# if (check_error_function(response)) {
#   stop("Something went wrong.", call. = FALSE)
# }

# Edit this function with respect to the first instruction
wb_api_json_get_df <- function(endpoint) {
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url)
  # TODO: Add code to track errors here
  if (http_error(response)){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Returning the API Response
  response
}
# Type the answer to the second instruction below
wb_indicator_response <- wb_api_json_get_df("v2/indicator?format=json")

# Devuelve el contenido de la peticion
wb_api_json_get_df <- function(endpoint) {
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extract content
  content <- content(response, as = "text")
  # Return the extracted content
  return(content)
}

wb_indicator_json_text <- wb_api_json_get_df("v2/indicator?format=json")

# Convertir respuesta en un df
wb_api_json_get_df <- function(endpoint) {
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Convert the extracted content into a dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Modify to return the dataframe 
  return(dataframe)
}

wb_indicator_json_df <- wb_api_json_get_df("v2/indicator?format=json")
wb_indicator_json_df


# Extracting the real dataframe [[2]] from the output list
wb_api_json_get_df <- function(endpoint) {
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  return(dataframe[[2]])
}

wb_indicator_json_df <- wb_api_json_get_df("v2/indicator?format=json")
head(wb_indicator_json_df)

wb_indicator_df <- wb_api_json_get_df("v2/indicator?format=json")
head(wb_indicator_df)

# Añadimos el GET request con parámetro query de GET(url, query = list(format="json"))
response <- httr::GET(
  "http://api.worldbank.org/v2/indicator", 
  query = list(format="json")
  )
json_df <- jsonlite::fromJSON(httr::content(response, "text"))[[2]]
str(json_df)

# metemos la query como parametro en la funcion
wb_api_json_get_df <- function(endpoint, queries = list()){
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if ( http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  dataframe[[2]]
  }
# Type the answer to the second instruction below
wb_indicator_df_with_param <- wb_api_json_get_df(
  "v2/indicator", 
  list(format="json")
  )
head(wb_indicator_df_with_param)

# two pagination query parameters: page and per_page
response <- httr::GET("http://api.worldbank.org/v2/indicator", 
                      query = list(format = "json", page=2, per_page = 100))
json_df <- jsonlite::fromJSON(httr::content(response, "text"))[[2]]
str(json_df)

wb_indicator_json_df_3 <- wb_api_json_get_df(
  "v2/indicator", 
  queries = list(
    format = "json", 
    page=3, 
    per_page=75)
  )

# authentication
# authenticate("username", "password")
# api_key = "key"
# queries = list(api_key = "1f36137fbbe1602f779300dad26e4c1b7fbab631")

gov_api_json <- function(endpoint, queries = list()) {
  # Preparing the URL 
  url <- modify_url("https://api.ers.usda.gov", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Return the dataframe
  jsonlite::fromJSON(json_text)$data # CHANGE $
}

agriculture_categories <- gov_api_json(
  "data/arms/category", 
  queries = list(api_key="JnFZggTTuOCRw7mCbKJzrgKS5fBpoeS0V7bfOiEu")
  )

View(agriculture_categories)

# prueba de post en httpbin
POST("http://httpbin.org/post", 
     body = list(comment = "Hello world", name = "authordq"))

# POST(url, body=list(queries))
httpbin_response <- POST("http://httpbin.org/post",
                         body=list(message = "this is a test",
                                   name = "anomalia"))

check_error <- http_error(httpbin_response)

print(httpbin_response)

# DELETE(elimina) y PUT(reemplaza)

# Challenge ---------------
# API requests
# response <- GET(url)
# 
# Check the status of the request
# status <- status_code(response)
# 
# Extracting content
# content <- content(response)

# API: https://github.com/15Dkatz/official_joke_api
response <- GET("https://official-joke-api.appspot.com/random_joke")

status <- status_code(response)

content <- content(response)
print(content)
print(status)

# response <- GET(url)
# status_code(response)
# content(response)

# API: https://github.com/workforce-data-initiative/skills-api/wiki/API-Overview

response <- GET("http://api.dataatwork.org/v1/jobs/8fd068c8d9be73abfa678856177b6c40")
status <- status_code(response)
the_job <- content(response)

# MEETUP API
meetup_api_json_get_df <- function(endpoint, queries = list()) {
  # Preparing the URL 
  url <- modify_url("https://api.meetup.com", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if (http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  dataframe
}

data_analytics_meetups <- meetup_api_json_get_df(
  "find/topics", 
  list(
    query = "data analytics", 
    only = "id,name,description"))

data_analytics_meetups

# World Bank API: https://datahelpdesk.worldbank.org/knowledgebase/articles/898581-api-basic-call-structures 
# Ejemplo: http://api.worldbank.org/v2/country/all/indicator/SP.POP.TOTL?format=json
# endpoint (después de la url de la api, hasta la ?): v2/country/all/indicator/<clave_indicator>
# queries (todo lo que va después de la ?): list(format="json", date=1989:2000)

library(tidyverse)

wb_api_json_get_df <- function(endpoint, queries = list()){
  # Preparing the URL 
  url <- modify_url("http://api.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if ( http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  dataframe[[2]]
}

wb_poverty_level <- wb_api_json_get_df(
  "v2/country/afr/indicator/NV.AGR.PCAP.KD.ZG", 
  list(date="1989:2000", 
       format="json"))

# IGUAL QUE:
wb_poverty_level <- wb_api_json_get_df(
  "v2/country/afr/indicator/NV.AGR.PCAP.KD.ZG?date=1989:2000&format=json")

wb_poverty_level

str(wb_poverty_level)

wb_poverty_level %>%
  ggplot(aes(x=date, y=value, group=1)) +
  geom_line() +
  ylab("Real agricultural GDP per capita growth rate (%)")

# Trefle API: https://docs.trefle.io/docs/guides/getting-started/

trefle_api_json_get_df <- function(endpoint, queries = list()){
  # Preparing the URL 
  url <- modify_url("https://trefle.io/", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if ( http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  dataframe$data$common_name
}

top_20_plants_df <- trefle_api_json_get_df("api/v1/plants?order[year]=desc", 
                       queries = list(token="ke5QkgTgyy2ItDFvJAJrd-EnZuFVExlT5jZW4IntLco"))

# IGUAL QUE:
top_20_plants_df <- trefle_api_json_get_df("api/v1/plants?token=ke5QkgTgyy2ItDFvJAJrd-EnZuFVExlT5jZW4IntLco&order[year]=desc")

View(top_20_plants_df)

# API Climate Data API: https://datahelpdesk.worldbank.org/knowledgebase/articles/889386-developer-information-overview
climate_api_json_get_df <- function(endpoint, queries = list()){
  # Preparing the URL 
  url <- modify_url("http://climatedataapi.worldbank.org", path = endpoint)
  # API requests
  response <- GET(url, query = queries)
  # Tracking errors
  if ( http_error(response) ){
    print(status_code(response))
    stop("Something went wrong.", call. = FALSE)
  }
  if ( http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Extracting content
  json_text <- content(response, "text")
  # Converting content into Dataframe
  dataframe <- jsonlite::fromJSON(json_text)
  # Return the dataframe  
  dataframe
}

climate_nigeria_2039_1 <- climate_api_json_get_df("climateweb/rest/v1/country/manom/bccr_bcm2_0/a2/tas/2020/2039/NGA")
climate_nigeria_2039_2 <- climate_api_json_get_df("climateweb/rest/v1/country/manom/cccma_cgcm3_1/a2/tas/2020/2039/NGA")

str(climate_nigeria_2039_1)
str(climate_nigeria_2039_2)

gcm <- c(rep("bccr_bcm2_0", 12), rep("cccma_cgcm3_1", 12))

# month.abb = contains the month abreviation
month <- rep(month.abb, 2)
month

value <- c(climate_nigeria_2039_1$monthVals[[1]], climate_nigeria_2039_2$monthVals[[1]])
value

df <- tibble::tibble("gcm" = gcm, "month" = month, "value" = value)

df %>% ggplot(
  aes(x = factor(month, levels = month.abb),   #para que los trate como categorías y no los mueva
  y=value, 
  group=gcm, 
  color=gcm)) +
  geom_line() +
  ylab("Average monthly change of Temperature (anomaly)") + 
  xlab("Month")
