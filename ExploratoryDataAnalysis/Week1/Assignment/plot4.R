df <- as.data.frame(read.table("household_power_consumption.txt", 
                               sep = ";", header = TRUE, 
                               na.strings = c("?")))
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
# Dates must be between 2007-02-01 and 2007-02-02
df.sub <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
# Now let's add the time information
datetime = paste(as.character(df.sub$Date), df.sub$Time)
df.sub$CompleteDate <- strptime(datetime, "%Y-%m-%d %H:%M:%S") 

library(datasets)
x11()
par(mfrow=c(2,2))
plot(df.sub$CompleteDate, 
     df.sub$Global_active_power, 
     type = "l",
     ylab = "Global Active Power",
     xlab = "")
plot(df.sub$CompleteDate, 
     df.sub$Voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

#------------
plot(df.sub$CompleteDate, 
     df.sub$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(df.sub$CompleteDate, 
      df.sub$Sub_metering_2, 
      col ="red")
lines(df.sub$CompleteDate, 
      df.sub$Sub_metering_3, 
      col = "blue")
legend("topright", 
       legend = c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),
       pch=c("-","-", "-"),
       bty = "n")

plot(df.sub$CompleteDate, 
     df.sub$Global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.copy(png, filename = 'plot4.png', width = 480, height = 480)
dev.off()