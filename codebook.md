
# Codebook for Course Project

A list of measured variables is contained in /UCI HAR Dataset/features.txt , and additional info on those variables is contained in /UCI HAR Dataset/features_info.txt

runanalysis.R - This script loads data, merges test and training data sets, tidys the data, and creates another tidy data set (“means.txt”) with means each variable for each subject and activity.

means.txt contains a tidy data set with mean values of each variable computed for each subject and activity. The first 3 variables are:

**subjectid** - integer - ID identifying subject. 

**activity** - character - Name of activity

type - character - Type of data: “test” or “train”’

The rest of the variables names are the same as the original data set, and value for those variables in mean.txt are the average for each subject id and activity.