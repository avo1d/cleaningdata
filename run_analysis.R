smartphone <- function() {
    ## Required library
    require(reshape2)
    ## part 0: Load all files

    ## Root directory
    # read column names from features.txt
    colFeat <- read.csv("UCI HAR Dataset\\features.txt", sep="", header=F)
    
    # read activity file and set column names
    activityLabel <- read.csv("UCI HAR Dataset\\activity_labels.txt", sep="", header=F)
    colnames(activityLabel) <- c("Activity", "ActivityName")
    
    ## Test Folder
    # read X_test.txt file and assign as column names
    x_test <- read.csv("UCI HAR Dataset\\test\\X_test.txt", sep="", header=F)
    colnames(x_test) <- colFeat[,2]
    
    # read subject file and set column name
    sub_test <- read.csv("UCI HAR Dataset\\test\\subject_test.txt", sep="", header=F)
    colnames(sub_test) <- c("Subject")
    
    # read y_test.txt file
    y_test <- read.csv("UCI HAR Dataset\\test\\y_test.txt", sep="", header=F)
    colnames(y_test) <- c('Activity')
    
    ## Train Folder
    # read x_train.txt file and assign as column names
    x_train <- read.csv("UCI HAR Dataset\\train\\x_train.txt", sep="", header=F)
    colnames(x_train) <- colFeat[,2]
    
    # read subject file and set column name
    sub_train <- read.csv("UCI HAR Dataset\\train\\subject_train.txt", sep="", header=F)
    colnames(sub_train) <- c("Subject")
    
    # read y_test.txt file
    y_train <- read.csv("UCI HAR Dataset\\train\\y_train.txt", sep="", header=F)
    colnames(y_train) <- c('Activity')
    
    ## part 1: Merges the training and the test sets to create one data set.
    # bind data via train/test then by features, sub, acvitity
    
    dataset <- cbind(rbind(sub_train,sub_test),rbind(y_train,y_test),rbind(x_train,x_test))
    rm(sub_train,sub_test,y_train,y_test,x_train,x_test)    
    
    ## part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
    minset <- dataset[,grep("mean\\(\\)|std\\(\\)|Subject|Activity", names(dataset))]
    
    ## part 3: adding ActivityNames from activitylabel.txt
    minset <- merge(activityLabel, minset, by.x="Activity", by.y="Activity", all=T)    
    minset <- minset[order(minset$Subject,minset$Activity),]
    
    
    ## part 4: Appropriately labels the data set with descriptive variable names. 
    
    setName <- colnames(minset)
    
    setName[substr(setName,1,1) == "t"] <- sub("t", "Time", setName[substr(setName,1,1) == "t"])
    setName[substr(setName,1,1) == "f"] <- sub("f", "Frequency", setName[substr(setName,1,1) == "f"])
    setName <- sub("-mean\\(\\)", "Mean", setName)
    setName <- sub("-std\\(\\)", "StDev", setName)
    setName <- sub("-X", "X", setName)
    setName <- sub("-Y", "Y", setName)
    setName <- sub("-Z", "Z", setName)
    
    colnames(minset) <- setName
    
    # part 5: Melt & Aggregate data to obtain mean of each ColFeat
    meltdata <- melt(minset, variable.name="ColFeat",id=c("Subject","Activity","ActivityName"))
    cleanData <- aggregate(data=meltdata, value ~ Subject + ActivityName + ColFeat, FUN=mean)
    
    # write cleaned data to tidyset.txt
    write.table(cleanData, "tidyset.txt", sep="\t", row.names=FALSE)
    
}