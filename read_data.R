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

#tab5rows <- read.table(dataset.txtfile, header = TRUE, nrows = 5, sep = ";")
#classes <- sapply(tab5rows, class)