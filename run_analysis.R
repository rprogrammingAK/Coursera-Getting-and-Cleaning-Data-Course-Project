## Reading training and testing data
activityL = read.table('./UCI HAR Dataset/activity_labels.txt')
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table('./UCI HAR Dataset/features.txt')
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Naming the columns,merging the data, extacting the mean & standard deviation
colnames(Xtrain) <- features[,2] 
colnames(Xtest) <- features[,2] 
colnames(Ytest) <- "activity"
colnames(Ytrain) <-"activity"
colnames(subjectTrain) <- "subject"
colnames(subjectTest) <- "subject"
colnames(activityL) <- c('activity','activityType')
data_train <- cbind(Ytrain, Xtrain, subjectTrain)
data_test <- cbind(Ytest, Xtest, subjectTest)
data_final <- rbind(data_train, data_test)
colNames <- colnames(data_final)
requiredMeanStd <- (grepl("activity" , colNames) | grepl("subject" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames) )
ex_tMeanStd <- data_final[ , requiredMeanStd == TRUE]
ex_activitydata <- merge(ex_tMeanStd, activityL, by='activity',all.x=TRUE)

## Creating the second tidy dataset
Tidydata <- aggregate(. ~subject + activity, ex_activitydata, mean)
Tidydata <- Tidydata[order(Tidydata$subject, Tidydata$activity),]
write.table(Tidydata, "Tidy.txt", row.name=FALSE)
