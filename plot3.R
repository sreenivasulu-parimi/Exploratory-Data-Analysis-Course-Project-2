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

                                    # Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# Emissions in Baltimore City
baltimore_emissions  <- NEI[NEI$fips=="24510", ]

# Total emissions in Baltimore City by type and year
total_emissions_baltimore_per_year_type <- aggregate(Emissions ~ year + type, baltimore_emissions, sum)

png("plot3.png", width=640, height=480)
g <- ggplot(total_emissions_baltimore_per_year_type, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)
dev.off()
