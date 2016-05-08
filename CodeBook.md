This document describes how the given raw (input) data files are processed into a tidy data set. 

Below are the input files and along with their descriptions. All these files are text files.

1. subject_train.txt, subject_text.txt : These files contain subject ids for the 30 participants for whom sensor measurements were taken from the devices attached to their waist.
    Range of ids: 1 to 30
2. y_train.txt, y_text.text : These files contain activity ids pertaining to activities performed while the measurements were taken. 
  Range of ids: 1 to 6
3. X_train.txt, X_test.txt : Measurements where taken for 561 vector quantities. 
4. features.txt : Has names for all the vector quantities measured.
5. activity_labels.txt : Contains the six activities performed by the participants - Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying.

run_analysis.R : R script file that can be used to reproduce the expected tidy data. 
tidyActivityData.csv : This file contains the final activity data. It contains one observation per subject and activity. There are a total of 180 observations and 88 variables. 

