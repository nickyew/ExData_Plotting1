library(dplyr)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "data.zip"

if (!file.exists(zipfile)) {
    download.file(url, zipfile, mode = "wb")
}

filename = "household_power_consumption.txt"

if (!file.exists(filename)) {
    unzip(zipfile)
}

data <- read.csv(filename, sep=";", stringsAsFactors = FALSE)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data1 <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

data1 <- data1[complete.cases(data1),]

#####################
#Plot 3 code
#####################

png (filename = "plot3.png", width = 480, height = 480, units = "px")
with(data1, { 
    plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ datetime, col = 'Red')
    lines(Sub_metering_3 ~ datetime, col = 'Blue')
})

legend("topright", col = c("Black", "Red", "Blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()