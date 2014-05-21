## run_analysis.R Script
## Place this script in your working directory and use source("run_analysis.R") command to run it.
## Please note a "data" directory will be created in your working directory. It will delete "data" directory if it already exists.
## This script has  a set functions that perform transformations on source data to create a tidydata.txt data set. 
## All these functions are executed at the end of this script in an appropriate order

    ## Get users working directory
		workingDir <- getwd()

    #############################################
    # dataDownload --Function to download zipped data and unzip it
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

    #############################################
    # STEP 1. Merges the training and the test data sets 
    # loadMerge(dir) function to load and merge data
	# @dir - Working directory where data was downloaded by dataDownload function

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
	
#############################################
# cleanData function executes Step 2 -  Step 3 -  Step 4 to clean the data

	
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
	

#############################################
# STEP 5 : Function writeTidyData -Creates summarized tidy data set with means for all quantitative measures by Subject and their activity.

	writeTidyData <- function(selectdata,dir) {
			setwd(dir)
			library(plyr)
			# Exclude qualitative columns whose average need not be computed
				excludeColumns<-c("activity","person")
			# Calculate average for all quantitative variables for each person and their activity
				write.table(ddply(selectdata,.(person,activity),function(dataset){formatC(colMeans(dataset[,!(names(dataset) %in% excludeColumns)]),digits=7,format="e")}),"tidydata.txt",row.names=FALSE, quote = FALSE)
	}
	
#############################################

## Execute all the above R functions to "run this analysis" - clean and prepare the data

## STEP 0 - Call function "dataDownload" to download the data
	workDir<-dataDownload(workingDir,"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
	
## STEP 1 - Call function "loadMerge" to load and merge the data
	resultSet<-loadMerge(workDir)
	
## Steps 2 - 3 - 4	- Call function  "cleanData" 
	cleanresultSet<-cleanData(resultSet,workDir)	
	
## Steps 5	- Call function "writeTidyData" to prepare and write final "tidydata"
	writeTidyData(cleanresultSet,workDir)