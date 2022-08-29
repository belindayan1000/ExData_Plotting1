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
subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
png("plot1.png", width = 480, height = 480)
graph <- hist(subdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()