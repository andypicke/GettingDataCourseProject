# GettingDataCourseProject

## Course Project for Coursera "Getting and Cleaning Data" course

## Andy Pickering

This project deals with data collected from accelerometers in Samsung Galaxy S smartphones; the data collection is described at [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The dataset for this project was downloaded from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script runanalysis.R does the following to the data:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The summary dataset produced in step 5 is save in *means.txt*.

See codebook.md for additional descriptions of the data and variables.