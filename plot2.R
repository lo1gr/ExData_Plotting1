df <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#put Date in Date format
df$Date <- strptime(as.character(df$Date), "%d/%m/%Y")

#get only dates that we want
df <- with(df,df[(Date >= "2007-02-01" & Date <= "2007-02-02"),])

# Combine Date and Time column -> for plots 2,3,4
dateTime <- paste(df$Date, df$Time)

# Name the vector
#dateTime <- setNames(dateTime, "DateTime")

# remove Date and Time column -> if sees Date or Time statement will be TRUE, made FALSE by !
df <- df[ ,!(names(df) %in% c("Date","Time"))]

# Add the new column to data frame
df <- cbind(dateTime, df)

# Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)

#graph : type is "l" because want lines
with(df,plot(dateTime,Global_active_power, type= "l",ylab="Global Active Power (kiloWatts)"))

#put in png
dev.copy(png,'plot2.png',height=480,width=480)
dev.off()