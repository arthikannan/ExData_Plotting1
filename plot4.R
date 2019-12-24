# Extracting the data for plotting

date_from <- as.Date("2007/02/01")
date_to <- as.Date("2007/02/02")


house_data <- read.table("household_power_consumption.txt",na.strings="?",sep=";", 
                         header=TRUE, as.is=TRUE)

house_data[,1] <- as.Date(house_data[,1],format="%d/%m/%Y")

plot_data <- house_data %>% filter(Date >= date_from & Date <= date_to)

plot_data <- plot_data %>% mutate(Date_Time=paste(Date,Time)) %>% 
  mutate(Date_Time=as.POSIXct(Date_Time,format="%Y-%m-%d %H:%M:%S"))

# Plot 4: Date_Time vs Global Active Power, Energy Sub Metering, Voltage, Global Reactive Power

par(mfcol=c(2,2))
with(plot_data,plot(Date_Time,Global_active_power,type="l",col="black",xlab=" ",ylab="Global Active Power"))

with(plot_data,plot(Date_Time,Sub_metering_1,type="n",col="black",xlab=" ",ylab="Energy Sub Metering"))
with(plot_data,points(Date_Time,Sub_metering_1,type="l",col="black"))
with(plot_data,points(Date_Time,Sub_metering_2,type="l",col="red"))
with(plot_data,points(Date_Time,Sub_metering_3,type="l",col="blue"))
legend("top",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),cex=0.8)

with(plot_data,plot(Date_Time,Voltage,type="l",col="black",xlab="datetime",ylab="Voltage"))

with(plot_data,plot(Date_Time,Global_reactive_power,type="l",col="black",xlab="datetime"))

dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
