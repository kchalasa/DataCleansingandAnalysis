# CODEBOOK - "Getting and Cleaning Data - Course Project"

## Data
This data is a subset of the "Human Activity Recognition Using Smartphones Dataset Version 1.0".The original data and the experiment are available at the UCI Machine Learning Repository. This data cannot be used for commercial purposes, its license and website url is included in the "README.md" file.

An experiment was carried out on 30 volunteers and ix activities(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) they performed while wearing a smartphone (Samsung Galaxy S II) on their waist. Using the sensors embedded in this phone, a lot of data were gathered, and several data elements were derived from these data. 

A set of transformations were applied on the original data set to arrive at the "tidydata" set for this project. These transformations are described in this document.

Final "course project" data set includes- only average of "mean" measurements with features named like "mean()" in the original data set and 
average of "standard deviation" measurements  with features named like "std()" in the original data set for each person and their activity.
Selected quantitative features (66) are included for each of the 30 volunteers ("person") and six of their 6 physical activities ("activity"). 
So in this dataset there are only 180 aggregated records, one record per each activity for each person. 

## Variables in the tidydata

Below is the description for the variables included in the data set for the course project. Each of these features or variables were collected from sensors 
(the accelerometer and gyroscope 3-axial raw signals) of the Samsung Galaxy S II phone in the orginal study.

####General feature names (labels) "notes" :
*person : A unique label id (1 thru 30) assigned to each of the volunteer in this experiment.
*activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 
*Prefix 't' to denote the time domain signals
*Prefix 'f' to indicate the frequency domain signals
*suffix 'x' for X-axis
*suffix 'y' for Y-axis
*suffix 'z' for Z-axis
*includes 'body_acceleration' for body acceleration collected using accelerometer
*includes 'gravity_acceleration' for body gravity collected using accelerometer
*includes 'gyro_angular_velocity' for angular velocity captured using gyroscope
*includes 'jerk_signal' for jerk signals that were derived in the original set from linear acceleration and angular velocity
*includes 'magnitude'  for magnitude calculated using the Euclidean norm 
*includes 'mean' for average mean
*includes 'std' for average standard deviation (std)

####General feature groups:

1. Using Samsung Galaxy S II phone's embedded accelerometer, 3-axial linear acceleration were captured. 
These sensor acceleration signals were pre-processed and separated using a Butterworth low-pass filter into body acceleration and gravity.
These features are labeled as listed below along XYZ axis for their "mean" and standard deviation averages. 

*fbody_acceleration
*tbody_acceleration
*tgravity_acceleration


2. Using Samsung Galaxy S II phone's embedded gyroscope, 3-axial angular velocities were captured.  
These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".
*fbody_gyro_angular_velocity
*tbody_gyro_angular_velocity


3. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals
These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".

*fbody_acceleration_jerk_signal
*tbody_acceleration_jerk_signal
*tbody_gyro_angular_velocity_jerk_signal

4. The magnitude of these three-dimensional signals were calculated using the Euclidean norm , for all the above.
These features are labeled with the prefix below along three axis (XYZ) for their average "mean" and average "standard deviation (std)".

*fbody_acceleration_magnitude
*fbody_bodyacceleration_jerk_signal_magnitude
*fbody_bodygyro_angular_velocity_jerk_signal_magnitude
*fbody_bodygyro_angular_velocity_magnitude
*tbody_acceleration_jerk_signal_magnitude
*tbody_acceleration_magnitude
*tbody_gyro_angular_velocity_jerk_signal_magnitude
*tbody_gyro_angular_velocity_magnitude
*tgravity_acceleration_magnitude

The complete list of variables names in this subset for course project are available in 'features.txt'

## Transformations for this data : Several transformations were applied to the original data set in order to prepare the final clean data set ("tidydata.txt")
for this project. These transformations were organized as four R functions included in the "run_analysis.R" script. 
	
The following is a general description for these functions :
	
*Function 1 -dataDownload: Download and Unzip the original data set.
*Function 2 -loadMerge: Merge "Training" and "Test" data sets for each volunteer and their activiy into one data frame.
*Function 3 -cleanData: Feature selection, label cleanup, and convert numeric activity labels to descriptive labels
*Function 4 -writeTidyData: Calculate average for all quantitative variables selected for each person and their activity, and generate "tidydata.txt"
	
####Function 1 -dataDownload(dir,zipfileurl)

This function takes two parameters, 1) a working directory location (dir) and 2) an internet url for the zipped data location (zipfileurl).

Pseudocode for this function.
* Check if "data" directory exists in the working directory (dir).
* It creates a "data" directory if it doesnot exists in the working directory.
* It will delete and re-create a "data" directory if it already exists.
* It will change the working directory to this newly created directory.
* Download the zipped dataset from the internet URL passed (zipfileurl).
* It will unzip this dataset.
* Finally it will return this new "working directory" location.

```
    dataDownload<-function(dir,zipfileurl) {
        dir<-paste(dir,"/data",sep="") # Caution directory will removed and recreated each time
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
    
    	
    
    
    
    
    
