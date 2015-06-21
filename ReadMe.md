The objective of this project is to load the Samsung Human Activity Recognition dataset and merge the training and test dataset. After the merge the dataset is subset and summarized to give a clean and tidy data for further analysis. Below is the script for the code which will do this.
#Script for preparing a tidy dataset from Samsung Dataset

##Below code chunk changes working directory to train and reads the training set, label file and subject id file and merges it
```
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
```
##Below code chunk changes working directory to test and reads the test set, label file and subject id file and merges it
```
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
```
##Below code chunk merges the test and training dataset
```
data<-rbind(train,test)
```
##Below code chunk subsets the merged dataset to the required columns. Intentionally the subsetting is not parameterized as the result should be replicable
```
setwd("../")
getwd()
rowindex<-c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,543)
features<-read.table("./features.txt")
subfeatures<-features[rowindex,1]
colindex<-c(subfeatures,562,563)
finaldata<-data[,colindex]
```
## Below code creates a data.table out of the data frame for faster summarization and grouping. It then summarizes each column in the data.table by the Activity and Subject
```
library(data.table)
finaltable<-data.table(finaldata)
resultable<-finaltable[,lapply(.SD,mean),by="tlabel,V1.1",.SDcols=c(1:81)]
setwd("../")
```
##Below code writes the output to a text file
```
write.table(resultable,file="result.txt",row.names=FALSE)
```