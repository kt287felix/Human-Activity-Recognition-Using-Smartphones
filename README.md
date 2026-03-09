# Getting and Cleaning Data — Course Project

## Overview

This repository contains the R script and documentation for the **Getting and Cleaning Data** course project. The goal is to collect, clean, and transform accelerometer data from Samsung Galaxy S smartphones into a tidy dataset ready for analysis.

---

## Repository Contents

| File | Description |
|------|-------------|
| `run_analysis.R` | Main script — performs all 5 steps |
| `tidy_data.txt` | Output tidy dataset (180 rows × 68 columns) |
| `CodeBook.md` | Describes all variables and transformations |
| `README.md` | This file |

---

## Raw Data Source

**UCI HAR Dataset** — Human Activity Recognition Using Smartphones  
Download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

---

## How to Run

1. Download and unzip the dataset so your working directory contains the folder `UCI HAR Dataset/`
2. Open R and set your working directory to where `run_analysis.R` is located
3. Run:
```r
source("run_analysis.R")
```
4. Output file `tidy_data.txt` will be written to the working directory

**Dependencies:** `dplyr` (install with `install.packages("dplyr")`)

---

## What the Script Does

### Step 1 — Merge training and test sets
Reads `X_train.txt`, `y_train.txt`, `subject_train.txt` and their test equivalents. Binds rows then binds columns into one unified data frame (10,299 observations).

### Step 2 — Extract mean and standard deviation measurements
Uses `dplyr::select()` with `matches()` to keep only columns representing `mean()` and `std()` measurements, reducing to 66 feature columns plus subject and activity.

### Step 3 — Apply descriptive activity names
Joins the `activity_labels.txt` lookup table to replace numeric codes (1–6) with readable labels (e.g. `WALKING`, `SITTING`).

### Step 4 — Label variables with descriptive names
Applies a series of `gsub()` transformations:
- `t` prefix → `Time`
- `f` prefix → `Frequency`
- `Acc` → `Accelerometer`
- `Gyro` → `Gyroscope`
- `Mag` → `Magnitude`
- Removes redundant dots and fixes `BodyBody` typo

### Step 5 — Create tidy summary dataset
Groups by `subject` (1–30) and `activity` (6 levels), computes the **mean** of every feature column using `summarise(across(..., mean))`. Produces 180 rows (30 subjects × 6 activities) and writes to `tidy_data.txt`.
