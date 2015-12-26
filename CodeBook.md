---
title: "Getting and Cleaning Data - Course Project"
author: "Jennifer Jain"
date: "December 2015"
output: html_document
---

#Codebook 

___

####Cleaning the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI Machine Learning Repository") Data Set

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

[Download the Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

***
##About the data:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#####The following files are provided in the dataset

- `features_info.txt`: Shows information about the variables used on the feature vector.

- `features.txt`: List of all features.

- `activity_labels.txt`: Links the class labels with their activity name.

- `train/X_train.txt`: Training set.

- `train/y_train.txt`: Training labels.

- `test/X_test.txt`: Test set.

- `test/y_test.txt`: Test labels.




#####The following information is provided for each record in the dataset:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.





##### Additional information can be found in the `README.txt` file that comes with the dataset.
***
##Cleaning the data:

The objective of this assignment is to create **one** R script called `run_analysis.R` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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

##List of Measured Variables 

- Subject
- Activity_Label
- Time-BodyAccelerometer--mean()-X
- Time-BodyAccelerometer--mean()-Y
- Time-BodyAccelerometer--mean()-Z
- Time-BodyAccelerometer--std()-X
- Time-BodyAccelerometer--std()-Y
- Time-BodyAccelerometer--std()-Z
- Time-GravityAccelerometer--mean()-X
- Time-GravityAccelerometer--mean()-Y
- Time-GravityAccelerometer--mean()-Z
- Time-GravityAccelerometer--std()-X
- Time-GravityAccelerometer--std()-Y
- Time-GravityAccelerometer--std()-Z
- Time-BodyAccelerometer-Jerk-mean()-X
- Time-BodyAccelerometer-Jerk-mean()-Y
- Time-BodyAccelerometer-Jerk-mean()-Z
- Time-BodyAccelerometer-Jerk-std()-X
- Time-BodyAccelerometer-Jerk-std()-Y
- Time-BodyAccelerometer-Jerk-std()-Z
- Time-BodyGyroscope--mean()-X
- Time-BodyGyroscope--mean()-Y
- Time-BodyGyroscope--mean()-Z
- Time-BodyGyroscope--std()-X
- Time-BodyGyroscope--std()-Y
- Time-BodyGyroscope--std()-Z
- Time-BodyGyroscope-Jerk-mean()-X
- Time-BodyGyroscope-Jerk-mean()-Y
- Time-BodyGyroscope-Jerk-mean()-Z
- Time-BodyGyroscope-Jerk-std()-X
- Time-BodyGyroscope-Jerk-std()-Y
- Time-BodyGyroscope-Jerk-std()-Z
- Time-BodyAccelerometer-Magnitude--mean()
- Time-BodyAccelerometer-Magnitude--std()
- Time-GravityAccelerometer-Magnitude--mean()
- Time-GravityAccelerometer-Magnitude--std()
- Time-BodyAccelerometer-JerkMagnitude--mean()
- Time-BodyAccelerometer-JerkMagnitude--std()
- Time-BodyGyroscope-Magnitude--mean()
- Time-BodyGyroscope-Magnitude--std()
- Time-BodyGyroscope-JerkMagnitude--mean()
- Time-BodyGyroscope-JerkMagnitude--std()
- Freq-BodyAccelerometer--mean()-X
- Freq-BodyAccelerometer--mean()-Y
- Freq-BodyAccelerometer--mean()-Z
- Freq-BodyAccelerometer--std()-X
- Freq-BodyAccelerometer--std()-Y
- Freq-BodyAccelerometer--std()-Z
- Freq-BodyAccelerometer--meanFreq()-X
- Freq-BodyAccelerometer--meanFreq()-Y
- Freq-BodyAccelerometer--meanFreq()-Z
- Freq-BodyAccelerometer-Jerk-mean()-X
- Freq-BodyAccelerometer-Jerk-mean()-Y
- Freq-BodyAccelerometer-Jerk-mean()-Z
- Freq-BodyAccelerometer-Jerk-std()-X
- Freq-BodyAccelerometer-Jerk-std()-Y
- Freq-BodyAccelerometer-Jerk-std()-Z
- Freq-BodyAccelerometer-Jerk-meanFreq()-X
- Freq-BodyAccelerometer-Jerk-meanFreq()-Y
- Freq-BodyAccelerometer-Jerk-meanFreq()-Z
- Freq-BodyGyroscope--mean()-X
- Freq-BodyGyroscope--mean()-Y
- Freq-BodyGyroscope--mean()-Z
- Freq-BodyGyroscope--std()-X
- Freq-BodyGyroscope--std()-Y
- Freq-BodyGyroscope--std()-Z
- Freq-BodyGyroscope--meanFreq()-X
- Freq-BodyGyroscope--meanFreq()-Y
- Freq-BodyGyroscope--meanFreq()-Z
- Freq-BodyAccelerometer-Magnitude--mean()
- Freq-BodyAccelerometer-Magnitude--std()
- Freq-BodyAccelerometer-Magnitude--meanFreq()
- Freq-BodyBodyAccelerometer-JerkMagnitude--mean()
- Freq-BodyBodyAccelerometer-JerkMagnitude--std()
- Freq-BodyBodyAccelerometer-JerkMagnitude--meanFreq()
- Freq-BodyBodyGyroscope-Magnitude--mean()
- Freq-BodyBodyGyroscope-Magnitude--std()
- Freq-BodyBodyGyroscope-Magnitude--meanFreq()
- Freq-BodyBodyGyroscope-JerkMagnitude--mean()
- Freq-BodyBodyGyroscope-JerkMagnitude--std()
- Freq-BodyBodyGyroscope-JerkMagnitude--meanFreq()
