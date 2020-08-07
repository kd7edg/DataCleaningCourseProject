# Getting and Cleaning Data Course Project
# Author: Julio Camara
# Date: 6-Aug-2020

# Load train sets
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Load test sets
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load features
features <- read.table("./UCI HAR Dataset/features.txt")

# concatenate columns for subject, activity and sensor signals
train <- cbind(subject_train, y_train, x_train)

# concatenate columns of y_test and x_test
test <- cbind(subject_test, y_test, x_test)

# merge test and train tables
tt <- rbind(train, test)

# rename first column to activity
names(tt)[1] <- "Subject"
names(tt)[2] <- "Activity"

# Uses descriptive activity names to name the activities in the data set
tt$Activity <- cut(tt$Activity, 6, 
                   labels = c("walking", "walking_upstairs", "walking_downstairs", 
                              "sitting", "standing", "laying"))

# rename rest of columns to feature names
names(tt)[3:563] <- features$V2

# get index of all columns that has either *-std() or *-mean()
i<-grep('-std\\(\\)$|-mean\\(\\)$', names(tt))

# extract subject, activity, std and mean columns/measurements
sm <- select(tt, Subject, Activity, i)

# rename labels to have more descriptive names
names(sm) <- gsub("^t", "Time", names(sm))
names(sm) <- gsub("^f", "Frequency", names(sm))
names(sm) <- gsub("Acc", "Accelerometer", names(sm))
names(sm) <- gsub("Mag", "Magnitude", names(sm))
names(sm) <- gsub("Gyro", "Gyroscope", names(sm))
names(sm) <- gsub("BodyBody", "Body", names(sm))
names(sm)<-gsub("-mean\\(\\)", "Mean", names(sm))
names(sm)<-gsub("-std\\(\\)", "StdDev", names(sm))
names(sm)<-gsub("\\(\\)", "", names(sm))

# create final tidy data set with the average of each variable for each activity
# and each subject
tidydata <- sm %>%
  group_by(Subject, Activity) %>%
  summarize_all(list(mean))

# store tidydata to submit to github
write.table(tidydata, "tidyData.txt", row.name=FALSE)

