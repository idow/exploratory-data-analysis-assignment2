# open a png device
png(filename = "Plot1.png")
# load dplyr library
library(dplyr)
#get the data into a variable
NEI <- readRDS("summarySCC_PM25.rds")
# subset only the required colums
subNEI <- select(NEI, Emissions, year)
# plot the sum of Emissions after grouping by the year
plot(subNEI %>% group_by(year) %>% summarise(Total = sum(Emissions)), ylab = "Sum of emmission", lwd = 5)

# close device to create the png file
dev.off()
