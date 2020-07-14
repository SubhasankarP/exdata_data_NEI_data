# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')

# Get the emissions in Baltimore City
baltimore.emissions.df = NEI[NEI$fips == '24510', ]

# Get the total emissions in Baltimore, grouped by type and year
baltimore.emission.totals.df <- aggregate(Emissions ~ type + year, baltimore.emissions.df, FUN = sum)

# Open png device
png(filename='plot3.png')

library(ggplot2)

ggplot(baltimore.emission.totals.df, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  #geom_bar(position = 'dodge')+
  facet_grid(. ~ type) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))

# Close png device
dev.off()