library(lubridate)

#Read in the dataset.
dataset <-
    read.csv(
        "household_power_consumption.txt",
        na.strings = c("?"),
        header = TRUE,
        sep = ";"
    )

#Convert factors to proper date and time objects
dataset$Date <- dmy(dataset$Date)

dataset$Time <- hms(dataset$Time)


#Take the subset we are interested in.
sub_set <-
    subset(dataset, Date >= ymd("2007-02-01") &
               Date <= ymd("2007-02-02"))


#Open a png graphic device.
png("plot4.png")

#Set the canvas style.
par(mfcol = c(2, 2))

#Draw the first line graph.
with(
    sub_set,
    plot(
        Date + Time,
        Global_active_power,
        type = "l",
        ylab = "Global Active Power",
        xlab = ""
    )
)

#Draw the second line graph.
with(
    sub_set,
    plot(
        Date + Time,
        Sub_metering_1,
        type = "n",
        ylab = "Energy sub metering",
        xlab = ""
    )
)

lines(sub_set$Date + sub_set$Time, sub_set$Sub_metering_1)
lines(sub_set$Date + sub_set$Time, sub_set$Sub_metering_2, col = "red")
lines(sub_set$Date + sub_set$Time, sub_set$Sub_metering_3, col = "blue")

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = c(1, 1, 1),
    col = c("black", "red", "blue")
)

#Draw the third line graph.
with(sub_set,
     plot(Date + Time,
          Voltage,
          type = "l",
          xlab = "datetime"))

#Draw the fourth line graph.
with(sub_set,
     plot(
         Date + Time,
         Global_reactive_power,
         type = "l",
         xlab = "datetime"
     ))

#Close the graphic device.
dev.off()

#Release the memory.
rm(dataset, sub_set)