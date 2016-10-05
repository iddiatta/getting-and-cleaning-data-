
##############################################################################
################    Getting and Cleaning Data Course Project  ################ 
#########              Ibrahima D.D.  October 4 2016                 ######### 
##############################################################################

## setting the wd (working directory)
wd <-setwd("/Users/ibrahimadinadiatta/Desktop/Data Science Specialization/Cours_Getting_and_Cleaning_Data/UCI_HAR_Dataset/project_data ")



## uploading the activitylabels df (data frame)  
activityLabels <- read.csv("activity_labels.txt", sep="", header=FALSE)

## uploading the features df  
features <- read.csv("features.txt", sep="", header=FALSE)
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()-]', '', features[,2])


## uploading the training data set 
X_train<- read.csv ("X_train.txt", sep="", header=FALSE)


## uploading the data frame of labels 
y_train <- read.csv("y_train.txt", sep="", header=FALSE)


## uploading subject data set 
subject_train <- read.csv("subject_train.txt", sep="", header=FALSE)


## merging the 3 df : subject train, y_train, X_train
training <- cbind(X_train,y_train,subject_train)


## getting the testing data set 

X_test <- read.csv ("X_test.txt", sep="", header=FALSE)

y_test <- read.csv("y_test.txt", sep="", header=FALSE)

subject_test <- read.csv("subject_test.txt", sep="", header=FALSE)

testing <- cbind(X_test,y_test, subject_test)

# Merge training and testing datasets
Combined_Data = rbind(training, testing)

#  naming the colunms of the data set of the experience

colnames(Combined_Data) <- c(features$V2, "Activity", "Subject")


## Get only the data on mean and std. dev.
TargetCol <- c(grep(".*Mean.*|.*Std.*", features[,2]),562,563)
Combined_Data <- Combined_Data[,TargetCol]

# naming the col of the df 
colnames(Combined_Data) <- c(features$V2, "Activity", "Subject")
 
 ## here we'll label the activity levels 
 
 class(Combined_Data$Activity)
 
 Combined_Data$Activity<- as.factor(Combined_Data$Activity)
 Combined_Data$Subject <- as.factor(Combined_Data$Subject)
 
 Combined_Data$Activity <- ordered(Combined_Data$Activity, levels=as.integer(levels(Combined_Data$Activity)), labels=as.character(activityLabels$V2))
 
## 

 tidy <- aggregate(Combined_Data, by=list(Activity=Combined_Data$Activity,Subject=Combined_Data$Subject), FUN = mean)
 
 tidy <- tidy [,1:42]
 
 write.table(tidy, "tidy.txt", sep="\t")
 
 
 
 
