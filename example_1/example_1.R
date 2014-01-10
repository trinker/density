dataset <- structure(list(contesto = structure(1:21, .Label = c("M01", "M02", 
"M03", "M04", "M04a", "M05", "M06", "M08", "M09", "M10", "M11", 
"M12", "M13", "M14", "M15", "M16", "M17", "M18", "M19", "M20", 
"M21"), class = "factor"), x = c(81.37, 85.814, 73.204, 66.478, 
67.679, 59.632, 64.316, 90.258, 100.707, 89.829, 114.998, 119.922, 
129.17, 142.501, 76.206, 30.09, 130.731, 74.885, 48.823, 48.463, 
74.765), y = c(255.659, 242.688, 240.526, 227.916, 218.668, 239.325, 
252.777, 227.676, 217.828, 205.278, 216.747, 235.482, 239.205, 
229.717, 213.144, 166.785, 219.989, 192.336, 142.645, 186.361, 
205.698), perc = c(22, 16, 33, 46, 15, 35, 23, 45, 58, 53, 15, 
18, 36, 24, 24, 33, 56, 36, 32, 24, 16)), .Names = c("contesto", 
"x", "y", "perc"), row.names = c(NA, -21L), class = "data.frame")

dataset2 <- with(dataset, dataset[order(x, y), ])

library(ggplot2)
dataset3 <- with(dataset2, dataset2[rep(1:nrow(dataset2), perc),])
ggplot(dataset3, aes(x, y)) + 
    stat_density2d(aes(alpha=..level.., fill=..level..), size=2, bins=10, geom="polygon") + 
    scale_fill_gradient(low = "yellow", high = "red") +
    scale_alpha(range = c(0.00, 0.5), guide = FALSE) +
    geom_density2d(colour="black") +
    geom_point(data = dataset) +
    guides(alpha=FALSE)    

ggsave("dense3.png")


