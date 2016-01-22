# open a png device
png(filename = "Plot4.png")

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subSCC <- select(SCC, SCC, EI.Sector)
subNEI <- select(NEI, SCC, Emissions, year)

filtSCC <- filter(subSCC, grepl("Coal", subSCC$EI.Sector) & grepl("Comb" , subSCC$EI.Sector))
mergeData <- merge(filtSCC, subNEI, by = "SCC")

plot(mergeData %>% group_by(year) %>% summarise(Total = sum(Emissions)), 
     ylab = "Sum of coal combustion emmission", type = "l", lwd = 5)

# close device to create the png file
dev.off()