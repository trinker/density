##       month type       lon      lat fish
## 1  Februray fyke -33.75738 150.6152   10
## 2  Februray fyke -33.75835 150.6159   50
## 3  Februray boat -33.75829 150.6158   60
## 4  Februray boat -33.75762 150.6170  600
## 5  Februray boat -33.75772 150.6160   80
## 6       May boat -33.75770 150.6176   10
## 7       May boat -33.75663 150.6163    5
## 8       May boat -33.75799 150.6154    0
## 9       May boat -33.75785 150.6152  400
## 10      May fyke -33.75762 150.6154  253

p_load(ggplot2, ggmap)

fishdata <- 
structure(list(month = structure(c(1L, 1L, 1L, 1L, 1L, 2L, 2L, 
2L, 2L, 2L), .Label = c("Februray", "May"), class = "factor"), 
    type = structure(c(2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L
    ), .Label = c("boat", "fyke"), class = "factor"), lon = c(-33.757383, 
    -33.758351, -33.758289, -33.757617, -33.757716, -33.757701, 
    -33.756632, -33.757987, -33.757852, -33.757621), lat = c(150.615201, 
    150.615924, 150.615834, 150.617043, 150.615991, 150.617555, 
    150.616306, 150.615429, 150.615222, 150.61541), fish = c(10L, 
    50L, 60L, 600L, 80L, 10L, 5L, 0L, 400L, 253L)), .Names = c("month", 
"type", "lon", "lat", "fish"), class = "data.frame", row.names = c(NA, 
-10L))


fishdata2 <- with(fishdata, fishdata[rep(1:nrow(fishdata), fish), ])
glenMap <- qmap(
    "glenbrook lagoon, australia", 
    maptype="satellite", zoom=17, 
    legend="topleft", 
    base_layer = ggplot(aes(x=lat, y=lon), data = fishdata2))

glenMap + geom_point(aes(colour=type))


glenMap2 <- glenMap + stat_density2d(aes(fill=..level.., alpha=..level..), 
    size=2, bins=8, geom="polygon")+
    scale_fill_gradient(low = "yellow", high = "orange", name="Density") +
    scale_alpha(range = c(0.2, 0.7), guide = FALSE) +
    geom_density2d(colour="black") +
    guides(alpha=FALSE) +
    geom_point(aes(colour=type), data=fishdata) + 
    scale_colour_hue(l=40, name="Identification\nType") 


glenMap2
ggsave("density.png")

glenMap2 + facet_wrap(~ month) 
ggsave("density2.png", width=14, height=7)

