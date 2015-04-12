## Johns Hopkins Data Science Course on Coursera
#  Part 4 - Exploratory Data Analysis

## Week 1 - Course Assignment 1 - Plots
#  Plot 3

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

## Make Plot 3
par(mfrow = c(1,1), cex = 0.8)
plot(hh$Datetime, hh$Sub_metering_1, pch=".", xlab="", 
     ylab="Energy sub metering")
lines(hh$Datetime, hh$Sub_metering_1, lwd=1)
lines(hh$Datetime, hh$Sub_metering_2, col="Red")
lines(hh$Datetime, hh$Sub_metering_3, col="Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("Black", "Red", "Blue"), lwd = c(1,1,1),
       text.width=strwidth("Sub_metering_1   "), y.intersp = 0.5)

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()  #Copy to png file and close connection
