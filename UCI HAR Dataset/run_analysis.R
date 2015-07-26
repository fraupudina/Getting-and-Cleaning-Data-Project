# Data URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Project instructions:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


# Part 1. Merges the training and the test sets || rbind

# A. Merges the train & test data (X_train : X_test)
dat1 <- read.table("train/X_train.txt")
dat2 <- read.table("test/X_test.txt")
X <- rbind(dat1, dat2)

# B. Merges the train & test data (Y_train : Y_test)
dat1 <- read.table("train/y_train.txt")
dat2 <- read.table("test/y_test.txt")
Y <- rbind(dat1, dat2)

# C. Merges the train & test data (subject_train : subject_test)
dat1 <- read.table("train/subject_train.txt")
dat2 <- read.table("test/subject_test.txt")
S <- rbind(dat1, dat2)


# Part 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Read and select mean & std deviation from features.txt file

features <- read.table("features.txt")
good_data <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) # search matches for mean & std deviation : eliminate data that does not match with mean or std deviation
X <- X[, good_data]
names(X) <- features[good_data, 2]
names(X) <- gsub("\\(|\\)", "", names(X)) # replace \\ with ""
names(X) <- tolower(names(X)) # translate names(x) to lowercase

# 3. Uses descriptive activity names to name the activities in the data set.
# Read activity_labels,text file.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2]))) # replace _ with "" & set activities character to lowercase
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_mean_stddeviation.txt") # 1st set of dataset|| Merged, mean and std deviation

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
# Variable declarations

uniq_sub = unique(S)[,1] # Return unique data on Subjects || eliminate duplicates
total_sub = length(unique(S)[,1]) # Return no of subjects
total_xtvt = length(activities[,1]) # Return no of activities
numCols = dim(cleaned)[2] # Specify dimension of leaned dataset to 2
result = cleaned[1:(total_sub*total_xtvt), ]

row = 1
for (s in 1:total_sub) {
  for (a in 1:total_xtvt) {
    result[row, 1] = uniq_sub[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "averageofeach_variable_activities_subject.txt")