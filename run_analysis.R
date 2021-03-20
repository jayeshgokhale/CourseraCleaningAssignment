#Programming Assignment Week 4
rm(list=ls())
library(dplyr) 

#Loading Train Variables
subject.train <- read.table("subject_train.txt")
x.train <- read.table("X_train.txt")
y.train <- read.table("y_train.txt")

#Loading Test Variables
subject.test <- read.table("subject_test.txt")
x.test <- read.table("X_test.txt")
y.test <- read.table("y_test.txt")

names(subject.train) <- "subject"
names(subject.test) <- "subject"

#Loading Features
features <- read.table("features.txt")
names(features) <- c("id","featurename")

#Assigning Names to X.train and X.test
names(x.train) <- features$featurename
names(x.test) <- features$featurename

#Binding Subject to x var
x.train <- cbind(subject.train,x.train)
x.test <- cbind(subject.test,x.test)

#Loading Activity
activities <- read.table("activity_labels.txt")
names(activities) <- c("activityid","activityname")

#Fetching Activity Names for the target values. Now the R Merge function sorts by default
#Hence we need to set sort to FALSE
names(y.train) <- "activityid"
names(y.test) <- "activityid"

y.train <- merge(y.train,activities,sort=FALSE)
y.test <- merge(y.test,activities,sort=FALSE)

#Column Bind x and y
df.train <- cbind(x.train,y.train)
df.test <- cbind(x.test,y.test)
df.full <- rbind(df.train,df.test)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Based on the wordings above I am taking only the values with -mean() or -std()
mean.sd.col.pos <- grep("-(mean|std)\\(\\)",colnames(df.full),ignore.case = TRUE)
df.full <- df.full[c(1,mean.sd.col.pos,ncol(df.full))]

df.new <- df.full %>% group_by(subject,activityname) %>% summarise(across(everything(), list(mean)))

write.table(df.new,"summarized.txt",row.names=FALSE)

