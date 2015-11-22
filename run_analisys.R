#Read Activity - Features Labels
aLabels <- read.table("activity_labels.txt")
fLabels <- read.table("features.txt")

# Read Features Data, Activity, Subject (Test, Train)
#Read Data
x <- rbind(read.table("./test/x_test.txt"),read.table("./train/x_train.txt"))
# Set Colnames for Features Data
colnames(x) <- fLabels$V2
# Subset only the columns mean and std
stat<-x[,grepl("mean[:(:]", colnames(x)) | grepl("std[:(:]", colnames(x))]

#Read Activity Data
y <- rbind(read.table("./test/y_test.txt"),read.table("./train/y_train.txt"))
#Set Labels instead of values using activity_labels.txt
y$V1 = factor(y$V1,labels=aLabels$V2)
colnames(y)<-c("Activity")

#Read  Subject Data
s <- rbind(read.table("./test/subject_test.txt"), read.table("./train/subject_train.txt"))
colnames(s)<-c("Subject")

#Bind Columns Subject - Activity - Data
dat <- cbind(s,y,stat)

#Get the average for the data set
tidy <- aggregate(dat[, -(1:2)], list(Subject=dat$Subject,Activity=dat$Activity), mean)

# Write the tidy data set
write.table(tidy, 'tidy.txt', row.name=FALSE)