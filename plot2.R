library("data.table")

## Extract the datasets into the RStudio environment
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]

test <- plot(totalNEI$year, totalNEI$Emissions,names = totalNEI[, year], xlab = "Years", ylab = "Emission Amount", main = "Baltimore City Emissions over the Years", type="l",xaxt="n")
axis(1, at = c(1999, 2002,2005,2008), labels=c("1999", "2002", "2005", "2008"))

#Save plot to memory
dev.copy(png, file="plot2.png")

dev.off()
