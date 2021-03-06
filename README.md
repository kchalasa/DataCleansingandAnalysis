# Getting and Cleaning Data - Course Project

##### Source Data : Human Activity Recognition Using Smartphones Dataset Version 1.0

Please read [CodeBook.md] (https://github.com/kchalasa/DataCleansingandAnalysis/blob/master/CodeBook.md) document for details on source data.

License for this data is included at the bottom of this page.

#####Course Project Files in this repository:

* 'README.md' : Read me first document.

* 'CodeBook.md' : This code book describes the variables, the data, and all the transformations performed to clean this data for course project.

* 'features.txt' : List of all feature names included in the 'tidydata.txt'.

* 'run_analysis.R' : A script in "R Programming Language" to download the [zipped data] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from UCI website, unzip it and then transform this data using the "Getting and Cleaning Data - Course Project" guidelines to prepare a tidy subset of source data. In order to run this script, set your working directory to the directory where you placed the run_analysis.R script. Make sure you have internet access. Please note it will create a data directory in your working directory. Please be cautious as this will delete data directory if it already exists. It will download the data into this directory for processing and place final "tidydata.txt" in your working directory. You just need to use ``` source("run_analysis.R") ``` command in your working directory to run this script after placing it there. Read CodeBook.md document for further details on this script.

* 'tidydata.txt' : Output from the run_analysis.R script.

##### License (for the source data usage):
		     
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
