library(stringr)
library(plyr)

get_filename <- function(set, type) {
    filename <- file.path(set, sprintf('%s_%s.txt', type, set))
    filename
}

read_data_set <- function(set) {
    subjects <- read.table(get_filename(set, 'subject'), header=FALSE)

    activity_ids <- read.table(get_filename(set, 'y'), header=FALSE, col.names=c('Id'))
    activity_names <- read.table('activity_labels.txt', header=FALSE, sep=' ', col.names=c('Id', 'Name'))
    activities <- activity_names[match(activity_ids$Id, activity_names$Id),]$Name
    
    measurements <- read.fwf(get_filename(set, 'X'), widths=rep(16, 561))
    
    data_set <- cbind(subjects, activities, measurements)
    data_set
}

get_merged_data_sets <- function() {
    test_set <- read_data_set('test')
    training_set <- read_data_set('train')
    
    data <- rbind(training_set, test_set)
    data
}

extract_mean_and_std_dev <- function(data) {
    columns <- colnames(data)
    relevant_columns <- columns %in% c("Subject", "Activity") | str_detect(columns, "mean\\(\\)") | str_detect(columns, "std\\(\\)")
    relevant_data <- data[,relevant_columns]
    relevant_data
}

read_measurement_column_names <- function() {
    features <- read.table('features.txt', header=FALSE, sep=' ', stringsAsFactors=FALSE)
    features[,2]
}

get_column_names <- function() {
    measurement_column_names <- read_measurement_column_names()
    column_names <- append(c("Subject", "Activity"), measurement_column_names)
    column_names
}

get_full_data_set <- function() {
    all_data <- get_merged_data_sets()
    column_names <- get_column_names()
    colnames(all_data) <- column_names
    
    mean_and_std_dev_measurements <- extract_mean_and_std_dev(all_data)
    mean_and_std_dev_measurements
}

tidy_data_set <- get_full_data_set()

mean_data_set <- ddply(tidy_data_set, .(Subject, Activity), colwise(mean))
write.table(mean_data_set, 'mean_measurements.txt', row.name=FALSE)

