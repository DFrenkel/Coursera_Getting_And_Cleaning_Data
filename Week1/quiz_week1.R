setwd('Week1')

if (!is.element("data.table", installed.packages())) {
    install.packages("data.table")
} else {
    print("data.table package is already installed")
}
library(data.table)

# Download file unless it already exists
if (!file.exists("ss06hid.csv")) {
    print("Downloading file ss06hid.csv...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "ss06hid.csv", method='curl')
} else {
    print("File ss06hid.csv already exists - skipping...")
}

print("Question 1: How many properties are worth $1,000,000 or more?")
# with data.frame
data1.1 <- read.csv("ss06hid.csv", header = TRUE)
answer1 = sum(data1.1$VAL==24, na.rm = TRUE)
print(answer1)
# with data.table
data1.2 <- fread("ss06hid.csv", sep=",")
answer1 <- nrow(data1.2[data1.2$VAL==24,])
print(answer1)

### ---------------
if (!is.element("xlsx", installed.packages())) {
    install.packages("xlsx")
} else {
    print("xlsx package is already installed")
}
library(xlsx)

if (!file.exists("NGAP.xlsx")) {
    print("Downloading file NGAP.xml...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "NGAP.xlsx", method='curl')
} else {
    print("File NGAP.xml already exists - skipping...")
}

data3 <- read.xlsx("NGAP.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
answer3 <- sum(data3$Zip*data3$Ext, na.rm=T) 
print(paste("Question 3: sum(dat$Zip*dat$Ext,na.rm=T)=", answer3))

### -------------------
if (!is.element("XML", installed.packages())) {
    install.packages("XML")
} else {
    print("XML package is already installed")
}
library(XML)

if (!file.exists("restaurants.xml")) {
    print("Downloading file restaurants.xml...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "restaurants.xml", method='curl')
} else {
    print("File restaurants.xml already exists - skipping...")
}

rest <- xmlTreeParse("restaurants.xml", useInternal=TRUE)
filtered <- xpathSApply(xmlRoot(rest), "//zipcode[text()=21231]")
answer4 <- length(filtered)
print(paste("Question 4: Number of restautants in zio code 21231 = ", answer4))

### ----------------
if (!file.exists("ss06pid.csv")) {
    print("Downloading file ss06pid.csv...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "ss06pid.csv", method='curl')
} else {
    print("File ss06pid.csv already exists - skipping...")
}
DT <- fread("ss06pid.csv", sep=",")

print(system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}, gcFirst = TRUE))
print(system.time({sapply(split(DT$pwgtp15,DT$SEX),mean)}, gcFirst = TRUE))
print(system.time({tapply(DT$pwgtp15,DT$SEX,mean)}, gcFirst = TRUE))
print(system.time({DT[,mean(pwgtp15),by=SEX]}, gcFirst = TRUE))
print(system.time({mean(DT$pwgtp15,by=DT$SEX)}, gcFirst = TRUE))

setwd("../")



