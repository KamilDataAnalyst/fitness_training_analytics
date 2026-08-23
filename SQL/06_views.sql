CREATE OR ALTER VIEW vw_BestSetProgression AS
WITH RankedSets AS (
	SELECT
		s.ExerciseID,
		e.ExerciseClean,
		s.TrainingID,
		t.TrainingDate,
		s.WeightKg,
		s.Repetitions,
		ROW_NUMBER() OVER (PARTITION BY s.ExerciseID, s.TrainingID ORDER BY s.WeightKg DESC, s.Repetitions DESC) AS rn
FROM FactTrainingSets s
JOIN DimExercise e ON s.ExerciseID = e.ExerciseID
JOIN DimTraining t ON s.TrainingID = t.TrainingID
WHERE e.ExerciseClean IN ('Pull-ups', 'Dips')
	AND s.WeightKg > 0
)
SELECT
	ExerciseID,
	ExerciseClean,
	TrainingID,
	TrainingDate,
	ROW_NUMBER() OVER (PARTITION BY ExerciseID ORDER BY TrainingDate, TrainingID) AS TrainingNumber,
	WeightKg,
	Repetitions
FROM RankedSets
WHERE rn = 1;

GO

CREATE OR ALTER VIEW vw_MonthlyTrainingVolume AS
SELECT
	FORMAT(t.TrainingDate, 'yyyy-MM') AS TrainingMonth,
	s.ExerciseID,
	e.ExerciseClean,
	COUNT(DISTINCT s.TrainingID) AS TrainingSessions,
	SUM(s.WeightKg * s.Repetitions) AS TrainingVolume
FROM FactTrainingSets s
JOIN DimExercise e ON s.ExerciseID = e.ExerciseID
JOIN DimTraining t ON s.TrainingID = t.TrainingID
WHERE e.ExerciseClean IN ('Pull-ups', 'Dips')
	AND s.WeightKg > 0
GROUP BY FORMAT(t.TrainingDate, 'yyyy-MM'), s.ExerciseID, e.ExerciseClean;