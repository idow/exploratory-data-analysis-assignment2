# open a png device
png(filename = "Plot6.png")

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# paste all the columns that describe the data and filter them on "Motor" and "Vehicle"
SCC$paste <- paste(SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, SCC$SCC.Level.Four)
filtSCC <- filter(SCC, grepl("Motor", SCC$paste) & grepl("Vehicle" , SCC$paste))

# select the rows that are data from Baltimore and from LA
subNEIbaltimore <- select(filter(NEI, fips == "24510"), SCC, Emissions, year)
subNEIla <- select(filter(NEI, fips == "06037"), SCC, Emissions, year)

# merge the data based on the SCC number, which will select only the common rows from each city data frames
mergeBal <- merge(subNEIbaltimore, filtSCC, by = "SCC")
mergeLA <- merge(subNEIla, filtSCC, by = "SCC")

# plot the total emissions in Baltimore by year. the Y axis has to defined so it will be able to include both Baltimore and LA
plot(mergeBal %>% group_by(year) %>% summarise(Total = sum(Emissions)), 
     ylab = "emissions from motor vehicle sources in Baltimore City and LA" , type = "l", lwd = 5, ylim=c(0, 100))

# add the line for LA
lines(mergeLA %>% group_by(year) %>% summarise(Total = sum(Emissions)), col = "blue", lwd = 5)

#add Legend
legend("center", lwd = 5, legend = c("Baltimore", "LA"), col = c("black", "blue"))

# close device to create the png file
dev.off()