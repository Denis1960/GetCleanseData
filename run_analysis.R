#
# This function inputs information for use in analyzing wearables technology
# A data set is read and then transformed for analysis based on standard deviation
# and mean calculations of observations that occur for multiple people (subjects)
# carrying out a variety of activities (e.g. sitting, walking, walking stairs)
# Final output is a file that meets tidy data principles

run_analysis <- function()
{
  
#Set working directory to the directy containing the data set
  setwd("c:/datasciencecoursera/GetandCleanseData")
  
  suppressPackageStartupMessages(library(dplyr))
  suppressPackageStartupMessages(library(reshape2))
  suppressPackageStartupMessages(library(data.table))
  suppressPackageStartupMessages(library(tidyr))
  
  #Load the various files needed from the data set:
    #activity labels (read in the second column as that is all that's needed)
    #features (read in the second column as that is all that's needed)
    #test data sets: subject (person wearing device), test data and labels
    #train data sets: identical to test

  activityLabels <- read.table("activity_labels.txt")[,2]
  featureNames <- read.table("features.txt")[,2]
  
  subTest <- read.table("test/subject_test.txt")
  subTrain <- read.table("train/subject_train.txt")
  
  xTest <- read.table("test/X_test.txt")
  xTrain <- read.table("train/X_train.txt")
  
  yTrain <- read.table("train/y_train.txt")
  yTest  <- read.table("test/y_test.txt")
  

  ##Add column names to the Test and Train files
  
  names(xTest) <-  featureNames
  names(xTrain) <- featureNames
  
  #Remove the first column to get rid of duplicate columns errors
  xTest <- xTest[,-1]
  xTrain <- xTrain[,-1]
  
  #select only std() and mean() information for the measures recorded
  xTest <- select(xTest,contains('std()'),contains('mean()'))
  xTrain <- select(xTrain,contains('std()'),contains('mean()'))
  
 
 #Add labels and column names to test and train label files and subject files
  yTest[2] <- activityLabels[yTest[,1]]
  names(yTest) <- c("Activity","ActivityDescription")
  names(subTest) <- c("Subject")
  
  yTrain[2] <-activityLabels[yTrain[,1]]
  names(yTrain) <- c("Activity","ActivityDescription")
  names(subTrain) <- c("Subject")
  
  #merge the test and train data sets into a single data table that includes all relevant files for test and train data              
  testDT <-  cbind(as.data.table(subTest),yTest,xTest)
  trainDT <- cbind(as.data.table(subTrain),yTrain,xTest)
 
  #merge the entire train and test sets into one data table and add labels
  allDataDT <- rbind(testDT,trainDT)
  id_labels   = c("Subject", "Activity", "ActivityDescription")
  data_labels = setdiff(colnames(allDataDT), id_labels)
  print (colnames(allDataDT))
  #create melted table to include a single observation for each row
  mDataDT <- melt(allDataDT, id = id_labels, measure.vars = data_labels)
  write.table(mDataDT, file = './mdata.txt')
  

  #Create final  data file grouped by Subject and Activity/Description
  tDataDT   <- dcast(mDataDT, Subject + Activity + ActivityDescription ~ variable, mean)
  tDataDT  <- format(tDataDT , just = "left")
  capture.output(print(tDataDT, print.gap=3), file ="./tdata.txt")
  #Melt the file to create one observation per row
  meltDataDT <- melt(tDataDT, id = id_labels, measure.vars = data_labels)
  meltDataDT  <- format(meltDataDT , just = "left")
  capture.output(print(meltDataDT, print.gap=3), file ="./tidy_data.txt")
  
  
  
}
