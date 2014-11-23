cleaningdata
============

Cleaning Data Project

SCRIPT:
-------

run_analysis.R is broken into parts

Part 0: loads all .txt files from root, train and test folders
Part 1: Merges training, test with features, subjects and activity
Part 2: Extracts required measurements (Mean & Standard Deviation for each)
Part 3: Labelling merged dataset using activitylabel.txt
Part 4: Changes names of labels to readable. f > frequency, t > time. also removes - & () signs
Part 5: Melt and Aggregate data to obtain mean of each category
Part 6: Writes to tidyset.txt



CODEBOOK:
---------
Subject    	- number ID of individual subject

ActivityName	- type of activity, extracted from activity_labels.txt
		  LAYING
		  SITTING
		  STANDING
		  WALKING
		  WALKING_DOWNSTAIRS
		  WALKING_UPSTAIRS


ColFeat		- Measurement labels as composite of following
		  Time/Frequency
		  Body/Gravity
		  Acc/Gyro (Accelerometer/Gyroscope)
		  Jerk/Magnitude
		  Mean/StDev
		  X/Y/Z

Value		- Calculated mean of each measurement above		  





