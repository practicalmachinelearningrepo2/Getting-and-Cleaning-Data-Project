setwd("C:/kaggle/getting and cleaning data/project")
features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")

X_test <- read.table("./test/X_test.txt", quote="\"")
Y_test <- read.table("./test/Y_test.txt", quote="\"")
subject_test <- read.table("./test/subject_test.txt", quote="\"")

X_train <- read.table("./train/X_train.txt", quote="\"")
Y_train <- read.table("./train/Y_train.txt", quote="\"")
subject_train <- read.table("./train/subject_train.txt", quote="\"")

testSet<-cbind(X_test,subject_test)
testSet<-cbind(testSet,Y_test)

trainSet<-cbind(X_train,subject_train)
trainSet<-cbind(trainSet,Y_train)

totalSet<-rbind(trainSet,testSet)

colnames(totalSet)<-as.factor(c(as.character(features$V2),"SubjectId","ActivityId"))
validFields<-sort(c(grep("-std()",names(totalSet)),grep("-mean()",names(totalSet))))

reducedSet<-totalSet[,c(validFields,562,563)]

reducedSet<-merge(reducedSet,activity_labels,by.x="ActivityId",by.y="V1")
reducedSet <- subset(reducedSet, select = -c(1) )
colnames(reducedSet)[81]<-"ActivityId"


tidyData<- aggregate(reducedSet,by=list(reducedSet$SubjectId,reducedSet$ActivityId), FUN=mean)
tidyData<- subset(tidyData,select= -c(82,83))
colnames(tidyData)[1]<-"SubjectId"
colnames(tidyData)[2]<-"ActivityId"
tidyData<-cbind(tidyData[,3:81],tidyData[,1:2])

write.table(tidyData,"tidyData.txt",row.names=FALSE)

