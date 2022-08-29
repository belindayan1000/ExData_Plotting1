library(lubridate)
library(tidyverse)
if(!dir.exists("data")) { dir.create("data") }

file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

colnames(data) <- data[1, ]
data <- data[-1, ]
date <- strptime(data$Date, format = "%d/%m/%Y")
date <- as.Date(date, format = "%m/%d/%y")
data$Date <- date
subdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
finaldata <- mutate(subdata, datetime = ymd_hms(paste(Date, Time)))
png("plot3.png", width = 480, height = 480)

plot(Sub_metering_1 ~ datetime, finaldata, type = 'l', xlab = NA, ylab = "Energy sub metering")
points(Sub_metering_2 ~ datetime, finaldata, type = 'l', xlab = NA, ylab = "Energy sub metering", col = "red")
points(Sub_metering_3 ~ datetime, finaldata, type = 'l', xlab=NA, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()