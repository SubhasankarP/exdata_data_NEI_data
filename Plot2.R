# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')

# Get the emissions in Baltimore City
baltimore.emissions.df = NEI[NEI$fips == '24510', ]

# Get the total emissions in Baltimore City by year
baltimore.emission.totals.by.year <- aggregate(Emissions ~ year, data = baltimore.emissions.df, FUN = sum)

# Open png device
png(filename='plot2.png')

barplot(height=baltimore.emission.totals.by.year$Emissions/1000, names.arg=baltimore.emission.totals.by.year$year,xlab="years",
        ylab=expression('Total PM'[2.5]*' emission in kilotons'),ylim=c(0,4),
        main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'))

# Close png device
dev.off()