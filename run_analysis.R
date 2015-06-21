#Project Script

setwd("./UCI HAR Dataset/train")
getwd()
list.files()
train<-read.table("X_train.txt")
tlabel<-read.table("Y_train.txt")
tlabel<-factor(tlabel[,1])
levels(tlabel)=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
subject<-read.table("subject_train.txt")
train<-cbind(train,tlabel)
train<-cbind(train,subject)
setwd("../test")
getwd()
list.files()
test<-read.table("X_test.txt")
tlabel<-read.table("Y_test.txt")
tlabel<-factor(tlabel[,1])
levels(tlabel)=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
subject<-read.table("subject_test.txt")
test<-cbind(test,tlabel)
test<-cbind(test,subject)
data<-rbind(train,test)

setwd("../")
getwd()
rowindex<-c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,543)
features<-read.table("./features.txt")
subfeatures<-features[rowindex,1]
colindex<-c(subfeatures,562,563)
finaldata<-data[,colindex]

library(data.table)
finaltable<-data.table(finaldata)
resultable<-finaltable[,lapply(.SD,mean),by="tlabel,V1.1",.SDcols=c(1:81)]
setwd("../")
write.table(resultable,file="result.txt",row.names=FALSE)