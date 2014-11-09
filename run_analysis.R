## This package includes functions necessary to download, process and clean up
## Human Activity Recognition Using Smartphones Data Set
## It produces and saves to disk "tidy" data set with the following characteristics:
## - It merges the training and the test sets to create one data set
## - Extracts only the measurements on the mean and standard deviation for each measurement. 
## - Uses descriptive activity names to name the activities in the data set
## - Appropriately labels the data set with descriptive variable names. 
## - Creates a second, independent tidy data set with the average of each variable 
##   for each activity and each subject

## This function will download raw data from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## If UCI_HAR_DataSet.zip file is not already present in the current directory
downloadRawData <- function() {
    if (!file.exists("UCI_HAR_DataSet.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                      "UCI_HAR_DataSet.zip", method='curl')
    } else {
        message(sprintf("Raw data has already been downloaded on %s. Nothing to do!", 
                        format.time(get.fileDate("UCI_HAR_DataSet.zip"))))
    }
}

## This function will unpack downloaded raw data present in UCI_HAR_DataSet.zip
## If expected file does not exist, it will throw an error
## Similar to downloadRawData function, 
## unpackRawData also checks if the folder corresponding to the unzipped data already exists
## If it does, the function just report date/time when raw data was unpacked
unpackRawData <- function() {
    if (!file.exists("UCI_HAR_DataSet.zip")) {
        stop("Expect UCI_HAR_DataSet.zip to be present!")
    } else {
        if (file.exists("UCI HAR Dataset")) {
            message(sprintf("Raw data has already been unpacked on %s. Nothing to do!", 
                            format.time(get.fileDate("UCI HAR Dataset"))))
            
        } else {
            message(sprintf("Raw data has been downloaded on %s. Unpacking...", 
                            format.time(get.fileDate("UCI_HAR_DataSet.zip"))))
            unzip("UCI_HAR_DataSet.zip", overwrite=TRUE)
        }
    }
}


## This is a helper function that will report creation date of a file
get.fileDate <- function(filename) {
    return (file.info(filename)[["ctime"]])
}

## This is a helper function that formats time
format.time <- function(time) {
    return(strftime(time, format="%a %b %d %X %Y %Z"))    
}

## MAIN BODY OF THE SCRIPT
# 1. Download Raw Data if needed
downloadRawData()
# 2. Unpack/Unzil Raw Data if needed
unpackRawData()
