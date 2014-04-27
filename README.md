GettingCleaningDataProject
==========================

Repo for getting/cleaning data project

This repo contains the code for creating a tidy data set for the Getting/Cleaning Data project.

The raw data set is available here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

From this, a series of transformations was done to obtain the tidy data set. Below is a list of variables used along with a step by step explanation of the code

* xtrain - to store the x training data in a data frame
* ytrain - to store the y training data in a data frame
* subtrain - to store the subject training data in a data frame
* xtest - to store the x test data in a data frame
* ytest - to store the y test data in a data frame
* subtest - to store the subject test data in a data frame

* traindata - contains merged x,y,subject train data
* testdata - contains merged x,y,subject test data
* mergeddata - contains merged testdata and train data

* features - data frame read from features.txt
* activities - data frame read from activity_labels.txt

* regexp - contains the regular expression used to exract only the mean() and std() variables; this will be applied to the features dataframe
* newheadnames - applies the regular expression to the features data frame - and this will be the new header names of the new data frame to be called 'reduced'

* reduced - data frame containing only the mean and std dev values

* redAct - integer vector containing the numbers from the Activity column of the 'reduced' data frame

The for loop then iterates the length of the redAct vector and replaces the numbers with label like Sitting, Walking, Laying etc. The labels come from the activities data frame which inturn got it from the activity_labels.txt file


* molten - variable contained the melted data
* abcd - variable containing the decast data with mean function applied

Finally the dataframe abcd is written to a file called tidy_set.txt

### Notes ###
* Print commands have been added in the middle - it serves as a progress indicator
* rm commands sprinkled inthe code remove the variables from the workspace freeing up memory
