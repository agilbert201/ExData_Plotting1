## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

hist(power.data[,Global_active_power], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")