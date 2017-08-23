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

##create the png file to display image. 
png("plot1.png", width = 480, height = 480, units = "px", bg = "transparent")

## plotting the histogram
hist(as.numeric(as.character(powerConsumptionFeb0102$Global_active_power)), col = "red",  main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

##must close the device!
dev.off()


