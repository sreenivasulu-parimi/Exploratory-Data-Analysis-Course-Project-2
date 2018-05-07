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

                                    # Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.

# aggregate NEI emissions per year:
total_emissions_per_year <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=total_emissions_per_year$Emissions/10^6, names.arg=total_emissions_per_year$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'), main=expression('Total PM'[2.5]*' emissions at various years'), col = c("red", "green", "blue", "yellow"))
dev.off()
