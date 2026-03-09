# CodeBook — Human Activity Recognition Tidy Dataset

## Study Design

Data was collected from 30 volunteers (ages 19–48) wearing a Samsung Galaxy S II smartphone on the waist. Each person performed six activities. The embedded accelerometer and gyroscope captured 3-axial linear acceleration and angular velocity at 50Hz.

The original dataset was randomly partitioned: 70% training, 30% test. This analysis merges both sets.

**Original source:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

---

## Output File

**`tidy_data.txt`** — space-separated, header row included, 180 rows × 68 columns.  
Each row is the **mean** of all observations for one subject–activity combination.

---

## Identifier Variables

| Variable | Type | Values | Description |
|----------|------|--------|-------------|
| `subject` | integer | 1–30 | ID of the volunteer |
| `activity` | character | See below | Activity performed |

**Activity labels:**

| Code | Label |
|------|-------|
| 1 | WALKING |
| 2 | WALKING_UPSTAIRS |
| 3 | WALKING_DOWNSTAIRS |
| 4 | SITTING |
| 5 | STANDING |
| 6 | LAYING |

---

## Feature Variables (66 columns)

All feature values are **normalized and bounded within [-1, 1]**.  
Each value in the tidy dataset is the **mean** of all observations for that subject–activity pair.

### Naming Convention

| Component | Meaning |
|-----------|---------|
| `Time` | Time domain signal |
| `Frequency` | Frequency domain signal (FFT applied) |
| `Accelerometer` | Signal from accelerometer |
| `Gyroscope` | Signal from gyroscope |
| `Body` | Body component of signal |
| `Gravity` | Gravity component of signal |
| `Magnitude` | Magnitude of 3D signal (Euclidean norm) |
| `Jerk` | Jerk signal (derivative of body linear acceleration / angular velocity) |
| `Mean` | Mean value |
| `StdDev` | Standard deviation |
| `X` / `Y` / `Z` | Axial direction |

### Complete Variable List

```
TimeBodyAccelerometerMeanX
TimeBodyAccelerometerMeanY
TimeBodyAccelerometerMeanZ
TimeBodyAccelerometerStdDevX
TimeBodyAccelerometerStdDevY
TimeBodyAccelerometerStdDevZ
TimeGravityAccelerometerMeanX
TimeGravityAccelerometerMeanY
TimeGravityAccelerometerMeanZ
TimeGravityAccelerometerStdDevX
TimeGravityAccelerometerStdDevY
TimeGravityAccelerometerStdDevZ
TimeBodyAccelerometerJerkMeanX
TimeBodyAccelerometerJerkMeanY
TimeBodyAccelerometerJerkMeanZ
TimeBodyAccelerometerJerkStdDevX
TimeBodyAccelerometerJerkStdDevY
TimeBodyAccelerometerJerkStdDevZ
TimeBodyGyroscopeMeanX
TimeBodyGyroscopeMeanY
TimeBodyGyroscopeMeanZ
TimeBodyGyroscopeStdDevX
TimeBodyGyroscopeStdDevY
TimeBodyGyroscopeStdDevZ
TimeBodyGyroscopeJerkMeanX
TimeBodyGyroscopeJerkMeanY
TimeBodyGyroscopeJerkMeanZ
TimeBodyGyroscopeJerkStdDevX
TimeBodyGyroscopeJerkStdDevY
TimeBodyGyroscopeJerkStdDevZ
TimeBodyAccelerometerMagnitudeMean
TimeBodyAccelerometerMagnitudeStdDev
TimeGravityAccelerometerMagnitudeMean
TimeGravityAccelerometerMagnitudeStdDev
TimeBodyAccelerometerJerkMagnitudeMean
TimeBodyAccelerometerJerkMagnitudeStdDev
TimeBodyGyroscopeMagnitudeMean
TimeBodyGyroscopeMagnitudeStdDev
TimeBodyGyroscopeJerkMagnitudeMean
TimeBodyGyroscopeJerkMagnitudeStdDev
FrequencyBodyAccelerometerMeanX
FrequencyBodyAccelerometerMeanY
FrequencyBodyAccelerometerMeanZ
FrequencyBodyAccelerometerStdDevX
FrequencyBodyAccelerometerStdDevY
FrequencyBodyAccelerometerStdDevZ
FrequencyBodyAccelerometerJerkMeanX
FrequencyBodyAccelerometerJerkMeanY
FrequencyBodyAccelerometerJerkMeanZ
FrequencyBodyAccelerometerJerkStdDevX
FrequencyBodyAccelerometerJerkStdDevY
FrequencyBodyAccelerometerJerkStdDevZ
FrequencyBodyGyroscopeMeanX
FrequencyBodyGyroscopeMeanY
FrequencyBodyGyroscopeMeanZ
FrequencyBodyGyroscopeStdDevX
FrequencyBodyGyroscopeStdDevY
FrequencyBodyGyroscopeStdDevZ
FrequencyBodyAccelerometerMagnitudeMean
FrequencyBodyAccelerometerMagnitudeStdDev
FrequencyBodyAccelerometerJerkMagnitudeMean
FrequencyBodyAccelerometerJerkMagnitudeStdDev
FrequencyBodyGyroscopeMagnitudeMean
FrequencyBodyGyroscopeMagnitudeStdDev
FrequencyBodyGyroscopeJerkMagnitudeMean
FrequencyBodyGyroscopeJerkMagnitudeStdDev
```

---

## Transformations Applied

1. **Merged** `X_train.txt` + `X_test.txt`, `y_train.txt` + `y_test.txt`, `subject_train.txt` + `subject_test.txt` using `rbind()` then `cbind()`
2. **Filtered** to keep only `mean()` and `std()` features (66 of 561 original features)
3. **Replaced** numeric activity codes with descriptive labels via join with `activity_labels.txt`
4. **Renamed** all feature columns using `gsub()` for full readability (see naming convention above)
5. **Summarised** by computing the `mean()` of each feature grouped by `subject` and `activity`, producing 180 rows (30 × 6)
