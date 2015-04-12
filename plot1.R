## Johns Hopkins Data Science Course on Coursera
#  Part 4 - Exploratory Data Analysis

## Week 1 - Course Assignment 1 - Plots
#  Plot 1

if(!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "exdata-data-household_power_consumption.zip", method="curl")
    unzip("exdata-data-household_power_consumption.zip")
} #Download dataset in working directory and Unzip.

## Read in txt file for range containing the desired dates (Feb 1-2 2007);
#  As there are ~46 days (67056 minutes) from Dec 16 2006 to be skipped,
#  And as those two days are 2880 minutes
household <- read.table("household_power_consumption.txt", header = TRUE, 
                         sep = ";", nrows = 2880, skip = 66636, 
                         stringsAsFactors=FALSE)

# To get the colnames
hhnames <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", nrows = 1, stringsAsFactors=FALSE)
names(household) <- names(hhnames)

# Convert Date and Time into POSIX... and add to data
hh1 <- strptime(paste(household[,1], household[,2]), "%d/%m/%Y %H:%M:%S")
hh <- cbind(household, hh1)

## Make Plot 1
par(mfrow = c(1,1), cex = 0.8)
hist(hh$Global_active_power, col="red", main="Global active power", 
ylim=c(0,1200), xlab="Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()  #Copy to png file and close connection
