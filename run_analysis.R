
# download the dataset from the URL
if (!file.exists("./data")) {dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "./data/uci_smartphone_data.zip"
download.file(fileurl, destfile = filename,method = "curl")

# Unzip dataSet 
unzip(zipfile="./data/uci_smartphone_data.zip",exdir="./data")

# Reading activity labels:
activity = read.table('./data/UCI HAR Dataset/activity_labels.txt')

activity

# assign column names
names(activity) <- c("activityId", "activityName")

activity

# Reading feature data:
features <- read.table('./data/UCI HAR Dataset/features.txt')
head(features, 5)

# Reading trainings table features
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
head(x_train)

dim(x_train)

# assign column names to x_train data
colnames(x_train) <- features[,2]

head(x_train)

# Reading trainings table labels
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
head(y_train)

dim(y_train)

#assign column name
colnames(y_train) <-"activityId"

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
head(subject_train)

dim(subject_train)

colnames(subject_train) <- "subjectId"

# Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[,2] 



y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "activityId"


subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- "subjectId"

dim(x_test)

dim(y_test)

# 1. Merge the training and the test sets to create one data set.

train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)
all_data <- rbind(train, test)

dim(train)

dim(test)

dim(all_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

data <- all_data[, grepl("subjectId|activityId|mean|std",names(all_data)) == TRUE]

dim(data)

head(data,3)

# 3. Use descriptive activity names to name the activities in the data set
data_with_activity_names <- merge(data, activity, by= "activityId" )

library(dplyr)

# sample few rows from dataframe (sample_n using dplyr) and check the column activityName to ensure values are populated
sample_n(data_with_activity_names, 5)

# 4. Appropriately labels the data set with descriptive variable names.
names(data_with_activity_names) <- gsub("\\()", "", names(data_with_activity_names) )
names(data_with_activity_names) <- gsub("mean", "Mean", names(data_with_activity_names) )
names(data_with_activity_names) <- gsub("std", "Std", names(data_with_activity_names) )
names(data_with_activity_names) <- gsub("BodyBody", "Body", names(data_with_activity_names))
names(data_with_activity_names) <- gsub("^t", "Time", names(data_with_activity_names))
names(data_with_activity_names) <- gsub("^f", "Frequency", names(data_with_activity_names))

sample_n(data_with_activity_names, 5)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
second_tidy_data_set <- data_with_activity_names %>% group_by(activityId,activityName, subjectId) %>% summarise_all(mean)

write.table(second_tidy_data_set,"second_tidy_data_set.txt",sep="\t", row.names = TRUE, quote = FALSE)
write.csv(second_tidy_data_set,"second_tidy_data_set.csv",row.names = TRUE, quote = FALSE)

dim(second_tidy_data_set)
