### Andy Pickering
### Getting and Cleaning Data - Course Project

# This script:
#(1)Merges the training and the test sets to create one data set.
#(2)Extracts only the measurements on the mean and standard deviation for each measurement.
#(3)Uses descriptive activity names to name the activities in the data set
#(4)Appropriately labels the data set with descriptive variable names.
#(5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

rm(list=ls())
library(dplyr)
setwd("/Users/Andy/DataSciCoursera/GettingCleaningData/GettingDataCourseProject/GettingDataCourseProject")

# load test subject data
testsubjects<-read.table("./UCI HAR Dataset/test/subject_test.txt")
# rename column with more descriptive name
colnames(testsubjects)<-"subjectid"

# load training subject data
trainsubjects<-read.table("./UCI HAR Dataset/train/subject_train.txt")
# rename column with more descriptive name
colnames(trainsubjects)<-"subjectid"

# load features list
features<-read.table("./UCI HAR Dataset/features.txt")
# features$V2 is a list of the variable names in X_test etc.
# find the variables for mean and standard deviation, which are what we want to keep
mean_ids<-grep("mean()",features$V2)
std_ids<-grep("std()",features$V2)

# load test data
testdat<-read.table("./UCI HAR Dataset/test/X_test.txt")
# only keep mean and std variables
testdat_small<-testdat[,c(mean_ids,std_ids)]
# rename columns with descriptive names from features
colnames(testdat_small)<-features$V2[c(mean_ids,std_ids)]
# clean up variable names - make lower case
colnames(testdat_small)<-tolower(names(testdat_small))

# load activity codes for test
testlabels<-read.table("./UCI HAR Dataset/test/y_test.txt")
# load acitivty labels
activitylabels <- read.table(("./UCI HAR Dataset/activity_labels.txt"))
# load activity codes for training
trainlabels<-read.table("./UCI HAR Dataset/train/y_train.txt")


# load training data
traindat<-read.table("./UCI HAR Dataset/train/X_train.txt")
# only keep mean and std variables
traindat_small<-traindat[,c(mean_ids,std_ids)]
# rename columns with descriptive names from features
colnames(traindat_small)<-features$V2[c(mean_ids,std_ids)]
# clean up variable names - make lower case
colnames(traindat_small)<-tolower(names(traindat_small))

# merge the test and train data sets together
# variables will be be: subject,activity,type(train/test),mean...,std...
test_comb <- data.frame(subjectid=testsubjects$subjectid,activity=testlabels$V1,type=c("test"),testdat_small)
train_comb <- data.frame(subjectid=trainsubjects$subjectid,activity=trainlabels$V1,type=c("train"),traindat_small)
alldat<-rbind(test_comb,train_comb)

# Uses descriptive activity names to name the activities in the data set
# change activity data from #s to desciptive characters
alldat$activity[which(alldat$activity==1)]<-"walking"
alldat$activity[which(alldat$activity==2)]<-"walkingupstairs"
alldat$activity[which(alldat$activity==3)]<-"walkingdownstairs"
alldat$activity[which(alldat$activity==4)]<-"sitting"
alldat$activity[which(alldat$activity==5)]<-"standing"
alldat$activity[which(alldat$activity==6)]<-"laying"

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# subject, activity, vars

# list of variables we want to compute mean for
varlist<-names(alldat[4:82])

## loop through each id and activity, and compute mean for each variable
# list of ids
ids<-1:30
# list of activities
actlist<-unique(alldat$activity)
# make a new empty data frame 'means' to store results in
col.names<-names(alldat)
colClasses<-c("integer",rep("character",2),rep("double",79))
means <- read.table(text = "",colClasses = colClasses,col.names = col.names)
# row index
whrow<-1
for (i in seq_along(ids)){
    
    for (z in seq_along(actlist)) {
        print(whrow)
        means[whrow,1]<-ids[i]
        means[whrow,2]<-actlist[z]
        # filter data for just this id and activity
        datm<-filter(alldat,subjectid==ids[i] & activity==actlist[z])
        # column means for this id and activity
        cms<-colMeans(datm[,4:82])
        for (q in seq_along(varlist)){
            means[whrow,q+3]<-cms[q]
        }
        whrow<-whrow+1
    }
}


# save the data
write.table(means,"./means.txt",row.name=FALSE)
