# Introduction - Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.

The data used on the project is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The script 'run_analysis.R' does the following: 
1. Download the data.
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names.
6. Creates an independent tidy data set with the average of each variable for each activity and each subject.
  
# Script - run_analysis.R

## Download the data

The script will download the data to working directory if the file does not exist.

## Merges the training and the test sets to create one data set

The script will unzip the data and read the data from train and test folder to create one complete data set.

## Extracts only the measurements on the mean and standard deviation for each measurement

The script will then extract measurements that contains mean() or std() in the feature list.

## Uses descriptive activity names to name the activities in the data set

The activity description will be obtained from activity_labels.txt and replaced based on the ID.

## Appropriately labels the data set with descriptive variable names

The data column will be named with the name from feature.txt.

## Creates an independent tidy data set with the average of each variable for each activity and each subject

`library(dplyr)` is used to group and summaries with mean function.

# Output - independent_tidy_data.txt

independent_tidy_data.txt is generated