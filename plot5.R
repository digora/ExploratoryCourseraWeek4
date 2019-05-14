library("data.table")
library("ggplot2")
library("dplyr")
options(scipen = 99)

## Extract the datasets into the RStudio environment
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

sccLevels <- select(SCC, SCC.Level.Two)

# Gather the subset of the NEI data which corresponds to vehicles
vehiclesSCC <- SCC[grepl("vehicle", sccLevels$SCC.Level.Two , ignore.case=TRUE)
                   , SCC]

vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="Year", y="Emission Amount") + 
  labs(title="Baltimore Motor Vehicle Source Emissions")

#Save plot to memory
dev.copy(png, file="plot5.png")

dev.off()

