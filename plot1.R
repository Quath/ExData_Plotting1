#####
#
# Making the histogram plot of Global Active power consumption
#
#####
library(lubridate)

# Download the file if it hasn't already been downloaded
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zipFileName <- '../Household_power_consumption.zip'
fileName <- 'household_power_consumption.txt'
if (!file.exists(fileName)) {
    download.file(fileUrl, zipFileName)
    unzip(zipFileName, fileName)
}

# Estimated size:
size_estimate <- 2e6 * 10 * 8
colClasses <- c('character', 'character', rep('numeric', 7))
df <- read.csv(fileName, sep=";",
               stringsAsFactors=FALSE,
               colClasses = colClasses,
               na.strings='?'
               )

df2 <- subset(df, dmy(df$Date) >= ymd('2007-02-01') & dmy(df$Date) <= ymd('2007-02-02'))

# Remove big thing for memory
rm(df)

# And plot
dev.new(width=480, height=480, unit="px")
hist(df2$Global_active_power, 
     col='red', 
     main="Global Active Power", 
     xlab="Global Active Power (in kiloWatt)"
     )

dev.copy(png, file="plot1.png")
dev.off()



    