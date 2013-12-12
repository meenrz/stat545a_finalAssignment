data <- read.delim("OECD_incomeAndPovertyData.csv")
str(data)

# only want Canadian data
dataCanada <- subset(data, subset=Country == "Canada", 
                 select=c(Age.group, Measure, Year, Value))
str(dataCanada)
unique(dataCanada$Age.group)
dataCanadaTotalPop <- droplevels(subset(dataCanada, subset=Age.group=="Total population",
                             select=c(Measure, Year, Value)))

str(dataCanadaTotalPop)
head(dataCanadaTotalPop, 10)
tail(dataCanadaTotalPop, 10)

# write data to file
write.table(dataCanadaTotalPop, "OECD_CanadaData.txt", sep="\t", quote=FALSE)
