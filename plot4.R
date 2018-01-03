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
#Plot 4 code
#####################

png (filename = "plot4.png", width = 480, height = 480, units = "px")
# set 2 cols 2 rows
par(mfrow = c(2,2)) 

#Plot 4-1
plot(data1$Global_active_power ~ data1$datetime, type = "l", ylab="Global Active Power (kilowatts)", xlab="")

#Plot 4-2
with(data1, {
    plot(Voltage ~ datetime, type = "l", ylab = "Voltage", xlab = "datetime")
})

#Plot 4-3
with(data1, {
    plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ datetime, col = 'Red')
    lines(Sub_metering_3 ~ datetime, col = 'Blue') 
})

#Plot 4-4
with(data1, {
    plot(Global_reactive_power ~ datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()