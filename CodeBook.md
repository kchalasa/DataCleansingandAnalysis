# CODEBOOK - "Getting and Cleaning Data - Course Project"

## Data
This data is a subset of the "Human Activity Recognition Using Smartphones Dataset Version 1.0". The original data and the experiment are available at the [UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This data cannot be used for commercial purposes.

An experiment was carried out on 30 volunteers and six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) they performed while wearing a smartphone (Samsung Galaxy S II) on their waist. Using the sensors embedded in this phone, a lot of data were gathered, and several additional data elements were derived from these data. 

A set of transformations were applied on the original data set to arrive at the "tidydata" data set for this project. These transformations are described in this document.

Final "course project" data set includes- selected quantitative features (66) and two qualitative features. In other words the data set has 66 numeric measures for each of the 30 volunteers and six of their activities.
Dataset contains 180 aggregated records, one activity for each of the 30 volunteers. 

## Variables

Listed below are the qualitative and quantitative variables included in the "tidydata.txt" data set for this course project. 

#####Qualitative Variables:
* person: A unique label id assigned to each of the volunteer in this experiment.
		```
		1 through 30
		```
* activity: A variable to hold one of the six descriptive activity names.
		```
		1 - WALKING
		2 - WALKING_UPSTAIRS
		3 - WALKING_DOWNSTAIRS
		4 - SITTING
		5 - STANDING
		6 - LAYING
		```

#####Quantitative Variables:

As mentioned before there are 66 quantitative variables, they are all listed in ["features.txt"] (https://github.com/kchalasa/DataCleansingandAnalysis/blob/master/features.txt) file included in this repository. 

Naming conventions used for these variables:

* Prefix 't' to denote the time domain signals
* Prefix 'f' to indicate the frequency domain signals
* Suffix 'x' for X-axis
* Suffix 'y' for Y-axis
* Suffix 'z' for Z-axis
* Includes 'body_acceleration' for body acceleration collected using accelerometer
* Includes 'gravity_acceleration' for body gravity collected using accelerometer
* Includes 'gyro_angular_velocity' for angular velocity captured using gyroscope
* Includes 'jerk_signal' for jerk signals that were derived in the original set from linear acceleration and angular velocity
* Includes 'magnitude'  for magnitude calculated using the Euclidean norm 
* Includes 'mean' for average mean
* Includes 'std' for average standard deviation (std)

#####General feature groups:

Using Samsung Galaxy S II phone's embedded accelerometer, 3-axial linear acceleration were captured. These sensor acceleration signals were pre-processed and separated using a Butterworth low-pass filter into body acceleration and gravity. These features are labeled as listed below along XYZ axis for their "mean" and standard deviation averages. 

* fbody_acceleration
* tbody_acceleration
* tgravity_acceleration


Using Samsung Galaxy S II phone's embedded gyroscope, 3-axial angular velocities were captured. These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".

* fbody_gyro_angular_velocity
* tbody_gyro_angular_velocity


Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".

* fbody_acceleration_jerk_signal
* tbody_acceleration_jerk_signal
* tbody_gyro_angular_velocity_jerk_signal

The magnitude of these three-dimensional signals were calculated using the Euclidean norm. These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".

* fbody_acceleration_magnitude
* fbody_bodyacceleration_jerk_signal_magnitude
* fbody_bodygyro_angular_velocity_jerk_signal_magnitude
* fbody_bodygyro_angular_velocity_magnitude
* tbody_acceleration_jerk_signal_magnitude
* tbody_acceleration_magnitude
* tbody_gyro_angular_velocity_jerk_signal_magnitude
* tbody_gyro_angular_velocity_magnitude
* tgravity_acceleration_magnitude

The complete list of variables names in this subset for the course project are available in 'features.txt'.

## Transformations for this data : 
Several transformations were applied to the original data set provided in order to prepare the final clean data set ("tidydata.txt") for this project. The code for these transformations are organized into four R functions in the "run_analysis.R" script. This script also has a code snippet that calls these functions in an appropriate order to generates "tidydata.txt" data set. 
	
The following is a general description for these functions :
	
* Function 1 -dataDownload: Download and Unzip the original data set.
* Function 2 -loadMerge: Merge "Training" and "Test" data sets for each volunteer and their activiy into one data frame.
* Function 3 -cleanData: Feature selection, label cleanup, and convert numeric activity labels to descriptive labels
* Function 4 -writeTidyData: Calculate average for all quantitative variables selected for each person and their activity, and generate "tidydata.txt"
* R Code Snippet to execute the above function in order.
	
#####Function 1 -dataDownload(dir,zipfileurl)

This function takes two parameters, 1) a working directory location (dir) and 2) an internet url for the zipped data location (zipfileurl). It returns the new working directory for the project.

Pseudocode for this function.
* Check if "data" directory exists in the working directory (dir).
* Creates a "data" directory if it doesnot exist in the working directory.
* Delete and re-create a "data" directory if it already exists.
* Change the working directory to this newly created directory location.
* Download the zipped dataset from the internet URL passed (zipfileurl).
* Unzip this dataset.
* Finally make the data subdirectory as new "working directory" and return this location.

```
    # Function to prepare data for reading.
    # @dir - Location to the "Path" where a directory is "CREATED". CAUTION: If a directory already exists, it will deleted and recreated.
    # @zipfileurl - Internet url for the zipfile location

    dataDownload<-function(dir,zipfileurl) {
		# Caution directory will removed and recreated each time
        dir<-paste(dir,"/data",sep="") 
		
        if (!file.exists(dir)) 
            {
                dir.create(dir) 
            } else  
                {
                    unlink(dir, recursive = TRUE)
                    dir.create(dir) 
                }
        setwd(dir)
        download.file(zipfileurl,destfile="dataDownload.zip")
        unzip("dataDownload.zip")
        dir<-gsub("/data","",dir)
        setwd(dir)
        dir
    }
```
    
#####Function 2 -loadMerge(dir)

This function takes working directory (dir) returned from dataDownload function as input parameter and returns a merged data set containing all features for all volunteers and their numeric activity labels.

Pseudocode for this function.
* Get all the features from the UCI Samsung data set. 
* Build TEST data set - "allTest" data.frame to include all test volunteers, their activities and their measurements. 
* Build TRAIN data set - "allTest" data.frame to include all test volunteers, their activities and their measurements.
* Label subjects as "person" and their numeric activities as "activity" in the above data.frame.
* Merge the two data sets and return this originaldataset.
```
	loadMerge<-function(dir) {
			setwd(dir)
		# Read all features in the dataset
			features<-read.table(paste(dir,"/data/UCI HAR Dataset/features.txt",sep=""))
		
		# STEP 1a. load Test data set
		# load all subjects in TEST Set
			subjTest<-read.table(paste(dir,"/data/UCI HAR Dataset/test/subject_test.txt",sep=""))
			names(subjTest)<-"person"
		
		# load all activities for the subjects or people in the TEST Set
			ytest<-read.table(paste(dir,"/data/UCI HAR Dataset/test/y_test.txt",sep=""))
			names(ytest)<-"activity"
		
		# load all features or measurements provided in the TEST Set
			xtest<-read.table(paste(dir,"/data/UCI HAR Dataset/test/X_test.txt",sep=""))
			names(xtest)<-features$V2
		
		# Build "Test" dataset
			allTest<-cbind(xtest,ytest)
			allTest<-cbind(allTest,subjTest)
		
		# STEP 1b. load TRAIN data Set
		# load all subjects in train data set
			subjTrain<-read.table(paste(dir,"/data/UCI HAR Dataset/train/subject_train.txt",sep=""))
			names(subjTrain)<-"person"
		
		# load all activities for the subjects or people in the train Set
			ytrain<-read.table(paste(dir,"/data/UCI HAR Dataset/train/y_train.txt",sep=""))
			names(ytrain)<-"activity"
		
		# load all features or measurements provided in the train Set
			xtrain<-read.table(paste(dir,"/data/UCI HAR Dataset/train/X_train.txt",sep=""))
			names(xtrain)<-features$V2
		
		# Build "train" dataset - merge columns
			allTrain<-cbind(xtrain,ytrain)
			allTrain<-cbind(allTrain,subjTrain)		
		
		# Merge TEST and TRAIN data sets --merge rows
			originaldataset<-rbind(allTest,allTrain)
			originaldataset
		}
```	

#####Function 3 -cleanData(originaldataset,dir)

This function takes "originaldataset" returned from loadMerge function and current working directory "dir" as parameters. It selects the features for the final data set. It also cleans variable names for these selected features. Finally it converts numeric activities of the volunteers as meaningful descriptive labels.

Pseudocode for this function.
* Build select data set with only the features that have either "mean()" or "std()" in its name in the original data set.
* Rename and clean variable names to meaningful and valid column names for R programming.
* Include person and activity columns from the original data set in this select data set.
* Finally rename the numeric activity labels to descriptive activity names using "activity_labels.txt" file in the UCI dataset.
* Return this selected subset of data

```
		
	cleanData <- function(originaldataset,dir) {
				setwd(dir)
				# Read all features in the dataset
				features<-read.table(paste(dir,"/data/UCI HAR Dataset/features.txt",sep=""))

		# STEP 2. Extract only the measurements on the mean  and standard deviation "std()" for each measurement
				# Build a "index" for selecting mean and standard deviation measurements 
					pickFeatures <- c("mean\\(\\)","std\\(\\)","activity","person")
					meanstdindex <- grep(paste(pickFeatures,collapse="|"),features$V2)
					selectdata<-originaldataset[,meanstdindex]
				
				# STEP 4. Appropriately labels the data set with descriptive activity names.
					quantitativeColNames<-tolower(gsub("\\(\\)","",gsub("\\-","",features[meanstdindex,]$V2)))
					quantitativeColNames<-gsub("fbody","fbody_",quantitativeColNames)
					quantitativeColNames<-gsub("tgravity","tgravity_",quantitativeColNames)
					quantitativeColNames<-gsub("tbody","tbody_",quantitativeColNames)
					quantitativeColNames<-gsub("acc","acceleration_",quantitativeColNames)
					quantitativeColNames<-gsub("gyro","gyro_angular_velocity_",quantitativeColNames)
					quantitativeColNames<-gsub("mag","magnitude_",quantitativeColNames)
					quantitativeColNames<-gsub("jerk","jerk_signal_",quantitativeColNames)
					names(selectdata)<-quantitativeColNames
					selectdata<-cbind(selectdata,originaldataset[,562:563])

			
		# STEP 3. Uses descriptive activity names to name the activities in the data set
				for (i in 1:length(selectdata$activity)) {
					 if (selectdata$activity[i]==1) selectdata$activity[i]<-"WALKING"
					 if (selectdata$activity[i]==2) selectdata$activity[i]<-"WALKING_UPSTAIRS"
					 if (selectdata$activity[i]==3) selectdata$activity[i]<-"WALKING_DOWNSTAIRS"
					 if (selectdata$activity[i]==4) selectdata$activity[i]<-"SITTING"
					 if (selectdata$activity[i]==5) selectdata$activity[i]<-"STANDING"
					 if (selectdata$activity[i]==6) selectdata$activity[i]<-"LAYING"
				}
			selectdata
	}
```
#####Function 4 -writeTidyData(selectdata,dir)

This function takes "selectdata" returned from cleanData function and current working directory "dir" as parameters. It then computes the average of each variable for each activity and each volunteer ("person"). It then formats and writes this data into "tidydata.txt" file.

Pseudocode for this function.
* Computes the average of each variable for each activity and each person.
* Format the output data into scietific data format with seven digits after decimal.
* write the data set into "tidydata.txt" file in the current working directory. 

```
	writeTidyData <- function(selectdata,dir) {
		setwd(dir)
		library(plyr)
		# Calculate average for all quantitative variables for each person and their activity
		write.table(ddply(selectdata,.(person,activity),function(dataset){formatC(colMeans(dataset[,1:66]),digits=7,format="e")}),"tidydata.txt",row.names=FALSE, quote = FALSE)
	}
```

#####R Code Snippet 
This snippet calls the above functions in appropriate order to run this analysis. These functions are all kept in this one file to make code review easier.

```
	# STEP 0 - Call function "dataDownload" to download the data
		workDir<-dataDownload("C:/KantiOLD/courseera/DataScience/cleaning data/courseProject","https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
		
	# STEP 1 - Call function "loadMerge" to load and merge the data
		resultSet<-loadMerge(workDir)
		
	# Steps 2 - 3 - 4	- Call function  "cleanData" 
		cleanresultSet<-cleanData(resultSet,workDir)	
		
	# Steps 5	- Call function "writeTidyData" to prepare and write final "tidydata"
		writeTidyData(cleanresultSet,workDir)
		
```		



    
    
    
    
    
