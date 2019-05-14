## Extract the datasets into the RStudio environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen = 99)

##Question 1
library(dplyr)

by_year <- group_by(NEI, NEI$year)
pm25sums <- summarise(by_year, sum = sum(Emissions))
#View(pm25sums)

plot(pm25sums$`NEI$year`, pm25sums$sum, main="Total Emission over the Years", ylab="Emission Amount", xlab="Years", type = "line", xaxt="n")
axis(1, at = c(1999, 2002,2005,2008), labels=c("1999", "2002", "2005", "2008"))
##text(pm25sums$`NEI$year`, pm25sums$sum, cex=0.6, pos=4, col="red")

#Save plot to memory
dev.copy(png, file="plot1.png")

dev.off()

#Yes they did decrease
