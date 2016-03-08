run_analysis <- function() {
	features = read.table(file="./UCI HAR Dataset/features.txt")

	train_data <- read.table(file="./UCI HAR Dataset/train/X_train.txt")
	test_data <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
	tcombined_data <- rbind(train_data, test_data)

	combined_data = setNames(data.frame(tcombined_data), tmp_features[,2])

	train_output <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
	test_output <- read.table(file="./UCI HAR Dataset/test/y_test.txt")
	combined_output <- rbind(train_output, test_output)

	new_features <- features[grep("mean|std", features[,2]),2]
	meanandstd_features <- new_features[-grep("meanFreq", new_features)]
	meanandstd_data <- combined_data[ , which(names(combined_data) %in% meanandstd_features)]
	head(meanandstd_data)
	
	means <- colMeans(meanandstd_data)
}
