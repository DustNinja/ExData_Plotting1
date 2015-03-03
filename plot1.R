## Read in full dataset
data = read.table("household_power_consumption.txt", sep=";", dec=".", header = TRUE,
                  stringsAsFactors=FALSE, na.strings = "?",
                  colClasses=c(rep("character",2), rep("numeric",7)))

## Create Feb 1-2, 2007 data subset
data_sub <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]
rm(data)

## Create PNG file
png(filename = "plot1.png",                        # output file name
    height   = 480,                                # plot height
    width    = 480,                                # plot width
    bg       = "transparent")                      # background color
                             
## Create plot
hist(data_sub$Global_active_power,                 
     main   = "Global Active Power",               # title
     xlab   = "Global Active Power (kilowatts)",   # x-axis title
     ylim   = c(0, 1200),                          # y-axis range
     breaks = 12,                                  # number of bars
     col    = "Red")                               # color 

## Shut off plotting device
dev.off()
