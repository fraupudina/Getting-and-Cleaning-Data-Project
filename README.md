# Getting-and-Cleaning-Data-Project
Course project : UCI HAR Dataset

All data materials, run_analysis.rscript and merged and cleaned datasets files (text file) are placed in the UCI HAR Dataset folder

Steps:

Clone a copy of the UCI HAR Dataset folder into your R working directory

In RStudio: 
1. Set the working directory to point to UCI HAR Dataset folder. Either using the setwd command in R console or using the :Set Working Directory" option in "Session" button menu.

2. Type command : source("run_analysis.R")
  - this script will read data (text files) from the "Test" & "Train" folders using the read.table command
  - it then merges the datasets X_test with X_train || Y_test with Y_train || subject_test with subject_train into 1 datasets
  - then it will extract data that have mean & standard deviation.
  - descriptive activity name from activity_label.txt are used to name the the activities in the data set. 
  - Named the datasets as cleaned
  - write cleaned datasets to a text file : merged_mean_stddeviation.txt 
  - create a second dataset (result) to store average of each variable,activities & subjects
  - write result dataset to a text file : averageofeach_variable_activities_subject.txt
  
3. View(cleaned) : to view the mean & standard deviation dataset for merged data between training & test datasets 

4. View(result) : to view the 2nd tidy datasets for average of each variables, activities & subjects

Or you may open separately the following files in any program that can read text file

a. merged_mean_stddeviation.txt

b. averageofeach_variable_activities_subject.txt

