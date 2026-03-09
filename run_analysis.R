## run_analysis.R
## Getting and Cleaning Data - Course Project
## Requires the "UCI HAR Dataset" folder to be in your working directory.

library(dplyr)

# ─────────────────────────────────────────────
# 0. Load raw files
# ─────────────────────────────────────────────
features      <- read.table("UCI HAR Dataset/features.txt",
                            col.names = c("index", "feature"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                              col.names = c("code", "activity"))

# Training set
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                      col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.names = "activity_code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")

# Test set
X_test  <- read.table("UCI HAR Dataset/test/X_test.txt",
                      col.names = features$feature)
y_test  <- read.table("UCI HAR Dataset/test/y_test.txt",
                      col.names = "activity_code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")

# ─────────────────────────────────────────────
# 1. Merge training and test sets
# ─────────────────────────────────────────────
X       <- rbind(X_train, X_test)
y       <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

merged  <- cbind(subject, y, X)

# ─────────────────────────────────────────────
# 2. Extract only mean() and std() measurements
# ─────────────────────────────────────────────
tidy <- merged %>%
  select(subject, activity_code,
         matches("\\.(mean|std)\\."))   # keeps mean() and std() columns only

# ─────────────────────────────────────────────
# 3. Use descriptive activity names
# ─────────────────────────────────────────────
tidy <- tidy %>%
  left_join(activity_labels, by = c("activity_code" = "code")) %>%
  select(-activity_code) %>%
  relocate(subject, activity)

# ─────────────────────────────────────────────
# 4. Label variables with descriptive names
# ─────────────────────────────────────────────
names(tidy) <- names(tidy) %>%
  gsub("^t",           "Time",              .) %>%
  gsub("^f",           "Frequency",         .) %>%
  gsub("Acc",          "Accelerometer",     .) %>%
  gsub("Gyro",         "Gyroscope",         .) %>%
  gsub("Mag",          "Magnitude",         .) %>%
  gsub("BodyBody",     "Body",              .) %>%
  gsub("\\.mean\\.\\.", "Mean",             .) %>%
  gsub("\\.std\\.\\.",  "StdDev",           .) %>%
  gsub("\\.mean$",      "Mean",             .) %>%
  gsub("\\.std$",       "StdDev",           .) %>%
  gsub("\\.$",          "",                 .) %>%
  gsub("\\.",           "",                 .)

# ─────────────────────────────────────────────
# 5. Create independent tidy data set:
#    average of each variable by activity and subject
# ─────────────────────────────────────────────
tidy_summary <- tidy %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

write.table(tidy_summary, "tidy_data.txt", row.names = FALSE)

message("Done. Output written to tidy_data.txt")
