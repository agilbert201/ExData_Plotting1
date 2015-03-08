## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

# Ensure we have correct range of values for Y axis 
yrange <- range(c(power.data$Sub_metering_1, power.data$Sub_metering_2, power.data$Sub_metering_3))
plot(power.data[,DateTime], power.data[,Sub_metering_1], type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n", ylim=yrange)
lines(power.data[,DateTime], power.data[,Sub_metering_2],type="l",col="red")
lines(power.data[,DateTime], power.data[,Sub_metering_3],type="l",col="blue")

# Build legend
legend.labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = legend.labels, lty = 1, col = c("black", "red", "blue"))

# Build x axis using min, median, max datetime and then computing it's "day of week" name
axis.points = c(min(power.data$DateTime), median(power.data$DateTime), max(power.data$DateTime))
axis.labels = weekdays(as.POSIXlt(axis.points, origin=as.Date("1970-01-01"), tz = "GMT"), abbreviate = TRUE)
axis(1, axis.points, axis.labels)
