# Extracting the data for plotting

date_from <- as.Date("2007/02/01")
date_to <- as.Date("2007/02/02")


house_data <- read.table("household_power_consumption.txt",na.strings="?",sep=";", 
                         header=TRUE, as.is=TRUE)

house_data[,1] <- as.Date(house_data[,1],format="%d/%m/%Y")

plot_data <- house_data %>% filter(Date >= date_from & Date <= date_to)

plot_data <- plot_data %>% mutate(Date_Time=paste(Date,Time)) %>% 
  mutate(Date_Time=as.POSIXct(Date_Time,format="%Y-%m-%d %H:%M:%S"))



# Plot 1: Global Active Power histogram

hist(plot_data[,3], main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
