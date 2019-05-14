library("data.table")
library("ggplot2")
library("dplyr")

# Load the NEI & SCC data frames.
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

test123 <- select(SCC, SCC.Level.Two)

# Gather the subset of the NEI data which corresponds to vehicles
vehiclesSCC <- SCC[grepl("vehicle", test123$SCC.Level.Two , ignore.case=TRUE)
                   , SCC]

vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

#Save plot to memory
dev.copy(png, file="plot5.png")

dev.off()
