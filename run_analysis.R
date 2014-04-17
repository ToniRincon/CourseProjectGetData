library(reshape2)
run_analysis <- function() {
  
  # read features.txt
  features_labels = read.table(file="features.txt", col.names=c("feature_id","feature"))
  # clean features labels
  features_labels$feature = gsub("[,-]",".",gsub("[()]","",features_labels$feature))
  
  # read activity_labels.txt
  activities_labels = read.table(file="activity_labels.txt", col.names=c("activity_id","activity"))
  
  # read subject_train.txt and subject_test.txt to be combined
  subjects_train = read.table(file="train/subject_train.txt", col.names=c("subject"))
  subjects_test = read.table(file="test/subject_test.txt", col.names=c("subject"))
  subjects = rbind(subjects_train,subjects_test)
  rm(subjects_train)
  rm(subjects_test)
  
  # read X_train.txt and X_test.txt to be combined
  # features names are taken from features
  features_train = read.table(file="train/X_train.txt", col.names=features_labels$feature)
  features_test = read.table(file="test/X_test.txt", col.names=features_labels$feature)
  features = rbind(features_train,features_test)
  rm(features_train)
  rm(features_test)
  
  # read y_train.txt and y_test.txt to be combined
  activities_train = read.table(file="train/y_train.txt", col.names=c("activity_id"))
  activities_test = read.table(file="test/y_test.txt", col.names=c("activity_id"))
  activities = rbind(activities_train,activities_test)
  rm(activities_train)
  rm(activities_test)
  
  # select only -mean() and -std() features
  features_labels=features_labels[grep("\\.(mean|std)\\b",features_labels$feature),]
  features = features[,features_labels$feature]
  
  # merge activity names and activity labels deleting activity_id
  activities$activity_order = 1:nrow(activities)
  activities = merge(activities,activities_labels)
  activities = activities[order(activities$activity_order),]
  activities$activity_id = NULL
  activities$activity_order = NULL
  
  # combine subjects, activities and features
  data_raw = cbind(subjects,activities,features)
  
  # finally melt variables using subject and activity, and aggrefate using mean
  data_melted = melt(data_raw,id=c("subject","activity"))
  data_tidy = dcast(data_melted,subject+activity~variable,mean)
}  