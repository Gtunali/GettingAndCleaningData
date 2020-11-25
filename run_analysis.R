library(dplyr)

## Download the data set
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- fname <- "Coursera_DS3_Final.zip"

## check if the .zip already downloaded
if (!file.exists(fname)){
  download.file(URL, fname, method="curl")
}  

## check if the file already unzipped
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fname) 
}

## read the features and activities
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

## load the test data and bind
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
test <- cbind(subject_test, y_test, x_test)

## load the training data and bind
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
training <- cbind(subject_train, y_train, x_train)

## merge the training and the test data
dataset <- rbind(training, test)

## extract the mean and std columns
filteredData <- select(dataset, subject, code, contains("mean"), contains("std"))

#replace the activity codes with the Activity text
filteredData$code <- activities[filteredData$code, 2]

#rename the columns to descriptive ones
names(filteredData)[2] = "activityCode"
names(filteredData) <- gsub("Acc", "Accelerometer", names(filteredData))
names(filteredData) <- gsub("Gyro", "Gyroscope", names(filteredData))
names(filteredData) <- gsub("BodyBody", "Body", names(filteredData))
names(filteredData) <- gsub("Mag", "Magnitude", names(filteredData))
names(filteredData) <- gsub("^t", "Time", names(filteredData))
names(filteredData) <- gsub("^f", "Frequency", names(filteredData))
names(filteredData) <- gsub("tBody", "TimeBody", names(filteredData))
names(filteredData) <- gsub("-mean()", "Mean", names(filteredData), ignore.case = TRUE)
names(filteredData) <- gsub("-std()", "STD", names(filteredData), ignore.case = TRUE)
names(filteredData) <- gsub("-freq()", "Frequency", names(filteredData), ignore.case = TRUE)
names(filteredData) <- gsub("angle", "Angle", names(filteredData))
names(filteredData) <- gsub("gravity", "Gravity", names(filteredData))

## find the mean values and write the result out to a file
TidyResult <- filteredData %>% group_by(subject, activityCode) %>% summarise_all(list(mean = mean))
write.table(TidyResult, "TidyResult.txt", row.name=FALSE)
