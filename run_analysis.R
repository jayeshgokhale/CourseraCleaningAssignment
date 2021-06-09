#Programming Assignment Week 4 test
rm(list=ls())
library(dplyr) 

if (!file.exists("samsung_dataset.zip"))
{
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile="samsung_dataset.zip",method="curl")
  
  unzip("samsung_dataset.zip")
}


#Loading Train Variables
subject.train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
x.train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
y.train <- read.table("UCI HAR Dataset\\train\\y_train.txt")

#Loading Test Variables
subject.test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
x.test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
y.test <- read.table("UCI HAR Dataset\\test\\y_test.txt")

names(subject.train) <- "subject"
names(subject.test) <- "subject"

#Loading Features
features <- read.table("UCI HAR Dataset\\features.txt")
names(features) <- c("id","featurename")

#Assigning Names to X.train and X.test
names(x.train) <- features$featurename
names(x.test) <- features$featurename

#Binding Subject to x var
x.train <- cbind(subject.train,x.train)
x.test <- cbind(subject.test,x.test)

#Loading Activity
activities <- read.table("UCI HAR Dataset\\activity_labels.txt")
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
names(df.new) <- gsub("[\\(\\)]","",names(df.new))
names(df.new) <- gsub("-",".",names(df.new))
names(df.new) <- gsub("_1","",names(df.new))
write.table(df.new,"summarized.txt",row.names=FALSE)

