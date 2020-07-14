# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')

# Group total NEI emissions per year:
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

# Open png device
png(filename='plot1.png')

barplot(height=aggregatedTotalByYear$Emissions/1000, names.arg=aggregatedTotalByYear$year,xlab="years",
        ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
        main=expression('Total PM'[2.5]*' emissions at various years in kilotons'))

# Close png device
dev.off()