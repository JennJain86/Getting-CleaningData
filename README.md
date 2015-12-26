---
title: "Getting and Cleaning Data- Course Project Read Me"
author: "Jennifer Jain"
date: "December 2015"
output: html_document
---

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

You should create *one* R script called run_analysis.R that does the following with the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI Machine Learning Repository") Data Set

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.



***
###About the data:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


***

[Download the Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

#####`run_analysis.R` can be run as long as the Samsung data is in your working directory.

#####Packages required for this analysis

`data.table`
`dplyr`
`magrittr`
`plyr`


***
### Merge the training and test datasets to create one dataset
Merging the two datasets into one is done in several steps throughout `run_analysis.R`

#### Working With the Test Data 


1. First we load variable names and activity labels for analysis using `data.table`
       + The variable names are stored in `features.txt` and the activity lables are stored in `activity_labels.txt`. Both of these files are located in `UCI\ HAR\ Dataset`.




2. Next we load the test data (`X_test.txt`, `y_test.txt` and `subject_test.txt`).

#### Extract only the measurements on the mean and standard deviation for each measurement in the test data

3. Using the `grepl` function we are able to search `variable_names` for strings matching mean and standard deviation, and then assign them to a new variable called `measurment_variables_test`.

````
measurment_variables_test <- grepl("mean|std", variable_names)
````
4. The `y_test.txt` file is used to create the `Subject`, `Activity_ID`, and `Activity_Label` data labels for the test data.

5. A `test_dataset` is created uning `cbind`


#### Working With the Training Data 


6. We load the training data (`X_train.txt`, `y_train.txt` and `subject_train.txt`).

#### Extract only the measurements on the mean and standard deviation for each measurement in the test data

7. Using the `grepl` function we are able to search `variable_names` for strings matching mean and standard deviation, and then assign them to a new variable called `measurment_variables_test`.

````
measurment_variables_training <- grepl("mean|std", variable_names)
````
8. The `y_train.txt` file is used to create the `Subject`, `Activity_ID`, and `Activity_Label` data labels for the test data.

9. A `training_dataset` is created using `cbind`

10. ##### Merge the training and test datasets to create one dataset

````
clean_dataset <-rbind(training_dataset, test_dataset)
````

###Appropriately labels the data set with descriptive variable names

11.  We use the gsub function to clean up some of the abbreviations in the `clean_dataset` variable names so they be more intuative.

````
ames(clean_dataset)<-gsub("^t", "Time-", names(clean_dataset))
names(clean_dataset)<-gsub("Acc", "Accelerometer-", names(clean_dataset))
names(clean_dataset)<-gsub("Mag", "Magnitude-", names(clean_dataset))
names(clean_dataset)<-gsub("Gyro", "Gyroscope-", names(clean_dataset))
names(clean_dataset)<-gsub("^f", "Freq-", names(clean_dataset))
````
12. Group `clean_dataset` by `Subject` and `Activity_ID` and `summarize_each` to get the mean of each variable for each activity and each subject.


13. Drop `Activity_ID` and export `tidy_data.txt`.
        
***