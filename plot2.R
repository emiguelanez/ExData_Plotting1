library(sqldf)
# Getting data between two specific dates
dataset <- read.csv.sql("data/household_power_consumption.txt", header=TRUE, sep=";",sql="select * from file where Date == '1/2/2007' OR Date == '2/2/2007'")
closeAllConnections()
dataset$Date <- gsub("20","",dataset$Date)
x <- paste(dataset$Date, dataset$Time)
dataset$Time <- strptime(x,format="%d/%m/%y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, format="%m/%d/%y")
# Reproduce plot
plot(dataset$Time,dataset$Global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)",type = "l")
# Create plot file
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file. By default, the graphs are 480x480 pixels in size
dev.off()