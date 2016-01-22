# open a png device
png(filename = "Plot5.png")

library(dplyr)
# read the files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# paste all the columns that describe the data and filter them on "Motor" and "Vehicle"
SCC$paste <- paste(SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, SCC$SCC.Level.Four)
filtSCC <- filter(SCC, grepl("Motor", SCC$paste) & grepl("Vehicle" , SCC$paste))

# select the rows that are data from Baltimore
subNEI <- select(filter(NEI, fips == "24510"), SCC, Emissions, year)

# merge the data based on the SCC number, which will select only the common rows from both data frames
mergeData <- merge(filtSCC, subNEI, by = "SCC")

# plot the total emissions in Baltimore by year
plot(mergeData %>% group_by(year) %>% summarise(Total = sum(Emissions)), 
     ylab = "emissions from motor vehicle sources in Baltimore City", type = "l", lwd = 5)

# close device to create the png file
dev.off()