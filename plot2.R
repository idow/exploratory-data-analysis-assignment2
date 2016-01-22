# open a png device
png(filename = "Plot2.png")

# load dplyr library
library(dplyr)
#get the data into a variable
NEI <- readRDS("summarySCC_PM25.rds")
# subset only Emission and year columns for the city of Baltimore (fips = 24510)
subNEI <- select(filter(NEI, fips == "24510"), Emissions, year)
# plot the emissions grouped by the year
plot(subNEI %>% group_by(year) %>% summarise(Total = sum(Emissions)), ylab = "Sum of emmission", type = "l", lwd = 5)

# close device to create the png file
dev.off()