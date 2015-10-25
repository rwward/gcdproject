# Getting and Cleaning Data Course Project README

This file explains the data cleaning and analysis performed on the Human Activity Recognition Using Smartphones dataset.

## Setup

The script should be run with the files of [this dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the working directory. I unzipped the file and then moved the remaining files and folders from the "UCI HAR Dataset" folder directly into the working directory - so files that started out in the "UCI HAR" folder, like "features.txt", are in the working directory itself, while the test and training sets are in their respective "test" and "train" folders, which are in the working directory.

## Step 1: Merging the test and training sets

First, the script reads the feature names from features.txt, so that they can be used as column names when the rest of the data is read in. Each of the six data files is then read into R. The subject, activity, and measurement files are then bound together for each part of the dataset. These two dataframes are then merged with rbind.

## Step 2: Extracting mean and standard deviation variables

grepl is run on the list of feature names to find the locations of the mean and standard deviation variables. the "fixed=TRUE" parameter is added for the mean() search to exclude meanFreq; the actual meaning of meanFreq is unclear, except that it is clearly not the mean of the measurement, which is what the assignment asked for. These two logical vectors are then added together and converted back to a logical vector. Two "TRUE" values are then added to the start of the resulting vector, so that when it is used to subset the data, it keeps the subject and activity variables. This final "varstokeep" vector is then used to subset the merged dataset.

## Step 3: Creating meaningful activity labels

The activity labels file is read into R. The activity variable in the subsetted dataset is converted into a factor, with the activity labels from the newly created dataframe as the labels.

## Step 4: Descriptive variable names

This step of the assignment actually occurred in step 1, because the data was read in with column names from the features file.

## Step 5: Creating a new tidy dataset with means for each subject and activity
dplyr commands (which was loaded at the beginning of the script) are used for this step. The first line of code groups the subsetted dataset by activity and subject and then uses summarize_each to produce a new dataset with the mean for each other variable for each activity/subject combination. The final line returns the new dataset. This is not especially useful, but the assignment seems to call for it.
