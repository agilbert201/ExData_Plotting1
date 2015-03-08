require(data.table)

dataset.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset.zipfile <- file.path("data", "household_power_consumption.zip")
dataset.txtfile <- file.path("data", "household_power_consumption.txt")

Setup <- function() {
    ## Verifiy data dir exists and data set is present.
    
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

GetPowerData <- function () {
    ## Returns power data for graphing, just the two days 02/01/2007 and 02/02/2007.
    ## Assume Setup has been run, original data set is available locally in data dir.
    ## Normalizes Date and Time columns into a single DateTime column of type POSIXct.
    ##
    ## Returns:
    ##  A data.table with power data for the two days
    ##
    
    # First read 5 rows to get col classes, as makes the actual data read faster
    tab5rows <- read.table(dataset.txtfile, header = TRUE, nrows = 5, sep = ";")
    classes <- sapply(tab5rows, class)
    dataset <- read.table(dataset.txtfile, header = TRUE, nrows = 2500000, sep = ";", colClasses = classes, na.strings = "?")
    power.table <- data.table(dataset)
    # Constrain to 02/01/2007 and 02/02/2007
    power.table <- power.table[Date == "1/2/2007" | Date == "2/2/2007",]
    # Convert date and time cols to datetime
    dts <- power.table[,paste(as.character(Date), " ", as.character(Time))]
    datetimes <- lapply(dts, strptime, "%d/%m/%Y %H:%M:%S")
    datetimes <- sapply(datetimes, as.POSIXct)
    power.table <- power.table[,DateTime:=datetimes]
    power.table <- power.table[,Date:=NULL]
    power.table <- power.table[,Time:=NULL]
}
