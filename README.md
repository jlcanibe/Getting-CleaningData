# Getting and Cleaning Data Project
## How the script works
## Read the activity labels and features
The first step in the script reads the activity_labels and the features text files
to use them later for labeling the Activity column with the value associated,
the features file will be used for naming the columns of the merged set
aLabels <- read.table("activity_labels.txt")
fLabels <- read.table("features.txt")


##Read Data
The next section of the script reads the test and train data and binds them in one set:
x <- rbind(read.table("./test/x_test.txt"),read.table("./train/x_train.txt"))
With the set already merged, the column names are set using the colnames that were read from features.txt on step 1
colnames(x) <- fLabels$V2
Subset only the columns mean and std using grepl
stat<-x[,grepl("mean[:(:]", colnames(x)) | grepl("std[:(:]", colnames(x))]

## Reading and binding the sets corresponding to activities and subjects
###Read Activity Data
y <- rbind(read.table("./test/y_test.txt"),read.table("./train/y_train.txt"))
Set Labels instead of values using activity_labels.txt
y$V1 = factor(y$V1,labels=aLabels$V2)
colnames(y)<-c("Activity")
###Read  Subject Data
s <- rbind(read.table("./test/subject_test.txt"), read.table("./train/subject_train.txt"))
colnames(s)<-c("Subject")

## Bind Columns Subject - Activity - Data
dat <- cbind(s,y,stat)

##Get the average for the data set
tidy <- aggregate(dat[, -(1:2)], list(Subject=dat$Subject,Activity=dat$Activity), mean)

## Write the tidy data set
write.table(tidy, 'tidy.txt', row.name=FALSE)
