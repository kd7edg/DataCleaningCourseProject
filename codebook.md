# Code Book - Getting and Cleaning Data Course Project
## Author: Julio Camara
## Date: 7-Aug-2020

To reproduce this analysis, the first step is to download the data set in the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once the zip file was downloaded, it was expanded into the _"UCI HAR Dataset"_ directory.

The `run_analysis.R` script was created to performs the data preparation. It loads, merges and manipulates the data to make it tidy. I followed the following steps to fulfill the project requirements:
1. Load train, test, subjects, activities and features tables

The original data set was split into two parts: train (70% of the observations) and test (30% of the observations). These two needed to be combined. Also the observations did not have a column for the subject or activity type. These were separated in their own file and also needed to be merged into the main data set.

The file `train/X_train.txt` contains the training observations (numeric values from -1 to 1) and was imported into dataframe `x_train` (Dimentions 7352 x 561).

The file `train/y_train.txt` contains a list of activity codes, integer (1:6), which was loaded into the `y_train` dataframe (Dimention 7352 x 1). 

The activity lables were found in the `activity_labels.txt` and are reproduced here:
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```
These labels will be used later.

There were 30 people that participated in collecting data for this experiment. They are referred to as subjects and were stored in file `train/subject_train.txt` as integers (1:30). This file was loaded to the `subject_train` dataframe, which has dimmentions 7352 x 1.

The `features.txt` file was loaded to dataframe `features`. It contains the variable labels.

The files in the test folder had the same type of format and content, except that the number of rows was 2947. They were loaded to the following datasets:
```
test/X_test.txt -> x_test
test/y_test.txt -> y_test
test/subject_test.txt -> subject_test
```

2. Join the subject, activity and measurements tables

The subject, activity and measurement tables had the same number of rows (7352 for train) and were therefore combined with cbind function into a new dataframe called `train`. The same was done for the test tables (2947 rows for test) and a new dataframe called `test` was created.

3. Combine the train and test tables

Now that all the subject, activity and measurement data are in one place for train and test data, it's time to combine these two tables to have a single table to work from. A new dataframe called `tt` was created with rbind.

4. Replace the integer codes in the activity column to more descriptive names (walking, laying, etc.)

As mentioned above the activity column had integer codes, which are not very descriptive. So I replaced them with factor type using the cut function.

5. Rename the column names with feature names

Another requirement for the project was to use appropriate labels with descriptive variable names. Therefore the variable labels were
replaced with data from the features table.

6. Extract subject, activity and standard deviation, mean tables into a new table.

To extract only the variables needed for the project analysis, I selected subject, activity and variables with either *-std() or *-mean(). The subject of data was store into a new dataframe called `sm`.

7. Replace the abreviated symbols in the column labels with more descriptive names

Some portions of the variable names were too abbreviated therefore I expanded them to be more descriptive. For example, t -> time, Mag -> Magniture, etc. 

8. Creates a final tidy data set with the average of each variable for each activity and each subject.

The final cleanup was to summarize the data by collecting the average of each mean and standard deviation variable for each subject and activity. This was accomplish by using chaining, group by and sumarize_all.

The final dataframe, `tidydata`, has dimention of 180 x 20. Each Mean and StdDev variable is num, the Subject is int, and Activity is factor.

9. Write tidydata to file so it can be submited to GitHub

The last portion of the project was to download the tidydta table to a file and upload all the files to GitHub.