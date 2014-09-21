Codebook for tidying of the Samsung data (the UCI HAR Dataset)
==

### Study design
For details on the study design, I refer to the description of the study found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Source of the raw data
The data set is based on the following files in the UCI HAR dataset found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files have been unzipped before the processing has occurred.

The data comes from the following files:
* `train/subject_train.txt`
* `train/X_train.txt`
* `train/y_train.txt`
* `test/subject_test.txt`
* `test/X_test.txt`
* `test/y_test.txt`
* `features.txt`
* `activity_labels.txt`

The files in the train directory represent training data and the files in the test directory represent test data.

### Variables
The variables in the data set come from the `X_train.txt` and `X_test.txt` files. There are 561 variables in total and they are described thoroughly in the `features_info.txt` file in the UCI HAR Dataset.

### Manipulation of the raw data
The data from the test and training sets are each read and afterwards merged into one set.

Each of the sets is joined as a combination of the measurements (in the file `X_*.txt`) with the corresponding subject (obtained from `subject_*.txt`) and activity (from `y_*.txt`). The activity ids are later replaced with the descriptive names from `activity_labels.txt`.

### Extraction of columns
After the merging of the training and test sets, the 561 variables are reduces to only include those describing the mean and standard deviation of each signal. This is done by removing all but the columns whose names include the text "mean()" and "std()" in accordance with the description in `features_info.txt`.

### Grouping of the data
As a final processing step the mean of each variable for each activity and each subject is calculated, resulting in 180 observations of 68 variables.

### Instructions for running
The process can be run by executing the script `run_analysis.R` in this repository. The script assumes that the UCI HAR Dataset files have been extracted in the current working directory. The result of the processing is a file called `mean_measurements.txt` containing the above mentioned 180 observations of 68 variables.
