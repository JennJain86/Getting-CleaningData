#Getting and Cleaning Data - Course Project, December 2015

## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The "Human Activity Recognition Using Smartphones" data set can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## A full description is availabel at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


#Instillation of packages required for analysis

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}å

if (!require("magrittr")) {
  install.packages("magrittr")
}

if (!require("tidyr")) {
  install.packages("tidyr")
}

if (!require("plyr")){
        install.packages("plyr")
}

require("data.table")
require("dplyr")
require("magrittr")
require("tidyr")
require("plyr")

#Clear console

cat("\014") 

#Load variable names and activity labels for analysis 

variable_names <-read.table("./UCI HAR Dataset/features.txt") [,2]
activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt") [,2]

#Load test data (X_test, Y_test, subject_test)

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Processing test data 

## Extract variables names that measure mean and standard deviation for each element in the test file

measurment_variables_test <- grepl("mean|std", variable_names)
names(X_test) = variable_names
X_test = X_test [measurment_variables_test]

## Working with the test activity labels 
Y_test[,2] = activity_labels[Y_test[,1]]
names(Y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "Subject"

## Create one data set for test data based on the changes made above

test_dataset <- cbind(as.data.table(subject_test), Y_test, X_test)

#Load training data (X_training, Y_training, subject_training)

X_training <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_training <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_training <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Processing training data 

## Extract variables names that measure mean and standard deviation for each element in the training file

measurment_variables_training <- grepl("mean|std", variable_names)
names(X_training) = variable_names
X_training = X_training [measurment_variables_training]

## Working with the training activity labels

Y_training[,2] = activity_labels[Y_training[,1]]
names(Y_training) = c("Activity_ID", "Activity_Label")
names(subject_training) = "Subject"

## Create one data set for training data based on the changes made above

training_dataset <- cbind(as.data.table(subject_training), Y_training, X_training)

# Combine the test and training datasets

clean_dataset <-rbind(training_dataset, test_dataset)

# label variables with discriptive names

names(clean_dataset)<-gsub("^t", "Time-", names(clean_dataset))
names(clean_dataset)<-gsub("Acc", "Accelerometer-", names(clean_dataset))
names(clean_dataset)<-gsub("Mag", "Magnitude-", names(clean_dataset))
names(clean_dataset)<-gsub("Gyro", "Gyroscope-", names(clean_dataset))
names(clean_dataset)<-gsub("^f", "Freq-", names(clean_dataset))


##Create tidy data set with the average of each variable for each activity and each subject and drop the numeric Activity ID

tidy_dataset <- group_by(clean_dataset, Subject, Activity_ID)

tidy_dataset <- summarise_each(tidy_dataset,funs(mean)) 
tidy_dataset[,Activity_ID:=NULL]
write.table(tidy_dataset,file= "tidy_data.txt", sep = "\t", row.names=FALSE)


print("End of File")

