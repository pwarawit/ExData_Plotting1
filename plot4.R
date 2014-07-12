plot4 <- function(){
    # plot4.R 
    # written by PanaEk Warawit as part of Exploratory Data Analysis 
    # class project on July 12, 2014
    
    # Check if the text file exist, if not - download the zip file and unzip it
    zip_filename <- "exdata-data-household_power_consumption.zip"
    txt_filename <- "household_power_consumption.txt"
    if (!file.exists(txt_filename)){
        # Text file does not exist - check if zip file exists
        if (!file.exists(zip_filename)){
            # print ("No zip file, need to both download and unzip")
            fileurl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
            download.file(fileurl,zip_filename)
            unzip(zip_filename)
        } else {
            # print ("Zip file exists, but not text file, just need to unzip")
            unzip(zip_filename)
        }
    } 
    
    # Load data into table
    full_data <- read.table(txt_filename, header=TRUE, sep=";", dec=".", na.string="?")
    
    # Subset only data between 2007-02-01 and 2007-02-02 into data object
    data <- full_data[with(full_data, Date=="1/2/2007"|Date=="2/2/2007"), ]
    
    # Convert date & time to date/time variable
    data$Date <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%s")
    #data
    
    # This is the plot into PNG file
    png(filename = "plot4.png", width = 480, height = 480)
    
    # Setup multiple plot canvas as 2x2 grid, columnwise
    par(mfcol = c(2,2))
    
    # Plot sub plot#1 - same as plot2.R
    plot(data$Date, data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
    
    # Plot sub plot#2 - same as plot3.R
    plot(data$Date, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
    lines(data$Date, data$Sub_metering_1, col="black")
    lines(data$Date, data$Sub_metering_2, col="red")
    lines(data$Date, data$Sub_metering_3, col="blue")
    legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # Plot sub plot#3 
    plot(data$Date, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    # Plot sub plot#4
    plot(data$Date, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    dev.off()
    
}
