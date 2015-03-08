## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

plot(power.data[,DateTime], power.data[,Sub_metering_1], type = "line")