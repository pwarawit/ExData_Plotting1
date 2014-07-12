plot1 <- function(){
    # plot1.R 
    # written by PanaEk Warawit as part of Exploratory Data Analysis 
    # class project on July 11, 2014

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
    full_data <- read.table(txt_filename, sep=";", header=TRUE)
        
    # Subset only data between 2007-02-01 and 2007-02-02 into data object
    begin_date <- as.Date("2007-02-01")
    end_date <- as.Date("2007-02-02")
    data <- full_data[(as.Date(full_data$Date,format="%d/%m/%Y") <= end_date & as.Date(full_data$Date,format="%d/%m/%Y") >= begin_date),]
    
    # Convert $Date into date value and $\
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")
    
    # This is the plot
    png(filename = "plot1.png", width = 480, height = 480)
    hist(as.numeric(data$Global_active_power)/500, main="Global Active Power", col="Red", xlab="Global Active Power (kilowatts)")
    dev.off()
}    