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
png("plot2.png", width = 480, height = 480)
finaldata <- mutate(subdata, datetime = ymd_hms(paste(Date, Time)))

plot(Global_active_power ~ datetime, finaldata, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)
dev.off()