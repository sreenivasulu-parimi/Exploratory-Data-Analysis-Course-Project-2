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

                                    # Question 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(ggplot2)

# Get all ON-ROAD type in NEI records with Baltimore
baltimore_onroad  <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]


# Total coal emissions by year
total_emissions_year_baltimore_onroad <- aggregate(Emissions ~ year, baltimore_onroad, sum)

png("plot5.png", width=480, height=480)
g <- ggplot(total_emissions_year_baltimore_onroad, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", width = 0.75) + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()