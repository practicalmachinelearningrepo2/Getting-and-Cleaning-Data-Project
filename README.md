Getting and Cleaning data - Samsung wearables tidy data project
===============================================================

This document explains the processing done on the files and serves as a codebook. 
For your convenience, there is also an .html version included.

1. Setting the working directory, yours will be different.


```r
setwd("C:/kaggle/getting and cleaning data/project")
```

2. Loading features and activity description


```r
features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")
```

3. Loading the test part of data, as well as related subject identifiers.


```r
X_test <- read.table("./test/X_test.txt", quote="\"")
Y_test <- read.table("./test/Y_test.txt", quote="\"")
subject_test <- read.table("./test/subject_test.txt", quote="\"")
```

4. Loading the train part of data, as well as related subject identifiers.


```r
X_train <- read.table("./train/X_train.txt", quote="\"")
Y_train <- read.table("./train/Y_train.txt", quote="\"")
subject_train <- read.table("./train/subject_train.txt", quote="\"")
```

5. Adding subject ids to test data


```r
testSet<-cbind(X_test,subject_test)
testSet<-cbind(testSet,Y_test)
```

6. Adding subject ids to train data


```r
trainSet<-cbind(X_train,subject_train)
trainSet<-cbind(trainSet,Y_train)
```

7. Merging test and train


```r
totalSet<-rbind(trainSet,testSet)
```

8. Adding feature names


```r
colnames(totalSet)<-as.factor(c(as.character(features$V2),"SubjectId","ActivityId"))
```

9. Subseting only to std and mean variables


```r
validFields<-sort(c(grep("-std()",names(totalSet)),grep("-mean()",names(totalSet))))
reducedSet<-totalSet[,c(validFields,562,563)]

reducedSet<-merge(reducedSet,activity_labels,by.x="ActivityId",by.y="V1")
reducedSet <- subset(reducedSet, select = -c(1) )
colnames(reducedSet)[81]<-"ActivityId"
```

10. Creating the tidy data version


```r
tidyData<- aggregate(reducedSet,by=list(reducedSet$SubjectId,reducedSet$ActivityId), FUN=mean)
tidyData<- subset(tidyData,select= -c(82,83))
colnames(tidyData)[1]<-"SubjectId"
colnames(tidyData)[2]<-"ActivityId"
tidyData<-cbind(tidyData[,3:81],tidyData[,1:2])
```

11. Writing it out to file


```r
write.table(tidyData,"tidyData.csv",row.names=FALSE)
```


Large parts of the remained is attributed to the original data set, from (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). It is used here, because it is more productive, and because it is still highly relevant.


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range  
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  



Specific variables in use
==============

"SubjectId" - identifies the test subject by number  
"ActivityId" - identifies the activity by description  

The remaineder is explained in Feature Selection (above).

"tBodyAcc-mean()-X"  
"tBodyAcc-mean()-Y"  
"tBodyAcc-mean()-Z"  
"tBodyAcc-std()-X"  
"tBodyAcc-std()-Y"  
"tBodyAcc-std()-Z"  
"tGravityAcc-mean()-X"  
"tGravityAcc-mean()-Y"  
"tGravityAcc-mean()-Z"  
"tGravityAcc-std()-X"  
"tGravityAcc-std()-Y"  
"tGravityAcc-std()-Z"  
"tBodyAccJerk-mean()-X"   
"tBodyAccJerk-mean()-Y"  
"tBodyAccJerk-mean()-Z"  
"tBodyAccJerk-std()-X"  
"tBodyAccJerk-std()-Y"  
"tBodyAccJerk-std()-Z"  
"tBodyGyro-mean()-X"  
"tBodyGyro-mean()-Y"  
"tBodyGyro-mean()-Z"  
"tBodyGyro-std()-X"   
tBodyGyro-std()-Y"   
"tBodyGyro-std()-Z"  
"tBodyGyroJerk-mean()-X"   
"tBodyGyroJerk-mean()-Y"  
"tBodyGyroJerk-mean()-Z"  
"tBodyGyroJerk-std()-X"  
"tBodyGyroJerk-std()-Y"  
"tBodyGyroJerk-std()-Z"  
"tBodyAccMag-mean()"  
"tBodyAccMag-std()"  
"tGravityAccMag-mean()"   
"tGravityAccMag-std()"  
"tBodyAccJerkMag-mean()"   
"tBodyAccJerkMag-std()"  
"tBodyGyroMag-mean()"  
"tBodyGyroMag-std()"  
"tBodyGyroJerkMag-mean()"   
"tBodyGyroJerkMag-std()"  
"fBodyAcc-mean()-X"  
"fBodyAcc-mean()-Y"  
"fBodyAcc-mean()-Z"  
"fBodyAcc-std()-X"  
"fBodyAcc-std()-Y"  
"fBodyAcc-std()-Z"  
"fBodyAcc-meanFreq()-X"  
"fBodyAcc-meanFreq()-Y"  
"fBodyAcc-meanFreq()-Z"  
"fBodyAccJerk-mean()-X"  
"fBodyAccJerk-mean()-Y"  
"fBodyAccJerk-mean()-Z"  
"fBodyAccJerk-std()-X"  
"fBodyAccJerk-std()-Y"  
"fBodyAccJerk-std()-Z"  
"fBodyAccJerk-meanFreq()-X"   
"fBodyAccJerk-meanFreq()-Y"   
"fBodyAccJerk-meanFreq()-Z"  
"fBodyGyro-mean()-X"  
"fBodyGyro-mean()-Y"  
"fBodyGyro-mean()-Z"  
"fBodyGyro-std()-X"  
"fBodyGyro-std()-Y"  
"fBodyGyro-std()-Z"  
"fBodyGyro-meanFreq()-X"  
"fBodyGyro-meanFreq()-Y"  
"fBodyGyro-meanFreq()-Z"  
"fBodyAccMag-mean()"  
"fBodyAccMag-std()"   
"fBodyAccMag-meanFreq()"   
"fBodyBodyAccJerkMag-mean()"   
"fBodyBodyAccJerkMag-std()"  
"fBodyBodyAccJerkMag-meanFreq()"  
"fBodyBodyGyroMag-mean()"  
"fBodyBodyGyroMag-std()"  
"fBodyBodyGyroMag-meanFreq()"   
"fBodyBodyGyroJerkMag-mean()"  
"fBodyBodyGyroJerkMag-std()"  
"fBodyBodyGyroJerkMag-meanFreq()"   

