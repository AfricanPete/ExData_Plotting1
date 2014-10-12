#Set the working directory
setwd("C:/Couresra/ExploratoryDataAnalysis/ExData_Plotting1")

# Prepare data on read
#na.strings="?"                 To replace the ? character as a valid NA
#stringsAsFactors = FALSE       To avoid conversion errors using comparison operators
mainData <-read.csv("household_power_consumption.txt",na.strings="?",sep=';',stringsAsFactors = FALSE,header=TRUE)


#resolve error message,  >= not meaningful for factors
###http://stackoverflow.com/questions/14471640/r-subset-by-date
###http://stackoverflow.com/questions/14729454/subset-a-dataframe-by-time
###http://stackoverflow.com/questions/2832385/changing-date-format-to-d-m-y
#Formatting 
#mainData$Date<- as.Date(as.character(mainData$Date), "%d-%m-%y")  
#testData <-mainData
#testData$Date <-format(as.Date(testData$Date), "%d/%m/%Y")
mainData$Date <- as.Date(mainData$Date, format="%d/%m/%Y")
workingData <- subset(mainData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Resolve error message Error in (function (formula, data = NULL, subset = NULL, na.action = na.fail,  : 
#invalid type (NULL) for variable 'workingData$Datetime'
####http://r.789695.n4.nabble.com/Applying-strptime-to-a-data-set-or-array-td795224.html
datetime <- paste(as.Date(workingData$Date), workingData$Time)
workingData$Datetime <- as.POSIXct(datetime)

# png(filename = "Rplot%03d.png",
#     width = 480, height = 480, units = "px", pointsize = 12,
#     bg = "white", res = NA, family = "", restoreConsole = TRUE,
#     type = c("windows", "cairo", "cairo-png"), antialias)
png("plot4.png",width = 480, height = 480, units = "px",bg = "white")

#
par(mfcol=c(2,2))
   
        plot(
                workingData$Global_active_power~workingData$Datetime, 
                type="l",
                ylab="Global Active Power (kilowatts)", 
                xlab=""
    )
        plot(
                workingData$Sub_metering_1~workingData$Datetime,
                type = "l",                     #"l" for lines
                col = "black",
                xlab = "", 
                ylab = "Energy sub metering") 
                lines(workingData$Sub_metering_2~workingData$Datetime, col = "red")
                lines(workingData$Sub_metering_3~workingData$Datetime, col = "blue")
        legend(
                "topright",         
                col = c("black", "red", "blue"),
                c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                bty="n",
                lwd=1
                )
    plot(
            workingData$Voltage~workingData$Datetime, 
            type="l",
            ylab="Voltage", 
            xlab="datetime"
    )
    plot(
            workingData$Global_reactive_power~workingData$Datetime, 
            type="l",
            ylab="Global_reactive_power", 
            xlab="datetime"
    )
    


dev.off()