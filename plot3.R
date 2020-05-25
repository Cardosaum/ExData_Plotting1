# plot2.R
# Matheus, 2020-05-24
# 
# this script creates plot2.png

# load libraries
library(tidyverse)

# load data
# we skip all rows that does not correspond to 2007
data_file <- "./household_power_consumption.txt"
data_names <- read_delim(data_file, ";", n_max = 1)
data_names <- data_names %>% names() %>% tolower()
data <- read_delim(data_file, ";", 
                   na = c("", "NA", "na", "?"), 
                   trim_ws = TRUE, 
                   skip = 21997, 
                   n_max = 525598,
                   col_names = data_names)
data$date <- as.Date(data$date, "%d/%m/%Y")
data <- data %>% filter(date >= "2007-02-01" & date <= "2007-02-02")
data <- data %>% unite(dt, date, time, remove = FALSE, sep = " ")
data$dt <- strptime(data$dt, "%F %T") %>% as.POSIXct()

# create plot
png("plot3.png")
plot(data$dt, data$sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$dt, data$sub_metering_2, col = "red")
lines(data$dt, data$sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1))
dev.off()
