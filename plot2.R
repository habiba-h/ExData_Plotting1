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

##subsetting the date from February 01 and 02, 2007
powerConsumptionFeb0102 <- powerConsumptionDS[powerConsumptionDS$Date == "1/2/2007" | powerConsumptionDS$Date == "2/2/2007" ,]


##adding a date + time combined column
powerConsumptionFeb0102$date_time <- with(powerConsumptionFeb0102, dmy(Date) + hms(Time))

## converting the global active power attribute to numeric. It gets read as factor when the entire data is read as R cannot resolve the data type automatically due to '?' for missing values.
powerConsumptionFeb0102$Global_active_power = as.numeric(as.character(powerConsumptionFeb0102$Global_active_power))

##create the png file to display image. 
png("plot2.png", width = 480, height = 480, units = "px", bg = "transparent")


## plot the graph
with (powerConsumptionFeb0102, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") )

##must close the device!
dev.off()

