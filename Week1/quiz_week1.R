setwd('Week1')

if (!is.element("data.table", installed.packages())) {
    install.packages("data.table")
} else {
    print("data.table package is already installed")
}
library(data.table)

if (!file.exists("ss06hid.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "ss06hid.csv", method='curl')
}
print("Question 1: How many properties are worth $1,000,000 or more?")
data <- fread("ss06hid.csv", sep=",")
answer <- nrow(data[data$VAL==24,])
print(answer)

### ---------------
if (!is.element("xlsx", installed.packages())) {
    install.packages("xlsx")
} else {
    print("xlsx package is already installed")
}
library(xlsx)

if (!file.exists("NGAP.xlsx")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "NGAP.xlsx", method='curl')
}

dat <- read.xlsx("NGAP.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
answer <- sum(dat$Zip*dat$Ext,na.rm=T) 
print(paste("Question 3: sum(dat$Zip*dat$Ext,na.rm=T)=", answer))


### -------------------
if (!is.element("XML", installed.packages())) {
    install.packages("XML")
} else {
    print("XML package is already installed")
}
library(XML)

if (!file.exists("restaurants.xml")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "restaurants.xml", method='curl')
}

rest <- xmlTreeParse("restaurants.xml", useInternal=TRUE)
filtered <- xpathSApply(xmlRoot(rest), "//zipcode[text()=21231]")
answer <- length(filtered)
print(paste("Question 4: Number of restautants in zio code 21231 = ", answer))

### ----------------
if (!file.exists("ss06pid.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "ss06pid.csv", method='curl')
}
DT <- fread("ss06pid.csv", sep=",")

print(system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}, gcFirst = TRUE))
print(system.time({sapply(split(DT$pwgtp15,DT$SEX),mean)}, gcFirst = TRUE))
print(system.time({tapply(DT$pwgtp15,DT$SEX,mean)}, gcFirst = TRUE))
print(system.time({DT[,mean(pwgtp15),by=SEX]}, gcFirst = TRUE))
print(system.time({mean(DT$pwgtp15,by=DT$SEX)}, gcFirst = TRUE))

setwd("../")



