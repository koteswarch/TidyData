########################################
#
# Purpose   :   Obtaining Tidy Data
#
# Author    :   Koti
# Date      :   6-May-2016
#
#######################################

# Location of my local working directory
workDir <- "D:/DataScience"

# Setting my working directory
setwd(workDir)

# Loading Hadley Wickham's amazing package to work with data
library(dplyr)

# Place where train data set is kept
trainDataDir <- "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train"

# Place where test data is kept    
testDataDir <- "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test"

# Files containing subject ids of participants in the experiment
trainSubjectsFile <- paste0(trainDataDir, "/subject_train.txt")
testSubjectsFile <- paste0(testDataDir, "/subject_test.txt")

# Files containing sensor measurements
trainFile <- paste0(trainDataDir, "/X_train.txt")
testFile <- paste0(testDataDir, "/X_test.txt")

# Files containing activity ids of activities performed by participants
trainActivityIdFile <- paste0(trainDataDir, "/y_train.txt")
testActivityIdFile <- paste0(testDataDir, "/y_test.txt")

# Data frames with subject ids
trainSubjectIds <- read.table(trainSubjectsFile)
testSubjectIds <- read.table(testSubjectsFile)

# Data frames with Measurements recorded
trainMeasurements <- read.table(trainFile)
testMeasurements <- read.table(testFile)

# Data frames with activity ids
trainActivityIds <- read.table(trainActivityIdFile)
testActivityIds <- read.table(testActivityIdFile)


# File containing 561 variable names 
featuresFIle <- paste0("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset",
                    "/features.txt")
# Data frame with 561 variable names
features <- read.table(featuresFIle)

# FIle containing activity labels
activityLabelsFIle <- paste0("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
                          ,"/activity_labels.txt")

# Data frame with activity labels
activityLabels <- read.table(activityLabelsFIle)
colnames(activityLabels) <- c("activity_id", "activity")

# Combines subject ids, activity id and measurement data column wise. 
trainData <- cbind(trainSubjectIds, trainActivityIds, trainMeasurements)
testData <- cbind(testSubjectIds, testActivityIds, testMeasurements)
 
# Combines train data and test data row wise.
activityData <- rbind(trainData, testData)

# Collect names for the columns and name the columns
colnames(activityData) <- c("subject_id", "activity_id", 
                            as.character(features[,2]))

# Make valid column names
validColumnNames <- make.names(names=names(activityData), unique = TRUE, 
                                 allow_ = TRUE)
names(activityData) <- validColumnNames

# Get the required columns
# Fetches only mean values and standard deviations for all measures
# Replaces activity ids with activity labels
# Groups the data by subject id and activity
# Calculates mean of all mean values and standard deviations for each group
activityData <- select(activityData, subject_id, activity_id, contains("mean"), 
                       contains("std")) %>%
    inner_join(activityLabels, by = c("activity_id" = "activity_id"))
        

select(activityData, 1, 2, ncol(activityData), 3:(ncol(activityData)-1)) %>%
    select(-activity_id) %>%
    group_by(subject_id, activity) %>%
    summarize_each(funs(mean)) -> tidyActivityData

# Removing periods from column names
columnNames <- gsub("[.]", "", names(tidyActivityData))
names(tidyActivityData) <- columnNames

# write to an excel file
write.csv(tidyActivityData, file = "./TidyData/tidyActivityData.csv")
