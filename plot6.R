############################################################################################
##                Assignment: Exploratory Data Analysis - Course Project 2
############################################################################################

# Download and unzip the data in the current working directory:

filename <- "NEI_data.zip"

if (!file.exists(filename)) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(fileURL, filename, method="curl")
}


if (!file.exists("summarySCC_PM25.rds") && !file.exists("Source_Classification_Code.rds")) {
      unzip(filename)
}

# Read the Data Files in the current working directory:

# Read the national emissions data
if (file.exists("summarySCC_PM25.rds")) {
      NEI <- readRDS("summarySCC_PM25.rds")  
}

# Read the source code classification data
if (file.exists("Source_Classification_Code.rds")) {
      SCC <- readRDS("Source_Classification_Code.rds")  
}

                                          # Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips=="06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?
library(ggplot2)

# Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City (fips code: '24510') and Los Angeles (fips code: '06037')
fips_onroad  <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]


# Get the total emissions for Baltimore City and Los Angeles, grouped by year and city
total_emissions_year_fips <- aggregate(Emissions ~ year + fips, fips_onroad, sum)
total_emissions_year_fips$fips[total_emissions_year_fips$fips=="24510"] <- "Baltimore, MD"
total_emissions_year_fips$fips[total_emissions_year_fips$fips=="06037"] <- "Los Angeles, CA"

# Open png device
png("plot6.png", width=1040, height=480, units = "px")

g <- ggplot(total_emissions_year_fips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity", width = 0.75) + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()