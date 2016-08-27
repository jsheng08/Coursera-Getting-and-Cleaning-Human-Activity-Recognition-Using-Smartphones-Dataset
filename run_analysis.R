# Get Working Directory
wd <- getwd()
data_dir <- file.path(wd, "data")

# Create Data Directory if not exists
if (!file.exists(data_dir))
{
  dir.create(data_dir)
}

# Getting Data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "Dataset.zip"
if (!file.exists(file.path(data_dir, f))) {
  download.file(url, file.path(path, f))
}

# Unzip the files if not exist
extracted_dir = file.path(data_dir, "UCI HAR Dataset")
if (!file.exists(extracted_dir)) {
  unzip(zipfile = f, exdir = data_dir)
}

# Get and merge Subject Data
subject_test_data = read.table(file.path(extracted_dir, "test", "subject_test.txt"))
subject_train_data = read.table(file.path(extracted_dir, "train", "subject_train.txt"))
subject_data = rbind(subject_test_data, subject_train_data)

# Get and merge X Data
X_test_data  = read.table(file.path(extracted_dir, "test", "X_test.txt"))
X_train_data = read.table(file.path(extracted_dir, "train", "X_train.txt"))
X_data = rbind(X_test_data, X_train_data)

# Get and merge Y Data
y_test_data  = read.table(file.path(extracted_dir, "test", "y_test.txt"))
y_train_data = read.table(file.path(extracted_dir, "train", "y_train.txt"))
y_data = rbind(y_test_data, y_train_data)

# Get mean and std based on features description
features <- read.table(file.path(extracted_dir, "features.txt"))
index_mean_std_features <- grep("mean\\(\\)|std\\(\\)", features[,2])
name_mean_std_features <- features[index_mean_std_features,2]

# Filter unwanted column and assign column name
tidy_data <- X_data[,index_mean_std_features]
colnames(tidy_data) <- name_mean_std_features

# Get activity description and append to tidy_data
activity_labels_table <- read.table(file.path(extracted_dir, "activity_labels.txt"))
activity_labels <- activity_labels_table[,2]
activity <- activity_labels[y_data$V1]
tidy_data <- cbind(activity, tidy_data)

# Append subject to tidy_data
subject <- subject_data$V1
tidy_data <- cbind(subject, tidy_data)

# Create independent tidy data
library(dplyr)
independent_tidy_data <- tidy_data %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# Write data to file
write.table(independent_tidy_data, file = "independent_tidy_data.txt", row.name = FALSE)