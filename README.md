# Getting and Cleaning Data Course Project
## Author: Julio Camara
## Date: 7-Aug-2020


This project contains the following files:
 * codebook
 * run_analysis.R
 * tidyData.txt and
 * this README file

The dataset is from the Human Activity Recognition Using Smartphones Dataset, Version 1.0.

CodeBook.md a code book that describes the data, variables and transformation that I performed according to the project instructions.

`run_analysis.R` has a series of R commands/statements that performs the data preparation.
It has the following sections:
1. Load train, test and features tables
2. Join the subject, activity and measurements tables
3. Replace the integer codes in the activity column to more descriptive names (walking, laying, etc.)
4. Rename the column names with feature names
5. Extract subject, activity and standard deviation, mean tables into a new table.
6. Replace the abreviated symbols in the column labels with more descriptive names
7. Creates a final tidy data set with the average of each variable for each activity and each subject.

`tidyData.txt` is the cleanup data that was the result of running the script above.