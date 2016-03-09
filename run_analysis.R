run_analysis <- function() {
	features = read.table(file="./UCI HAR Dataset/features.txt")
	activity_labels = read.table(file="./UCI HAR Dataset/activity_labels.txt")

	train_data <- read.table(file="./UCI HAR Dataset/train/X_train.txt")
	test_data <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
	tcombined_data <- rbind(train_data, test_data)

	combined_data <- setNames(data.frame(tcombined_data), tmp_features[,2])

	train_output <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
	test_output <- read.table(file="./UCI HAR Dataset/test/y_test.txt")
	combined_output <- rbind(train_output, test_output)

	#new_features <- features[grep("mean|std", features[,2]),2]
	#meanandstd_features <- new_features[-grep("meanFreq", new_features)]
	meanandstd_features <- features[grep("mean\\(\\)|std\\(\\)", features[,2]),2]
	meanandstd_data <- combined_data[ , which(names(combined_data) %in% meanandstd_features)]
	
	combined_data_output <- cbind(meanandstd_data, combined_output)
	actual_data <- merge(combined_data_output, activity_labels, by.x = "V1", by.y = "V1")
	
	
	means_by_activity <- aggregate(actual_data[,2:67], by=list(Category=actual_data$V2), FUN=mean)
	
	write.table(means_by_activity, file = "./tidy_dataset.txt", row.name = FALSE)
}
