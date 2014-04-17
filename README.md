### Introduction

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### README.md

README.md explains how all of the scripts work and how they are connected.

### CodeBook.md

CodeBook.md describes the variables, the data, and transformations performed to clean up the data.

### run_analysis.R

1. reads features.txt into a data.frame features_labels assigning colunm names feature_id and feature, to avoid problem with parenthesis and special characters not permitted in column names, they are deleted from feature names.

2. reads activity_labels.txt into a data frame activities assigning column names activity_id and activity

3. reads subjects_train.txt and subject_test.txt into two data frames subjects_train and subjects_test assigning column names subject. Both data frames are row combined into a data frames subjects. Both data frames are deleted from memory.

4. reads X_train.txt and X_test.txt into two data frames features_train and features_test assigning column names the values in features_labels read from features.txt. Both data frames are row combined into a data frames features. Both data frames are deleted from memory.

5. reads y_train.txt and y_test.txt into two data frames activities_train and activities_test assigning column names activity_id. Both data frames are row combined into a data frames activities. Both data frames are deleted from memory.

6. features_labels is filtered using grep to contain only features names refered to mean and std. features is filtered using features_labels reducing the number of columns

7. activities and activities_labels are merged using activity_id common in both data frames, column activity_id is deleted

8. subjects, activities (containing activity names) and features (containing mean and std features) are row combined into a data frame data_raw

9. data_raw is melted using subject and activity and decasted calculating mean of the variables for each subject and activity



