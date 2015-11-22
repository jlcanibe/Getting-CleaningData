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

##Bind Columns Subject - Activity - Data and generate the Tidy set
dat <- cbind(s,y,stat)
Get the average for the data set
tidy <- aggregate(dat[, -(1:2)], list(Subject=dat$Subject,Activity=dat$Activity), mean)
Write the tidy data set
write.table(tidy, 'tidy.txt', row.name=FALSE)

#CodeBook

I refer you to the README and features.txt files in the original dataset to learn more about the feature selection for this dataset. And there you will find the follow description:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
I included all variables having to do with mean or standard deviation.

The first columns correspond to the Subject and Activity

* Subject
* Activity

For this derived dataset, these signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were kept for this assignment are: 

* mean(): Mean value
* std(): Standard deviation

