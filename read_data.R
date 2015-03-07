dataset.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset.zipfile <- file.path("data", "household_power_consumption.zip")
dataset.txtfile <- file.path("data", "household_power_consumption.txt")

init <- function() {
    ## Verifiy data dir exists and data set is present
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    if (!file.exists(dataset.zipfile)) {
        download.file(dataset.url, dataset.zipfile, method = "curl")
    }
    if (!file.exists(dataset.txtfile)) {
        unzip(dataset.zipfile, exdir = "data")
    }
}

tab5rows <- read.table(dataset.txtfile, header = TRUE, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)
dataset <- read.table(dataset.txtfile, header = TRUE, nrows = 2500000, sep = ";", colClasses = classes, na.strings = "?")
require(data.table)
power.table <- data.table(dataset)
power.data <- power.table[Date == "1/2/2007" | Date == "2/2/2007",]

# TODO make true datetime for data and time columns

#plot_1
hist(power.data[,Global_active_power], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#plot_2 - not right need true datetime for x axis
plot(power.data[,Time], power.data[,Global_active_power], type = "line")