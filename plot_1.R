## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

png(file = "plot_1.png", bg = "transparent")
hist(power.data[,Global_active_power], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off();