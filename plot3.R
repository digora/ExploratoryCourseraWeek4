library("data.table")
library("ggplot2")

# Load the NEI & SCC data frames.
NEI <- as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Subset NEI data by Baltimore
baltimoreNEI <- NEI[fips=="24510",]

ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y="Emission Amount") + 
  labs(title="Baltimore City Emissions by Source Type")

#Save plot to memory
dev.copy(png, file="plot3.png")

dev.off()
