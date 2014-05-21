# Getting and Cleaning Data - Course Project

### Source Data : Human Activity Recognition Using Smartphones Dataset Version 1.0

A full description is available at the site where the data was obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

License for this data is included at the bottom of this page.

###The dataset includes the following files:

* 'README.md'

* 'CodeBook.md' : This code book describes the variables, the data, and all the transformations performed to clean this data.

* 'features.txt' : List of all feature names included in the 'tidydata.txt'.

* 'run_analysis.R' : A script in "R Programming Language" to download the zipped data from UCI website, unzip it and then transform this data using the "Getting and Cleaning Data - Course Project" guidelines to prepare a tidy subset of source data. In order to run this script, set your working directory to the directory where you placed the run_analysis.R script. Please note it will create a data directory in your working directory. Please be cautious as this will delete data directory if it already exists. It will download the data here for processing.

* 'tidydata.txt' : Output from the run_analysis.R script.

### License (for the source Data):
		     
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
