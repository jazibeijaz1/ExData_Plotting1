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
png("plot2.png")


#Draw the line graph.
with(
    sub_set,
    plot(
        Date + Time,
        Global_active_power,
        type = "l",
        ylab = "Global Active Power(kilowatts)",
        xlab = ""
    )
)

#Close the graphic device.
dev.off()

#Release the memory.
rm(dataset, sub_set)