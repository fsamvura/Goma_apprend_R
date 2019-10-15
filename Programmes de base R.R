# Save a single object to a file
saveRDS(Etudiants, "F:/MyFiles/R/data and programs/Data/Etudiants.rds")
mwalimu<-readRDS("F:/MyFiles/R/data and programs/Data/Etudiants.rds")


#Créer des fonctions 
simple_add <- function (a, b) {
  result <- a + b
  result
}
simple_add(2, 3)
simple_add(95, 46)

# Value table like formats in SAS
install.packages("spatstat")
library(spatstat)
cr <- lut(factor(c("Negative","low", "medium", "high")), breaks=c(-Inf, 0,5,10, Inf))

cr
cr(3.2)
cr(c(-2, 3, 5, 11, 20))
library(tidyverse)
install.packages("mapdata")
library(maps)
nz <- map_data("nz")
can <- map_data("can")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

library(maps)
library(mapdata)
install.packages("ggmap")
library(ggmap)
map("worldHires","Canada", xlim=c(-141,-53), ylim=c(40,85), col="gray90", fill=TRUE)
paris <- get_map(location = "paris")
str(paris)
qmap(baylor, zoom = 14, maptype = 53428, api_key = api_key,
     source = "cloudmade")
qmap("houston", zoom = 10, maptype = 58916, api_key = api_key,
     source = "cloudmade")

