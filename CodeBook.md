The file run_analysis.R code performs the following steps to read the Human Activity recognition dataset and transforms it to a tidy set:

1. Read the dataset:
  Dataset downloaded and unzipped under the folder called UCI HAR Dataset:

  * activities
  * features
  * training data (training): 
    + x_test, y_test, and subject_text
  * test data (test):
    + x_test, y_test, and subject_train
    
2. Merge the training data and the test data by binding the rows
  * dataset <- rbind(training, test)
  
3. extract the columns with the mean and std values
  * filteredData <- select(dataset, subject, code, contains("mean"), contains("std"))
  
4. Replace the activity codes with the Activity text values

5. Rename the columns for more descriptive names:
  * code column in FilteredData renamed into activities
  * All Acc in column’s name replaced by Accelerometer
  * All Gyro in column’s name replaced by Gyroscope
  * All BodyBody in column’s name replaced by Body
  * All Mag in column’s name replaced by Magnitude
  * All start with character f in column’s name replaced by Frequency
  * All start with character t in column’s name replaced by Time
  
6. Take the average of each variable for each activity and each subject and write the tidy data into the file TidyResult.txt
  TidyResult.txt (180 x 88)

  


