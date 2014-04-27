print ("Starting analysis..")
install.packages("reshape2",dep=TRUE, repos='http://cran.us.r-project.org')
library(reshape2)

print ("Reading train data..")

xtrain <- read.table("./train/X_train.txt", header=FALSE, sep ="")
ytrain <- read.table("./train/y_train.txt", header=FALSE, sep ="")
subtrain <- read.table("./train/subject_train.txt", header=FALSE, sep ="")

print ("Reading test data..")

xtest <- read.table("./test/X_test.txt", header=FALSE, sep ="")
ytest <- read.table("./test/y_test.txt", header=FALSE, sep ="")
subtest <- read.table("./test/subject_test.txt", header=FALSE, sep ="")

print ("Merging test and train data..")

traindata <- cbind(subtrain, ytrain, xtrain)
testdata <- cbind(subtest, ytest, xtest)
mergeddata <- rbind(traindata, testdata)
rm(subtest,subtrain, testdata, traindata, xtest, ytest, xtrain, ytrain)

print ("Apply activity names..")

features <- read.table("features.txt", header=FALSE, sep="")
activities <- read.table("activity_labels.txt", header=FALSE, sep="")
names (mergeddata) <- c("Subject", "Activity", as.character(features[,2]))

print ("Extracting mean and std dev data..")

regexp <- c(".*mean\\(\\).*", ".*std\\(\\).*")
newheadnames <- unique (grep(paste(regexp,collapse="|"), features[,2], value=TRUE))
reduced <- mergeddata[,c("Subject", "Activity",newheadnames)]
rm(mergeddata,features)
redAct <- reduced$Activity
for (i in seq_along(redAct)){
    j <- redAct[i]
    redAct[i] <- as.character(activities[j,2])
}
reduced$Activity <- redAct
rm(i,j,newheadnames,regexp,activities,redAct)

print ("Melting and recasting data with averages..")

molten <- melt(reduced, id=c("Subject","Activity"))
print("Melting done..")
abcd <- dcast (molten, formula = Subject + Activity ~ variable, function(x) mean(x))
print("About to write tidy data")
write.table(abcd, "tidy_set.txt",sep ="\t")
rm(molten,reduced,abcd)

print ("DONE!")
