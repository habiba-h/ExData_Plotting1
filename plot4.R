library(lubridate)

##check if the data is available in the working directory. If not, download and unzip it.
if(!file.exists("household_power_consumption.txt")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip", method = "curl")
    unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

## reading data in R
fileName <- "household_power_consumption.txt"
powerConsumptionDS <- read.table(fileName, sep = ";", header = TRUE)

##subsetting the date from February 01 and 02, 2007.
powerConsumptionFeb0102 <- powerConsumptionDS[powerConsumptionDS$Date == "1/2/2007" | powerConsumptionDS$Date == "2/2/2007" ,]

##adding a date + time combined column
powerConsumptionFeb0102$date_time <- with(powerConsumptionFeb0102, dmy(Date) + hms(Time))

## converting the relevant attributes to numeric which aren't already of type numeric. It gets read as factor when the entire data is read as R cannot resolve the data type automatically due to '?' for missing values.
powerConsumptionFeb0102$Global_active_power = as.numeric(as.character(powerConsumptionFeb0102$Global_active_power))
powerConsumptionFeb0102$Sub_metering_1 = as.numeric(as.character(powerConsumptionFeb0102$Sub_metering_1))
powerConsumptionFeb0102$Sub_metering_2 = as.numeric(as.character(powerConsumptionFeb0102$Sub_metering_2))
powerConsumptionFeb0102$Sub_metering_3 = as.numeric(as.character(powerConsumptionFeb0102$Sub_metering_3))
powerConsumptionFeb0102$Voltage = as.numeric(as.character(powerConsumptionFeb0102$Voltage))
powerConsumptionFeb0102$Global_reactive_power = as.numeric(as.character(powerConsumptionFeb0102$Global_reactive_power))

##create the png file to display image. 
png("plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

##setting up the environment
par(mfrow = c(2,2))

## plot global active power VS date+time graph
with (powerConsumptionFeb0102, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") )

## plot voltage vs datetime
with (powerConsumptionFeb0102, plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime") )

## plot all sub meterings vs date + time
with (powerConsumptionFeb0102, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black"))
lines(powerConsumptionFeb0102$date_time,powerConsumptionFeb0102$Sub_metering_2, col = "red")
lines(powerConsumptionFeb0102$date_time, powerConsumptionFeb0102$Sub_metering_3, col = "blue")
legend("topright", bty = "n",  lty = 1, cex = 0.75,  col = c("black", "red", "blue"),legend = c(names(powerConsumptionFeb0102)[7:9]))

## plot global reactive power vs datetime
with (powerConsumptionFeb0102, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime") )


##must close the device!
dev.off()
