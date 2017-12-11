df <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#put Date in Date format
df$Date <- strptime(as.character(df$Date), "%d/%m/%Y")

#get only dates that we want
df <- with(df,df[(Date >= "2007-02-01" & Date <= "2007-02-02"),])

# Combine Date and Time column -> for plots 2,3,4
dateTime <- paste(df$Date, df$Time)

# Name the vector
dateTime <- setNames(dateTime, "DateTime")

# remove Date and Time column -> if sees Date or Time statement will be TRUE, made FALSE by !
df <- df[ ,!(names(df) %in% c("Date","Time"))]

# Add the new column to data frame
df <- cbind(dateTime, df)

# Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)


#graph
par(mfrow = c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
  plot(dateTime,Global_active_power, type= "l",ylab="Global Active Power (kiloWatts)",xlab="") 
  plot(dateTime,Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l",ylab="Energy sub metering", xlab="")
  lines(dateTime,Sub_metering_2,col='red')
  lines(Sub_metering_3~dateTime,col='blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime,type="l",xlab="datetime")
}
)

#put in png
dev.copy(png,'plot4.png',height=480,width=480)
dev.off()