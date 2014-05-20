##run_Analysis.R
##Getting and Cleaning Data Course Project

##Install and load any necessary packages.

install.packages("reshape2")
library(reshape2)

##Import Data form UCI folder in working directory

train <- read.table("UCI/train/X_train.txt")
test <- read.table("UCI/test/X_test.txt")
features <- read.table("UCI/features.txt")
Atrain <- read.table("UCI/train/y_train.txt")
Strain <- read.table("UCI/train/subject_train.txt")
Atest <- read.table("UCI/test/y_test.txt")
Stest <- read.table("UCI/test/subject_test.txt")


##Appropriately labels the data set with descriptive activity names.
##Clean up colNames and Name columns of data frames

colNames <- gsub("[[:punct:]]","", features$V2, ignore.case = FALSE, perl = FALSE)
colnames(train) <- colNames
colnames(Strain) <- "Subject"
colnames(Atrain) <- "Activity"
colnames(test) <- colNames
colnames(Stest) <- "Subject"
colnames(Atest) <- "Activity"


##Combine test and train data with corresponding subject and activity  
##Combine testsComplete and trainComplete data into one data set

testsComplete <- cbind(Stest, Atest,test)
trainComplete <- cbind(Strain,Atrain,train)
allData <- rbind(trainComplete,testsComplete)


##Extracts only the measurements on the mean and standard deviation for each measurement. 
##It also extracts Subject and Activity into tidyData.

tidyData <- allData[, grep("mean|std|Subject|Activity", names(data))]


##Uses descriptive activity names to name the activities in the tidyData data set

labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
tidyData$Activity <- labels[tidyData$Activity]


##Creates a second, independent tidy data set with the average of each 
##variable for each activity and each subject.
 
melted = melt(tidyData, id.var = c("Subject", "Activity"))
means = dcast(melted , Subject + Activity ~ variable,mean)


## Write tidy data to space separated text file

write.table(means, file="meansTinyData.txt", sep = " ")



