library("data.table")
library("ggplot2")
options(scipen = 99)

## Extract the datasets into the RStudio environment
NEI <- as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]

ggplot(combustionNEI,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="Year", y="Emission Amount") + 
  labs(title="US Coal Combustion Source Emissions")

#Save plot to memory
dev.copy(png, file="plot4.png")

dev.off()
