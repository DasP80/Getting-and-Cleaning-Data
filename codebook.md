# Code Book

This code book describes the data used in this project, and creates a tidy data set.

# Overview

30 volunteers, within an age bracket of 19-48 years, performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. The smartphone captured various data about their movements.

# Explanation of each file

•	features.txt: Names of the 561 features.

•	activity_labels.txt: Names and IDs for each of the 6 activities.

•	X_train.txt: 7352 observations, 561 features.

•	subject_train.txt: 7352 observations, each denoting the ID of the subject / volunteer for each of the observations in X_train.txt.

•	y_train.txt: 7352 observations, each denoting the ID of the activity for each of the observations in X_train.txt.

•	X_test.txt: 2947 observations, 561 features.

•	subject_test.txt: 2947 observations, denoting the ID of the volunteer related to each of the observations in X_test.txt.

•	y_test.txt: 2947 observations, denoting the ID of the activity related to each of the observations in X_test.txt.

This analysis is performed using only the above files , and did not use the raw signal data. Therefore, the data files in the "Inertial Signals" folders were ignored.

# Processing steps

1.	All of the relevant data files were read into data frames, appropriate column names were added. features and labels are combined for each training and testign data. The training and test sets were combined into a single data set.

2.	Columns those contain the exact string "mean" or "std" are used for analysis for each subject and activity. This left 81 feature columns.

3.	Added a column for activity name after merging the dataframe with activity dataframe.

4.	A tidy data set was created containing the mean of each feature for each activity and each subject. Each subject has 6 rows in the tidy data set (one row for each activity). Since there are 30 subjects, there are a total of 180 rows.

5.	The tidy data set was output to a CSV file and txt file.


