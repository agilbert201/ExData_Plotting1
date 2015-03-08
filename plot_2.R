## Generate Histogram for Global Active Power

source("read_data")

# Get Data Set
Setup();
power.data <- GetPowerData();

plot(power.data[,Time], power.data[,Global_active_power], type = "line")