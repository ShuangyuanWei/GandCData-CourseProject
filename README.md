Guidance on how the data is manipulated and cleaned:
========================================================

#Through the data building and cleaning  process, basically I built "train" and "test" dataset separately by merging each data with its own activity and subject data, then stacked the processed "train" and "test" together, selected out required columns and aggregated the combined dataset. Please be noted that instead of cleaning the variable names after stakcing and merging, I did the variables lables cleaning during the stage of creating dataset header.#

Specific steps I took to create the tidy dataset:

1. Load "features.txt" and transpose it to be used as header in the later steps, I cleaned the header to let it be descriptive and illegal for R requirements. For example, the original name of the first statistics column is "tBodyAcc-mean()-X", I made it as "tBodyAcc.mean.X" eventually. 

2. Load "activity_labels.txt" to create a dataset named "activity_label" to merge with master train/test dataset in the later steps to provide activity descriptions.

3. Load "X_train.txt", Combine header with it so the data has column names. 

4. Load "y_train.txt" and "subject_train.txt" and merge them together with X_train using cbind to create one single data named "train", because they all have same number of observations. X_train contains all the activity statistics, y_train contains what activity the subject person performed, subject identifies who performed the activity.

5. Merge the "train" dataset created in the last step with "activity_labels" data by the activity label variable to get activity descriptions, rename newly combined column names to "subject", "activity.label" and "activity.description". The built complete dataset for "train" part is a dataset named "train_activity".

6. Repeat step 1-5 on "test" datasets, the built complete dataset for "test" part is a dataset named "test_activity".

7. Stack "train_activity" and "test_activity" together to create a dataset named "train_test".

8. Extracts only the measurements on the mean and standard deviation 
for each measurement, this steps creates a dataset "train_test_clean".

9. Aggregate and calculate mean for each variable by subject and activity, the final data is named "train_test_avg".
