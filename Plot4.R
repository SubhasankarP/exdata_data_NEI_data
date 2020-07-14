# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')

# Use the 'Short.Name' field to find the coal combustion-related sources
scc.coal.df <- SCC[grep('coal', SCC$Short.Name), ]

# Get the emissions from coal combustion-related sources
combustion.coal.sources <- NEI[NEI$SCC %in% scc.coal.df$SCC, ]
# Get the total emissions from coal combustion-related sources by year
emissions.coal.related <- aggregate(Emissions ~ year, data = combustion.coal.sources, FUN = sum)

# Open png device
png(filename='plot4.png')

library(ggplot2)

ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
  geom_bar(stat="identity") +
  #geom_bar(position = 'dodge')+
  # facet_grid(. ~ year) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
  ggtitle("Emissions from coal combustion-related sources in kilotons")

# Close png device
dev.off()