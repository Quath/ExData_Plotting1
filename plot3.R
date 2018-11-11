#####
#
# Making the time vs sub metering
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
     df2$Sub_metering_1,
     'n',
     xlab="", 
     ylab="Energy Sub Metering"
)
lines(df2$FullDate, df2$Sub_metering_1, col="black")
lines(df2$FullDate, df2$Sub_metering_2, col="red")
lines(df2$FullDate, df2$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub metering 1", "sub metering 2", "sub metering 3"), 
       col=c("black", "red", "blue"), lty=1
       )
dev.copy(png, file="plot3.png")
dev.off()