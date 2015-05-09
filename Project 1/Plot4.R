## Surface laptop - setwd("C:/Users/Nathan/OneDrive/R/datasciencecoursera/Exploratory_Data_Analysis/Project 1")
library(dplyr)
library(plyr)
library(lubridate)

## Creates character classes to be read in by the read.csv command they are all character because
## its the easiest way to get R to correctly identify them later... numeric didn't work.

clss <- c("character","character", "character", "character", "character", "character", 
          "character", "character", "character")

## Reads in csv file with semi-colon separators from row 66637 for 2880 rows
power <- read.csv2("./data/household_power_consumption.txt", skip = 66637, nrows = 2880, 
                   header = FALSE, colClasses = clss)
     str(power)

## Names each column 
power_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
     colnames(power) <- power_names
     head(power)
     str(power)

## Redifines each column as the correct class of variable
          power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
          power$Global_active_power <- as.numeric(power$Global_active_power)
          power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
          power$Voltage <- as.numeric(power$Voltage)
          power$Global_intensity <- as.numeric(power$Global_intensity)
          power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
          power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
          power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
               pwr <- mutate(power, cdate = as.POSIXct(paste(power$Date, power$Time), format="%Y-%m-%d %H:%M:%S"))
               pwr$cdate[1:24]
               pwr$cdate[2857:2880]
               str(pwr) 
               head(pwr)
          

## Creates a 2x2 matrix of plots with defined margins
     par(mfrow= c(2,2), mar = c(4,4,2,2))

     ## Plot in the top left
          plot(pwr$cdate, pwr$Global_active_power, type = "n", xlab = "",
               ylab ="Global Active Power")
          lines(pwr$cdate, pwr$Global_active_power)
     ## Plot in the top right
          plot(pwr$cdate, pwr$Voltage, type = "n", xlab = "datetime",  ylab ="Voltage")
          lines(pwr$cdate, pwr$Voltage)
     ## Plot in the bottom left
          plot(pwr$cdate, power$Sub_metering_1, type = "n", xlab = "", ylab ="Energy sub metering")
               lines(pwr$cdate, power$Sub_metering_1)
               lines(pwr$cdate, power$Sub_metering_2, col = "red")
               lines(pwr$cdate, power$Sub_metering_3, col = "blue")
                    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                           col = c("black", "red", "blue"), lwd = 2, bty = "n")
     ## Plot in the bottom right
          plot(pwr$cdate, power$Global_reactive_power, type = "n", xlab = "datetime",  
               ylab = "Global_reactive_power")
          lines(pwr$cdate, power$Global_reactive_power)

## Prints a png with the histogram that was built above.
     png(filename = "Plot4.png", width = 480, height = 480, units = "px")
     par(mfrow= c(2,2), mar = c(4,4,2,2))
     
     ## Plot in the top left
          plot(pwr$cdate, pwr$Global_active_power, type = "n", xlab = "",
               ylab ="Global Active Power")
          lines(pwr$cdate, pwr$Global_active_power)
     ## Plot in the top right
          plot(pwr$cdate, pwr$Voltage, type = "n", xlab = "datetime",  ylab ="Voltage")
          lines(pwr$cdate, pwr$Voltage)
     ## Plot in the bottom left
          plot(pwr$cdate, power$Sub_metering_1, type = "n", xlab = "", ylab ="Energy sub metering")
               lines(pwr$cdate, power$Sub_metering_1)
               lines(pwr$cdate, power$Sub_metering_2, col = "red")
               lines(pwr$cdate, power$Sub_metering_3, col = "blue")
                    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                           col = c("black", "red", "blue"), lwd = 2, bty = "n")
     ## Plot in the bottom right
          plot(pwr$cdate, power$Global_reactive_power, type = "n", xlab = "datetime",  
               ylab = "Global_reactive_power")
               lines(pwr$cdate, power$Global_reactive_power)
     dev.off()
