library(plyr)
library(lattice)

data <- read.delim("OECD_CanadaData.txt")
str(data)
head(data, 10)
levels(data$Measure) #get measures
unique(data$Year) #1976 - 2010

##################################### INEQUALITY
##look at inequality before and after taxes and transfers
giniPost <- "Gini (at disposable income, post taxes and transfers)"
giniPre <- "Gini before taxes and transfers"
giniData <- droplevels(subset(data, Measure== c(giniPost, giniPre)), 
                       select=c(Year, Value))
giniData <- ddply(giniData, ~Measure, summarize, year=Year, giniIndex=Value)
str(giniData)

#write data to file
write.table(giniData, file="giniData.txt", quote = FALSE, sep = "\t", row.names=FALSE)

#make a plot
giniPlot <- xyplot(giniIndex~year, giniData, group=Measure,
       type=c("p", "r"),
       auto.key=TRUE,
       main="Gini Index, Before and After Taxes and Transfers",
       xlab="Year",
       ylab="Gini Index")
giniPlot
pdf("giniPlot.pdf")
dev.off()
dev.print(pdf, "giniPlot.pdf")

###################################### POVERTY
##look at poverty rate by age group
povChild <- "Age group 0-17: Poverty rate after taxes and transfers"
povYouth <- "Age group 18-25: Poverty rate after taxes and transfers"
povAdult <- "Age group 26-40: Poverty rate after taxes and transfers"
povOlderAdult <- "Age group 51-65: Poverty rate after taxes and transfers"
povSenior <- "Age group 66-75: Poverty rate after taxes and transfers"
povElder <- "Age group 76+: Poverty rate after taxes and transfers"
povAll <- "All age groups: Poverty rate after taxes and transfers"

povData <- droplevels(subset(data, Measure== c(povChild, povYouth, povAdult, povOlderAdult, povSenior, povElder),
                  select=c(Measure, Year, Value)))
povData <- ddply(povData, ~Measure, summarize, year=Year, povertyRate=Value)
levels(povData$Measure) <- c("0 - 17", "18 - 25", "26 - 40", "51 - 65", "66 - 76", "76+")
str(povData)

#write data to file
write.table(povData, file="povData.txt", quote = FALSE, sep = "\t", row.names=FALSE)
    
#make some plots 
povPlot <- xyplot(povertyRate~year, povData, group=Measure,
       type=c("p", "r"),
       auto.key=TRUE,
       main="Poverty Rates By Age Group",
       xlab="Year",
       ylab="Poverty Rate")
povPlot
pdf("povPlot.pdf")
dev.off()
dev.print(pdf, "povPlot.pdf")

povPlotPanel <- xyplot(povertyRate~year|Measure, povData,
                       type=c("p", "r"),
                       auto.key=TRUE,
                       main="Poverty Rates By Age Group",
                       xlab="Year",
                       ylab="Poverty Rate")
povPlotPanel
pdf("povPlotPanel.pdf")
dev.off()
dev.print(pdf, "povPlotPanel.pdf")
