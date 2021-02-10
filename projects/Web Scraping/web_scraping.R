library(httr)

response <- GET("http://dataquestio.github.io/web-scraping-pages/simple.html")
content <- content(response)
print(content)

library(rvest)
library(xml2)

new_content <- read_html("http://dataquestio.github.io/web-scraping-pages/simple.html")
print(new_content)

# html_nodes() function extracts all p tag elements

# html_text() function extracts the text (the content) from the p
p_text <- new_content %>% 
  html_nodes("p") %>%
  html_text()

print(p_text)

# url %>% 
#   read_html() %>% 
#   html_nodes("p") %>% 
#   html_text()

title_text <- new_content %>%
  html_nodes("title") %>%
  html_text()
title_text

content_2 <- read_html("http://dataquestio.github.io/web-scraping-pages/simple_classes.html")
b_text <- content_2 %>%
  html_nodes("b") %>%
  html_text()

first_outer_paragraph <- b_text[[1]]
first_outer_paragraph

# <p id="first>First paragraph.</p>
# html_nodes("#id")

content_3 <- read_html("http://dataquestio.github.io/web-scraping-pages/simple_ids.html")

first_paragraph_text <- content_3 %>%
  html_nodes("#first") %>%
  html_text()

second_paragraph_text <- content_3 %>%
  html_nodes("#second") %>%
  html_text()

# classes = html_nodes(".clase")

content_4 <- read_html("http://dataquestio.github.io/web-scraping-pages/simple_classes.html")
content_4

outer_paragraph_text <- content_4 %>%
  html_nodes(".outer-text") %>%
  html_text()

# extract from a table = html_node("table") + html_table()
content_5 <- read_html("http://dataquestio.github.io/web-scraping-pages/2014_super_bowl.html")

super_bowl_df <- content_5 %>% 
  html_node("table") %>% 
  html_table()

super_bowl_df

# extract from attributes:
# we can apply either html_attrs() to get all the attributes and their values 
# or html_attr() specifying an attribute name to get its values

content_6 <- read_html("http://dataquestio.github.io/web-scraping-pages/ids_and_classes.html")
content_6

# extrae todos los atributos = html_attrs()
p_attrs <- content_6 %>% 
  html_nodes("p") %>%
  html_attrs()

p_attrs

# extrae un atributo = html_attr()
p_attr_id <- content_6 %>% 
  html_nodes("p") %>%
  html_attr("id")

p_attr_id

p_class_values <- content_6 %>% 
  html_nodes("p") %>% 
  html_attr("class")

# Intermediate webscraping ------------

content_1 <- read_html("http://dataquestio.github.io/web-scraping-pages/simple_classes.html")

b_text <- content_1 %>%
  html_nodes("b") %>%
  html_text
b_text

# selectors: tag_name, .class_name, and #ID_name --------

content_2 <- read_html("http://dataquestio.github.io/web-scraping-pages/ids_and_classes.html")

first_outer_text <- content_2 %>%
  html_nodes("#second") %>%
  html_text()

first_items_text <- content_2 %>%
  html_nodes(".first-item") %>%
  html_text()

# varios selectores
super_bowl <- read_html("http://dataquestio.github.io/web-scraping-pages/2014_super_bowl.html")

# <!DOCTYPE html>
#   <html>
#   <head lang="en">
#   <meta charset="UTF-8">
#   <title>2014 Superbowl Team Stats</title>
#   </head>
#   <body>
#   
#   <table class="stats_table nav_table" id="team_stats">
#   <tbody>
#   <tr id="teams">
#   <th></th>
#   <th>SEA</th>
#   <th>NWE</th>
#   </tr>
#   <tr id="first-downs">
#   <td>First downs</td>
#   <td>20</td>
#   <td>25</td>
#   </tr>
#   <tr id="total-yards">
#   <td>Total yards</td>
#   <td>396</td>
#   <td>377</td>
#   </tr>
#   <tr id="turnovers">
#   <td>Turnovers</td>
#   <td>1</td>
#   <td>2</td>
#   </tr>
#   <tr id="penalties">
#   <td>Penalties-yards</td>
#   <td>7-70</td>
#   <td>5-36</td>
#   </tr>
#   <tr id="total-plays">
#   <td>Total Plays</td>
#   <td>53</td>
#   <td>72</td>
#   </tr>
#   <tr id="time-of-possession">
#   <td>Time of Possession</td>
#   <td>26:14</td>
#   <td>33:46</td>
#   </tr>
#   </tbody>
#   </table>
#   
#   </body>
#   </html>


total_plays_count <- super_bowl %>%
  html_nodes("#total-plays td") %>%
  html_text()

patriots_total_plays_count <- total_plays_count[3]

total_yards_count <- super_bowl %>%
  html_nodes("#total-yards td") %>%
  html_text()

seahawks_total_yards_count <- total_yards_count[2]

# buscar por posicion: :nth-child(3) ------

content_3 <- read_html("http://dataquestio.github.io/web-scraping-pages/2014_super_bowl.html")

patriots_total_plays_count <- content_3 %>% 
  html_nodes("#total-plays td:nth-child(3)") %>%
  html_text()

patriots_total_plays_count <- content_3 %>% 
  html_nodes("#total-plays") %>%
  html_nodes("td:nth-child(3)") %>%
  html_text()

# sacar tabla como df y luego indexar por columna
table_df <- content_3 %>%
  html_node("table") %>% 
  html_table()

nwe_vector <- table_df$NWE

# Scraping de selectores complejos
content_hot_100 <- read_html("https://www.billboard.com/charts/hot-100/2020-01-04")

hot_100_week_on_chart <- content_hot_100 %>% 
  html_nodes(".color--secondary .text--week") %>% 
  html_text() %>% 
  head(10)

hot_100_top_10_songs <- content_hot_100 %>%
  html_nodes(".chart-element__information .color--primary") %>%
  html_text() %>%
  head(10)

prueba <- content_hot_100 %>% 
  html_nodes(".chart-element__information__song") %>% 
  html_text() %>% 
  head(10)

# library(rvest)
# library(dplyr)
# 
# content <- read_html("the web page URL")
# 
# text <- content %>% 
#   html_nodes("the right selector") %>%
#   html_text()

library(rvest)
library(dplyr)

scraper <- function(url, selector, output="text", all_nodes=TRUE){
  content <- read_html(url)
  
  if (all_nodes) {
    nodes <- content %>% 
      html_nodes(selector) #extrae todas las apariciones
  } else {
    nodes <- content %>% 
      html_node(selector) #extrae solo la primera aparicion
  }
  
  if (output == "text"){
    result <-  nodes %>% html_text()
  } else if (output == "table"){
    result <-  nodes %>% html_table()
  } else if (output == "attrs"){
    result <- nodes %>% html_attrs()
  } else {result <- nodes %>% html_attr(output) #tenemos que colocar output como parametro para html_attr
  } 
  
  result
}

prueba <- scraper(url = "http://dataquestio.github.io/web-scraping-pages/2014_super_bowl.html", selector = "table tr:nth-child(3) td")
prueba


# Ejercicio de Accuweather con función ----------
url <- "http://dataquestio.github.io/web-scraping-pages/Brussels_Belgium_Weather_AccuWeather.html"
content <- read_html(url)
temperatures <- scraper(url, selector = ".half-day-card-header .temperature")
belgium_temperatures <- readr::parse_number(temperatures)
belgium_temperatures

# Ejercicio de Accuweather sin función
temperatures <- content %>%
  html_nodes(".half-day-card-header .temperature") %>%
  html_text()
belgium_temperatures <- readr::parse_number(temperatures)

# Wikipedia Earth ------------
url_earth <- "http://dataquestio.github.io/web-scraping-pages/Earth-Wiki.html"
content <- read_html(url_earth)

infobox <- scraper(url_earth, selector = ".infobox td")
infobox

campos <- content %>% 
  html_nodes(".infobox th") %>% 
  html_text()

valores <- content %>% 
  html_nodes(".infobox td") %>% 
  html_text()

p1 <- data.frame(campos = campos, valores = valores[-1]) # la primera es el pie de foto
View(p1)
  


# My solution
url_earth <- "http://dataquestio.github.io/web-scraping-pages/Earth-Wiki.html"

values <- scraper(url_earth, selector = ".infobox td")
value <- values[17]

radius <- value %>% 
  stringr::str_match(., "(\\d+\\.\\d+)\\s*km")

earth_mean_radius <- radius[,2] %>% 
  as.numeric()

# Dataquest solution
wiki_infobox <- scraper(url = "http://dataquestio.github.io/web-scraping-pages/Earth-Wiki.html", 
                        selector = ".infobox")
earth_mean_radius_matches <- stringr::str_match(wiki_infobox, "Mean radius(\\d+\\.\\d+)\\s*km")
earth_mean_radius <- as.numeric(earth_mean_radius_matches[,2])

# Stack overflow scraping -------------

st_ov <- "http://dataquestio.github.io/web-scraping-pages/WebSraping-ethics-SE.html"

st_ov <- "http://dataquestio.github.io/web-scraping-pages/WebSraping-ethics-SE.html"

accepted_message <- scraper(st_ov, selector = ".accepted-answer .s-prose", all_nodes = FALSE)

accepted_message_author <- scraper(st_ov, selector = ".accepted-answer .user-details a", all_nodes = FALSE)


# Wordometer scraping ---------------

wo <- "http://dataquestio.github.io/web-scraping-pages/Worldometer-Population.html"
content <- read_html(wo)

tb <- content %>% 
  html_node("table") %>% 
  html_table()

library(ggplot2)

tb %>% 
  filter(Year>= 1950 & Year < 2020) %>% 
  mutate(YearlyChange = readr::parse_number(YearlyChange)) %>% 
  ggplot(aes(x = Year, y = YearlyChange, group = 1)) +
  geom_line() + geom_point(size = 2) +
  theme_bw() +
  ylab("Yearly Change")

# Dataquest solution
world_population_df <- scraper(url = "http://dataquestio.github.io/web-scraping-pages/Worldometer-Population.html", 
                               selector = "table", 
                               output = "table", 
                               all_nodes = F)

world_population_df_1950_2019 <- world_population_df %>% 
  mutate(YearlyChange = readr::parse_number(YearlyChange) ) %>%
  filter(Year >= 1950 & Year < 2020)

library(ggplot2)
ggplot(data = world_population_df_1950_2019,
       aes(x = Year, y = YearlyChange, group = 1)) + 
  geom_line() + 
  geom_point(size = 2) +
  theme_bw() +
  theme() +  
  ylab("Yearly Change")

# Scraping images ------------
url <- "http://dataquestio.github.io/web-scraping-pages/The%20Hot%20100%20Chart%20_%20Billboard.html"
url_pattern <- "(?i)http[s]?://(?:[a-z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-f][0-9a-f]))+\\.jpg"
prueba <- scraper(url, selector = ".chart-element__image", output = "attrs")
hot_5_img_url <- stringr::str_match(head(prueba, 5), url_pattern) %>% as.vector()

# Dataquest solution
hot_100_styledata <- scraper(url = "http://dataquestio.github.io/web-scraping-pages/The%20Hot%20100%20Chart%20_%20Billboard.html", 
                             selector = ".chart-element__image", 
                             output = "style")
hot_100_styledata_top5 <- head(hot_100_styledata, 5)

hot_5_img_url <- stringr::str_extract(
  hot_100_styledata_top5, 
  url_pattern)


prueba <- scraper(url, 
                  selector = ".chart-page", 
                  output = "attrs"
                  )
p <- unlist(prueba)
df_p <- data.frame(unlist(p))
View(df_p)



