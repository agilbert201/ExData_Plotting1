## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

plot(power.data[,DateTime], power.data[,Global_active_power], ylab = "Global Active Power (kilowatts)", xlab = "", type = "l", xaxt = "n")

# Build x axis using min, median, max datetime and then computing it's "day of week" name
axis.points = c(min(power.data$DateTime), median(power.data$DateTime), max(power.data$DateTime))
axis.labels = weekdays(as.POSIXlt(axis.points, origin=as.Date("1970-01-01"), tz = "GMT"), abbreviate = TRUE)
axis(1, axis.points, axis.labels)
