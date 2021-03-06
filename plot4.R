library(dplyr)
library(lubridate)
library(readr)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data.zip", method = "curl")
unzip("./data.zip")

myData <- read_delim("./household_power_consumption.txt", ";" ,na = "?", )
myData$Date <- parse_date(myData$Date, "%d/%m/%Y")
myData <- filter(myData, Date >= "2007-02-01", Date <="2007-02-02")
myData <- mutate(myData, DateTime = ymd_hms(paste(Date, Time)))


png(filename = "plot4.png")
par(mfrow = c(2,2))
## plot 1
with(myData, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))

## plot 2
with(myData, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

## plot 3
plot(myData$DateTime, myData$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
with(myData, lines(DateTime, Sub_metering_1, xlab = "", ylab = ""))
with(myData, lines(DateTime, Sub_metering_2, xlab = "", ylab = "", col = "red"))
with(myData, lines(DateTime, Sub_metering_3, xlab = "", ylab = "", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")

## plot 4
with(myData, plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l"))

dev.off()


