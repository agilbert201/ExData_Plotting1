## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

ApplyDateAxis <- function() {
    # Build x axis using min, median, max datetime and then computing it's "day of week" name
    axis.points = c(min(power.data$DateTime), median(power.data$DateTime), max(power.data$DateTime))
    axis.labels = weekdays(as.POSIXlt(axis.points, origin=as.Date("1970-01-01"), tz = "GMT"), abbreviate = TRUE)
    axis(1, axis.points, axis.labels)
}

png(file = "plot_4.png", bg = "transparent")
par(mfrow = c(2, 2))
with (power.data, {
    # Graph 1
    plot(DateTime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l", xaxt = "n")
    ApplyDateAxis();
    
    # Graph 2
    plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l", xaxt = "n")
    ApplyDateAxis();

    # Graph 3
    # Ensure we have correct range of values for Y axis 
    yrange <- range(c(power.data$Sub_metering_1, power.data$Sub_metering_2, power.data$Sub_metering_3))
    plot(power.data[,DateTime], power.data[,Sub_metering_1], type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n", ylim=yrange)
    lines(power.data[,DateTime], power.data[,Sub_metering_2],type="l",col="red")
    lines(power.data[,DateTime], power.data[,Sub_metering_3],type="l",col="blue")    
    # Build legend
    legend.labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", legend = legend.labels, lty = 1, col = c("black", "red", "blue"))
    ApplyDateAxis();
    
    # Graph 4
    plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l", xaxt = "n")
    ApplyDateAxis();
})
dev.off()
