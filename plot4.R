library(sqldf)
# Getting data between two specific dates
dataset <- read.csv.sql("data/household_power_consumption.txt", header=TRUE, sep=";",sql="select * from file where Date == '1/2/2007' OR Date == '2/2/2007'")
closeAllConnections()
dataset$Date <- gsub("20","",dataset$Date)
x <- paste(dataset$Date, dataset$Time)
dataset$Time <- strptime(x,format="%d/%m/%y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, format="%m/%d/%y")
# Reproduce plot
par(mfrow=c(2, 2)) 
with(dataset, {
        plot(Time, Global_active_power, type="l", xlab="", ylab = "Global Active Power")
        plot(Time, Voltage, type="l", ylab = "Voltage",xlab="datetime") 
        plot(Time,Sub_metering_1,xlab = "", ylab = "Energy sub metering",type = "l")
        points(Time,Sub_metering_2,type = "l",col="red")
        points(Time,Sub_metering_3,type = "l",col="blue")
        legend("topright", pch="-", bty="n",col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        plot(Time, Global_reactive_power, type="l", ylab = "Global_reactive_power",xlab="datetime")         
})
# Create plot file
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file. By default, the graphs are 480x480 pixels in size
dev.off()