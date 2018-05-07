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

                                          # Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library(ggplot2)

# Merge the two data sets 
if(!exists("NEISCC")){
      NEISCC <- merge(NEI, SCC, by="SCC")
}

# Get all NEIxSCC records with Short.Name (SCC) Coal
coal_matches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
coal_matches <- NEISCC[coal_matches, ]

# Total coal emissions by year
total_emissions_year_coal <- aggregate(Emissions ~ year, coal_matches, sum)

png("plot4.png", width=480, height=640)
g <- ggplot(total_emissions_year_coal, aes(factor(year), Emissions/10^5))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()