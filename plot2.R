#####
#
# Making the time vs Global Active power consumption plot
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

# Add a full date column
df2 <- df2 %>% mutate(FullDate = dmy_hms(paste(df2$Date, df2$Time)))

dev.new(width=480, height=480, unit="px")
plot(df2$FullDate, 
     df2$Global_active_power,
     'n',
     xlab="", 
     ylab="Global Active Power (in kiloWatt)"
     )
lines(df2$FullDate, df2$Global_active_power)
dev.copy(png, file="plot2.png")
dev.off()

