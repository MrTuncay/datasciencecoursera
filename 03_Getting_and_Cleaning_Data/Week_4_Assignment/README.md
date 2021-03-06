# Getting and Cleaning Data

This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization.

# Raw Data
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.


# About the script and the tidy dataset
The R script called run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script will create a tidy data set containing the means and standard deviations of all the columns per test subject and per activity.

Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.
