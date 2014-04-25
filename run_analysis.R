# I comment out some scripts used to examine and understand the data
# You may want to set your working dir: 
#   setwd('.../GettingAndCleaningData')
# Assume the data is downloaded and unzipped in the working dir
#   download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','harusds.zip','wget')
#   unzip('harusds.zip')
# Examine data before loading them
#   myfile <- file('UCI HAR Dataset/train/X_train.txt')
#   readLines(myfile, 10)
#   close(myfile)
#   myfile <- file('UCI HAR Dataset/train/y_train.txt')
#   readLines(myfile, 10)
#   close(myfile)
#   myfile <- file('UCI HAR Dataset/train/subject_train.txt')
#   readLines(myfile, 10)
#   close(myfile)
#   myfile <- file('UCI HAR Dataset/test/X_test.txt')
#   readLines(myfile, 10)
#   close(myfile)
#   myfile <- file('UCI HAR Dataset/test/y_test.txt')
#   readLines(myfile, 10)
#   close(myfile)
#   myfile <- file('UCI HAR Dataset/test/subject_test.txt')
#   readLines(myfile, 10)
#   close(myfile)
# Load training and testing data
xtrain <- read.table('UCI HAR Dataset/train/x_train.txt')
ytrain <- read.table('UCI HAR Dataset/train/y_train.txt')
strain <- read.table('UCI HAR Dataset/train/subject_train.txt')
xtest <- read.table('UCI HAR Dataset/test/x_test.txt')
ytest <- read.table('UCI HAR Dataset/test/y_test.txt')
stest <- read.table('UCI HAR Dataset/test/subject_test.txt')
# Check to see whether the length matches
#   dim(xtrain)
#   dim(ytrain)
#   dim(strain)
#   dim(xtest)
#   dim(ytest)
#   dim(stest)
# Merge data (step 1)
colnames(ytrain) <- c("Activity")
colnames(strain) <- c("Subject")
colnames(ytest) <- c("Activity")
colnames(stest) <- c("Subject")
mydata <- rbind(cbind(xtrain, ytrain, strain), cbind(xtest, ytest, stest))
#   dim(mydata)
# Extract mean and standard deviation meansurements (step 2)
features <- read.table('UCI HAR Dataset/features.txt')
# Note, eye-balling features.txt suggest we should rename some names
features[,2] <- gsub('_$', '', gsub('[(,)]', '_', gsub('\\(\\)','',features[,2])))
colnames(mydata)[features[,1]] <- features[,2]
meanstddata <- mydata[, grep('mean|std|Activity|Subject', colnames(mydata))]
# Use activity names (step 3)
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
# Note, eye-balling activity_labels.txt show that the id are numbered from 1 to 6
myfunction <- function(x) activities[x,2]
meanstddata$Activity <- sapply(meanstddata$Activity, myfunction)
# Save with appropriate file name (step 4)
write.csv(meanstddata,'UCI_HAR_Mean_and_StandardDeviation_Measurements.csv')
#  Create a second tidy data set (step 5)
mydata$Activity <- sapply(mydata$Activity, myfunction)
# Note that there are 561 column before Activity and Subject in mydata
splitdata <- split(mydata[,1:561], mydata[,c('Activity','Subject')])
newdata <- t(sapply(splitdata, colMeans))
write.csv(newdata,'UCI_HAR_Mean_per_Activity_and_Subject.csv')

