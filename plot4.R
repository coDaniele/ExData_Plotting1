## Johns Hopkins Data Science Course on Coursera
#  Part 4 - Exploratory Data Analysis

## Week 1 - Course Assignment 1 - Plots
#  Plot 4

if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "exdata-data-household_power_consumption.zip", method="curl")
    unzip("exdata-data-household_power_consumption.zip")
} #Download dataset in working directory and Unzip.

## Read in txt file for range containing the desired dates (Feb 1-2 2007);
#  As there are ~46 days (66636 minutes) from Dec 16 2006 to be skipped,
#  And as those two days are 2880 minutes
household <- read.table("household_power_consumption.txt", header = TRUE, 
                        sep = ";", nrows = 2880, skip = 66636, 
                        stringsAsFactors=FALSE)

# To get the colnames
hhnames <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", nrows = 1, stringsAsFactors=FALSE)
names(household) <- names(hhnames)

# Date/Time conversion and adding it to the data
Datetime <- strptime(paste(household[,1], household[,2]), "%d/%m/%Y %H:%M:%S")
hh <- cbind(household, Datetime)

## Make Plot 4
par(mfrow = c(2,2), cex = 0.7)

#subpart 1, topleft
plot(hh$Datetime, hh$Global_active_power, pch=".", xlab="", 
     ylab="Global Active Power")
lines(hh$Datetime, hh$Global_active_power, lwd=1)

#subpart 2, topright
plot(hh$Datetime, hh$Voltage, pch=".", xlab="datetime", 
     ylab="Voltage")
lines(hh$Datetime, hh$Voltage, lwd = 1)

#subpart 3, bottomleft
plot(hh$Datetime, hh$Sub_metering_1, pch=".", xlab="", 
     ylab="Energy sub metering")
lines(hh$Datetime, hh$Sub_metering_1, lwd=1)
lines(hh$Datetime, hh$Sub_metering_2, col="Red")
lines(hh$Datetime, hh$Sub_metering_3, col="Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("Black", "Red", "Blue"), lwd = c(1,1,1), bty = "n", y.intersp=0.35, cex = 0.9, 
       yjust=0.5, text.width = strwidth("Sub_metering_1  "), inset = c(0.02,-0.05))

#subpart 4, bottomright
plot(hh$Datetime, hh$Global_reactive_power, pch=".", xlab="datetime", 
     ylab="Global_reactive_power")
lines(hh$Datetime, hh$Global_reactive_power, lwd=1)

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()  #Copy to png file and close connection
