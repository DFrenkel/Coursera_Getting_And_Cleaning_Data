setwd('Week2')

## Installing needed packages
if (!is.element("DBI", installed.packages())) {
    install.packages("DBI")
} else {
    print("DBI package is already installed")
}

if (!is.element("sqldf", installed.packages())) {
    install.packages("sqldf")
} else {
    print("sqldf package is already installed")
}

if (!is.element("RMySQL", installed.packages())) {
    Sys.setenv(PKG_CPPFLAGS = "-I/usr/local/mysql/include/")
    Sys.setenv(PKG_LIBS = "-L/usr/local/mysql/lib -lmysqlclient")
    install.packages("~/Downloads/RMySQL_0.9-3.tar.gz", repos = NULL, type = "source")
} else {
    print("RMySQL package is already installed")
}

if (!is.element("httr", installed.packages())) {
    install.packages("httr")
} else {
    print("httr package is already installed")
}

if (!is.element("jsonlite", installed.packages())) {
    install.packages("jsonlite")
} else {
    print("jsonlite package is already installed")
}



library(httr)
library(jsonlite)

###-------------
git <- handle("https://api.github.com")
repos <- GET(handle=git, path="users/jtleek/repos")
data <- fromJSON(content(repos, as="text"))
repo <- data[data$name=="datasharing", ]
result <- repo$created_at
print("Question 1: Creation time of https://github.com/jtleek/dataanalysis.git")
print(paste("created_at", result))



###-------------
print("Question 2: SQLDF")
library(sqldf)
if (!file.exists("ss06pid.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "ss06pid.csv", method='curl')
}
acs <- fread("ss06pid.csv", sep=",")
result <- sqldf("select pwgtp1 from acs where AGEP < 50")
print(head(result))

print("Question 3: SQLDF/Distinct")
result <- sqldf("select distinct AGEP from acs")
print(head(result))

####------------------
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con)
lines <- c(10,20,30,100)
print("Question 4: Number of Chars in lines")
print(lines)
print(nchar(html[lines]))

####--------------------

if (!file.exists("wksst8110.for")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", "wksst8110.for", method='curl')
}
tab <- read.fwf("wksst8110.for", c(15,4,4+5,4,4+5,4,4+5,4,4+5), skip=4, strip.white=TRUE)
result <- sum(tab[, 4])
print(paste("Question 5: SUM=", result))







setwd('../')

