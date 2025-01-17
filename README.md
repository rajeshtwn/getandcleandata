# getandcleandata

## read data files

Below lines of code are used to read data files into R data frames
```{r}
features = read.table(file="./UCI HAR Dataset/features.txt")
activity_labels = read.table(file="./UCI HAR Dataset/activity_labels.txt")
```

```{r}
train_data <- read.table(file="./UCI HAR Dataset/train/X_train.txt")
test_data <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
```

```{r}
train_output <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
test_output <- read.table(file="./UCI HAR Dataset/test/y_test.txt")
```

## Combine data
Below code with combine train and test dataset
```{r}
tcombined_data <- rbind(train_data, test_data)
combined_output <- rbind(train_output, test_output)
```

This line of code with add header for the data frame
```{r}
combined_data <- setNames(data.frame(tcombined_data), tmp_features[,2])
```

## Get the mean() and std() features
```{r}
meanandstd_features <- features[grep("mean\\(\\)|std\\(\\)", features[,2]),2]
meanandstd_data <- combined_data[ , which(names(combined_data) %in% meanandstd_features)]
```

## Combine data and output to single dataframe
```{r}
combined_data_output <- cbind(meanandstd_data, combined_output)
```

## Add activity labels to data frame created
```{r}
actual_data <- merge(combined_data_output, activity_labels, by.x = "V1", by.y = "V1")
```

## Get means by activity for each features
```{r}
means_by_activity <- aggregate(actual_data[,2:67], by=list(Category=actual_data$V2), FUN=mean)
```

## Write the data set to the file
```{r}
write.table(means_by_activity, file = "./tidy_dataset.txt", row.name = FALSE)
```