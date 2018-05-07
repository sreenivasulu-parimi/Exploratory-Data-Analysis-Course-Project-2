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

                                    # Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering
# this question.

# Emissions in Baltimore City
baltimore_emissions  <- NEI[NEI$fips=="24510", ]

# Total emissions in Baltimore City by year
total_emissions_baltimore_per_year <- aggregate(Emissions ~ year, baltimore_emissions, sum)

png('plot2.png')
barplot(height=total_emissions_baltimore_per_year$Emissions, names.arg=total_emissions_baltimore_per_year$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'), main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'), col = c("red", "green", "blue", "yellow"))
dev.off()
