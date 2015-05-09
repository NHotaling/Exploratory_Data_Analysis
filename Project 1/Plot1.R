## Surface laptop - setwd("C:/Users/Nathan/OneDrive/R/datasciencecoursera/Exploratory_Data_Analysis/Project 1")
library(dplyr)
library(plyr)
library(lubridate)

## Creates character classes to be read in by the read.csv command. They are all character because
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

## Creates a new column called cdate that is a combo of the data and time
          pwr <- mutate(power, cdate = as.POSIXct(paste(power$Date, power$Time), format="%Y-%m-%d %H:%M:%S"))
               pwr$cdate[1:24]
               pwr$cdate[2857:2880]
               str(pwr) 
               head(pwr) 
          

## Creates a histogram for me to look at
          hist(pwr$Global_active_power, col = "red", main = "Global Active Power",
               xlab ="Global Active Power (kilowatts)", breaks = 12)

## Prints a png with the histogram that was built above.
          png(filename = "Plot1.png", width = 480, height = 480, units = "px")
               with(pwr, hist(pwr$Global_active_power, col = "red", main = "Global Active Power",
                                xlab ="Global Active Power (kilowatts)", breaks = 12))
          dev.off()
