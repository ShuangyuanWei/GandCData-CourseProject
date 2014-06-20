#setwd("/Users/shuangyuan/Desktop/Coursera/Coursera R/Data/UCI HAR Dataset")
setwd("H:/Coursera/R/Data/UCI HAR Dataset")
install.packages("plyr")
library(plyr)
library(reshape2)

### LOAD "features.txt" TO CREATE HEADER 
### AND ACTIVITY LABEL AS LOOKUP TABLE FOR FUTURE USE ###

activity_label<-read.table("activity_labels.txt")
## create and clean header
header<-read.table("features.txt")
head(header,2)
header2=t(header)
header3=header2[2,]
header4=make.names(header3)
header5<-gsub("\\.+","\\.",header4)


### LOAD AND MODIFY TRAIN DATASETS ######
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")
#dim(X_train)
#dim(y_train)

## combine train dataset with header to get column names
names(X_train)<-c(header5)
## combine subject and activity label with master train set
train=cbind(X_train,cbind(subject_train,y_train))
names(train)[562] <- "subject"
tail(train)
## join with the activity description
train_activity=arrange(join(train,activity_label),V1)
## rename the merged column names
names(train_activity)[563] <- "activity.label"
names(train_activity)[564] <- "activity.description"
#head(train_activity,3)
#tail(train_activity,6)

### LOAD AND MODIFY TEST ÍDATA ########
X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")
names(X_test)<-c(header5)
test=cbind(X_test,cbind(subject_test,y_test))
names(test)[562] <- "subject"
## join with the activity description
test_activity=arrange(join(test,activity_label),V1)
## rename the merged column names
names(test_activity)[563] <- "activity.label"
names(test_activity)[564] <- "activity.description"

### STACK TRAIN AND TEST DATASETS
train_test=rbind(train_activity,test_activity)

### Extracts only the measurements on the mean and standard deviation 
### for each measurement. 
train_test_clean=train_test[ , grepl( "mean", names( train_test ))
                                |grepl( "std", names( train_test ))
                                |grepl( "subject", names( train_test ))
                                |grepl( "activity", names( train_test ))]
train_test_clean<- train_test_clean[c(80,81,82,c(1:79))]


### AGGREGATE BY SUBJECT AND ACTIVITY FOR AVERAGE OF EACH VARIABLE###

train_test_avg=ddply(train_test_clean,
                     .(subject,activity.label,activity.description)
                     ,numcolwise(mean))

#### OUTPUT THE FINAL DATASET TO A .txt FILE ###
write.table(train_test_avg, 
            "H:/GandCData-CourseProject/tidydata.txt", sep="\t")
