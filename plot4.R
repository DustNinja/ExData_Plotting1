## Read in full dataset
data = read.table("household_power_consumption.txt", sep=";", dec=".", header = TRUE,
                  stringsAsFactors=FALSE, na.strings = "?",
                  colClasses=c(rep("character",2), rep("numeric",7)))

## Create Feb 1-2, 2007 data subset
data_sub <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]
rm(data)

## Convert date/time
data_sub$DateTime <- strptime(paste(data_sub$Date,data_sub$Time),"%d/%m/%Y %H:%M:%S")

## Create PNG file
png(filename = "plot4.png",                        # output file name
    height   = 480,                                # plot height
    width    = 480,                                # plot width
    bg       = "transparent")                      # background color

## Create multiplot layout
par(mfrow = c(2, 2))

#~~~~~~~~~~~~~~~~~~~~~~
# Plot 1: Top Left  
#~~~~~~~~~~~~~~~~~~~~~~
with(data_sub, {
    plot(DateTime, Global_active_power, 
         ylab = "Global Active Power",             # y-axis title
         xlab = NA,                                # x-axis title
         type="l")                                 # plot type ("l" for line)
})

#~~~~~~~~~~~~~~~~~~~~~~
# Plot 2: Top Right    
#~~~~~~~~~~~~~~~~~~~~~~
with(data_sub, {
    plot(DateTime, Voltage, 
         ylab = "Voltage",                         # y-axis title
         xlab = "datetime",                        # x-axis title
         type="l")                                 # plot type ("l" for line)
    
})

#~~~~~~~~~~~~~~~~~~~~~~
# Plot 3: Bottom Left  
#~~~~~~~~~~~~~~~~~~~~~~
with(data_sub, {
    plot(DateTime, Sub_metering_1, 
         ylab = "Energy sub metering",             # y-axis title
         xlab = NA,                                # x-axis title
         type="l")                                 # plot type ("l" for line)
    
    # overlay lines
    lines(DateTime, Sub_metering_2, col="Red")
    lines(DateTime, Sub_metering_3, col="Blue")
})

## Add a legend
legend("topright",                                 # location
       col    = c("black", "red", "blue"),         # line colors
       legend = c("Sub_metering_1",                # labels
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       lty    = 1,                                 # line type
       bty    = "n")                               # no box outline

#~~~~~~~~~~~~~~~~~~~~~~
# Plot 4: Bottom Right  
#~~~~~~~~~~~~~~~~~~~~~~
with(data_sub, {
    plot(DateTime, Global_reactive_power, 
         xlab = "datetime",                        # x-axis title
         type="l")                                 # plot type ("l" for line)
    
})

## Shut off plotting device
dev.off()
