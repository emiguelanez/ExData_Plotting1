library(sqldf)
# Getting data between two specific dates
dataset <- read.csv.sql("data/household_power_consumption.txt", header=TRUE, sep=";",sql="select * from file where Date == '1/2/2007' OR Date == '2/2/2007'")
closeAllConnections()
dataset$Date <- gsub("20","",dataset$Date)
x <- paste(dataset$Date, dataset$Time)
dataset$Time <- strptime(x,format="%d/%m/%y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, format="%m/%d/%y")
# Reproduce plot
with(dataset, plot(Time,Sub_metering_1,xlab = "",ylab = "Energy sub metering",type = "l"))
with(dataset, points(Time,Sub_metering_2,type = "l",col="red"))
with(dataset, points(Time,Sub_metering_3,type = "l",col="blue"))
legend("topright", pch="-", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
# Create plot file
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file. By default, the graphs are 480x480 pixels in size
dev.off()