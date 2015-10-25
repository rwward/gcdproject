library(dplyr)

##1.
#read feature names
featnames <- read.table(file="./gdproj/features.txt", header=F, nrows=561)
featnames$V2


#read three elements of test set
testdata <- read.table(file="./gdproj/test/X_test.txt", header=FALSE, nrows=2947, col.names=featnames$V2)
testactivities <- read.table(file="./gdproj/test/Y_test.txt", header=FALSE, nrows=2947, col.names="activity")
testsubjects <- read.table(file="./gdproj/test/subject_test.txt", header=FALSE, nrows=2947, col.names="subject")

#read three elements of training set
traindata <- read.table(file="./gdproj/train/X_train.txt", header=FALSE, nrows=7352, col.names=featnames$V2)
trainactivities <- read.table(file="./gdproj/train/Y_train.txt", header=FALSE, nrows=7352, col.names="activity")
trainsubjects <- read.table(file="./gdproj/train/subject_train.txt", header=FALSE, nrows=7352, col.names="subject")

#bind together elements of test set
testall <- cbind(testsubjects, testactivities, testdata)

#bind together elements of training set
trainall <- cbind(trainsubjects, trainactivities, traindata)

#bind test and training set
alldata <- rbind(trainall, testall)


##2.
#keep only mean and standard deviation variables, not including meanFreq
#find var
meanvars <- grepl("mean()", featnames$V2, fixed=TRUE)
sum(meanvars)
stdvars <- grepl("std()", featnames$V2)
varstokeep <- as.logical(meanvars + stdvars)

#add two trues to varstokeep so that it keeps activity and subject IDs at start of dataset
varstokeep <- c(TRUE, TRUE, varstokeep)

#subset alldata
subdata <- alldata[,varstokeep]


##3. 
#read in activity labels
activitylabels <- read.table("./gdproj/activity_labels.txt")
#convert activity variable to factor, adding labels
subdata$activity <- factor(subdata$activity, labels=activitylabels$V2)

##4.
#Descriptive variable names were added to the dataset in step 1

##5.
#create new dataset where each row represents a certain subject doing one activity
#and the variables are averages of the measurements for that activity

#create new dataframem 
summarydata <- subdata %>% group_by(activity, subject) %>% summarize_each(funs(mean))





