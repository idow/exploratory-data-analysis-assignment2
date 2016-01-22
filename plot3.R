# open a png device
png(filename = "Plot3.png")

library(ggplot2)

#read the file
NEI <- readRDS("summarySCC_PM25.rds")

# select only the rows for baltimore
subNEI <- select(filter(NEI, fips == "24510"), Emissions, year, type)

# build the graph
balG <- ggplot(subNEI, aes(year, Emissions))
balG + geom_point(alpha = 0.3) + facet_grid(type~.) + theme_bw()

# close device to create the png file
dev.off()
