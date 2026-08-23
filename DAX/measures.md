# DAX 🧮 

This file contains the calculated table, calculated column and DAX measures used in the Power BI report.

## Calculated Table & Column

### DimDate

```DAX
DimDate =
CALENDAR (
    MIN(DimTraining[TrainingDate]),
    MAX(DimTraining[TrainingDate])
)
```

Creates a date table covering the full period available in the training data. It is used as the main date dimension for time-based analysis and filtering.

### MonthStart

```DAX
MonthStart =
DATE (
    YEAR ( DimDate[Date] ),
    MONTH ( DimDate[Date] ),
    1
)
```

Returns the first day of each month. This column provides a consistent monthly key used to connect date-based filtering with monthly analytical data.

---

## Measures

### Best Dips Set

```DAX
Best Dips Set =
VAR MaxWeight =
    CALCULATE(
        MAX(vw_BestSetProgression[WeightKg]),
        vw_BestSetProgression[ExerciseClean] = "Dips"
    )

VAR MaxReps =
    CALCULATE(
        MAX(vw_BestSetProgression[Repetitions]),
        vw_BestSetProgression[ExerciseClean] = "Dips",
        vw_BestSetProgression[WeightKg] = MaxWeight
    )

RETURN
    IF(
        NOT ISBLANK(MaxWeight),
        FORMAT(MaxWeight, "0") & " kg × " & FORMAT(MaxReps, "0"),
        "N/A"
    )
```

Returns the best recorded Dips set by finding the highest added weight and the highest number of repetitions performed at that weight.

### Best Pull-up Set

```DAX
Best Pull-up Set =
VAR MaxWeight =
    CALCULATE(
        MAX(vw_BestSetProgression[WeightKg]),
        vw_BestSetProgression[ExerciseClean] = "Pull-ups"
    )

VAR MaxReps =
    CALCULATE(
        MAX(vw_BestSetProgression[Repetitions]),
        vw_BestSetProgression[ExerciseClean] = "Pull-ups",
        vw_BestSetProgression[WeightKg] = MaxWeight
    )

RETURN
    IF(
        NOT ISBLANK(MaxWeight),
        FORMAT(MaxWeight, "0") & " kg × " & FORMAT(MaxReps, "0"),
        "N/A"
    )
```

Returns the best recorded Pull-ups set using the highest added weight and the maximum repetitions performed at that weight.

### Reps at Top Weight

```DAX
Reps at Top Weight =
VAR MaxWeightInTraining = MAX(vw_BestSetProgression[WeightKg])
RETURN
    CALCULATE(
        MAX(vw_BestSetProgression[Repetitions]),
        vw_BestSetProgression[WeightKg] = MaxWeightInTraining
    )
```

Returns the highest number of repetitions performed at the maximum added weight within the current filter context.

### Estimated 1RM

```DAX
Estimated 1RM =
VAR BodyWeight  = 75
VAR AddedWeight = MAX(vw_BestSetProgression[WeightKg])
VAR Reps = [Reps at Top Weight]
VAR TotalWeight = AddedWeight + BodyWeight
VAR Total1RM = TotalWeight * (1 + (Reps / 30))
RETURN
    Total1RM - BodyWeight
```

Estimates the maximum additional weight that could theoretically be used for one repetition. The calculation uses the Epley formula and includes body weight in the total system load before converting the result back to estimated added weight.

### Avg Volume per Session

```DAX
Avg Volume per Session =
DIVIDE(
    SUM(vw_MonthlyTrainingVolume[TrainingVolume]),
    SUM(vw_MonthlyTrainingVolume[TrainingSessions]),
    0
)
```

Calculates the average training volume per session for the current filter context.

### Monthly Volume Filtered

```DAX
Monthly Volume Filtered =
CALCULATE(
    SUM(vw_MonthlyTrainingVolume[TrainingVolume]),
    KEEPFILTERS(
        TREATAS(
            VALUES(DimDate[MonthStart]),
            vw_MonthlyTrainingVolume[TrainingMonth]
        )
    )
)
```

Calculates monthly training volume while applying the selected months from `DimDate` to the monthly volume view.

`VALUES` returns the distinct months currently selected in the date filter context. `TREATAS` applies these values to `TrainingMonth`, creating a virtual relationship between the two columns without requiring a physical relationship in the data model. `KEEPFILTERS` preserves the existing filter context.

### Monthly Sessions Filtered

```DAX
Monthly Sessions Filtered =
CALCULATE(
    SUM(vw_MonthlyTrainingVolume[TrainingSessions]),
    KEEPFILTERS(
        TREATAS(
            VALUES(DimDate[MonthStart]),
            vw_MonthlyTrainingVolume[TrainingMonth]
        )
    )
)
```

Calculates the number of training sessions for the selected months.

The measure uses the same virtual relationship logic as `Monthly Volume Filtered`, allowing the date slicer to correctly filter the monthly training data.
