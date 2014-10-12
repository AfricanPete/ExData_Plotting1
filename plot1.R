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

# png(filename = "Rplot%03d.png",
#     width = 480, height = 480, units = "px", pointsize = 12,
#     bg = "white", res = NA, family = "", restoreConsole = TRUE,
#     type = c("windows", "cairo", "cairo-png"), antialias)
png("plot1.png",width = 480, height = 480, units = "px",bg = "white")
# 
# hist(x, breaks = "Sturges",
#      freq = NULL, probability = !freq,
#      include.lowest = TRUE, right = TRUE,
#      density = NULL, angle = 45, col = NULL, border = NULL,
#      main = paste("Histogram of" , xname),
#      xlim = range(breaks), ylim = NULL,
#      xlab = xname, ylab,
#      axes = TRUE, plot = TRUE, labels = FALSE,
#      nclass = NULL, warn.unused = TRUE, ...)

hist(
        workingData$Global_active_power, 
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", 
        ylab="Frequency",
        col="Red"
        )
dev.off()