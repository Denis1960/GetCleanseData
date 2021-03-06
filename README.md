### Introduction

This project contains a single script, run_analysis.R, which prepares data from wearable technology
for analysis. The project is the solution for programming assignment 4 in the course Getting and
Cleaning Data.

The input data set consists of a training and test set. Each set contains observations recorded by the wearable
technology, worn by multiple subjects as they performed activities such as sitting, walking, walking up stairs, etc. 
Additional helper files in the input data set include information for the test subjects, information labels
for the tasks observed. Additional information is available in the code book for this project, which is also contained
in this repo.

Three output files are generated by the script:

mdata.txt - a text file in long format that shows each feature for each observed activity for each subject
tdata.txt - a text file in wide format that groups mdata by subject and activity and provides the mean for each feature observed
tiny_data.txt - a text file in long format derived from tdata.txt with one observation per row to meet tidy data standards.

### Instructions for this assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Program Steps

1. 	The program consists of a single function run_analys.R, which returns no values. Three output files are written.
2. 	All input data set files are read using read.table(), from the source directory , which is set in the program using setwd(). 
   	Please see the codebook for more information on the input dataset
		activity labels (read in the second column as that is all that's needed)
    		features (read in the second column as that is all that's needed)
    		test data sets: subject (person wearing device), test data and labels
    		train data sets: identical to test

3.	The feature names, which describe the specific observations are updated in the train and test observation files (xTest, xTrain)
4. 	The only information of interest for this exercise are those observations which include standard deviation or mean calculations.
  	Both xTest and xTrain have all other rows eliminated using the select() statement to filter on wildcards of std() and mean().
5.	Next, the files containing the activity descriptions(yTest,yTrain) are updated with descriptive column names as are
   	the subject train and test files.
6. 	cbind() is used to create a single data set for all test files (subTest,xTest,yTest) named testDT 
7. 	cbind() is used to create a single data set for all train files (subTrain,xTrain,yTrain) named trainDT
8. 	rbind() is used to create one single data set that combines all test and train files named allDataDT
9. 	A set of id_labels is created to identify non-calculated fields for the data set: Subject, Activity, ActivityDescription
10.	The id_labels is diffed with the colnames from allDataDT to identify the fields to define the id and measure.vars
    	to be used in the melt() function, which is where the meltDataDT data set is created. mDataDT is written as file mdata.txt
   	and stored int the working directory.
11.	dcast() is used to create a wide version file where the observation data is grouped_by Subject and Activity and where each observation
	for the group is averaged using mean(). The resulting data set is tDataDT, which is formatted and written to the working directory 
	using capture.output() as tdata.txt Tdatr
12.	tData is next converted to a long version data set to meet tidy standards by providing a single observation per row for each
	grouping.


