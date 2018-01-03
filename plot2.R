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
#Plot 2 code 
#####################
datetime <- paste(data1$Date, data1$Time)
data1$datetime <- as.POSIXct(datetime)

png (filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data1$Global_active_power ~ data1$datetime, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

