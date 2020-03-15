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
dataset$Date <- dmy(dataset$Date);

dataset$Time <- hms(dataset$Time);

#Take the subset we are interested in.
sub_set <-
    subset(dataset, Date >= ymd("2007-02-01") &
               Date <= ymd("2007-02-02"));

#Open a png graphic device.
png("plot1.png");

#Draw the histogram.
hist(
    sub_set$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red"
);

#Close the graphic device.
dev.off()

#Release the memory.
rm(dataset, sub_set)