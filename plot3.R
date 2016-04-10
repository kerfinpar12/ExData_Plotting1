# Read data unzip and save file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "household", method = "curl")

household <- unzip("household")

data <- read.table("household_power_consumption.txt", header = T, sep =";", stringsAsFactors = F)

# Set Date column class and filter for Feb 1 and Feb 2, 2007.
data$Date <- strptime(data$Date, "%d/%m/%Y")
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

#Time will need an associated year, month and date
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%Y-%m-%d %H:%M:%S")

#Set other column classes
str(data)
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])

#Plot 3

png(filename = "plot3.png", width = 480, height = 480)
plot3 <- plot(data$Time, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(data$Time, data$Sub_metering_2, type="l", col="red")
points(data$Time, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1), col = c("black", "red", "blue"))
dev.off()

