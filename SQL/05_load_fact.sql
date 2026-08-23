INSERT INTO FactTrainingSets
(
	SeriesID,
	TrainingID,
	ExerciseID,
	SetNumber,
	Repetitions,
	WeightKg
)
SELECT
	Series_ID,
	Trening_ID,
	ExerciseID,
	Numer_Serii,
	Powtorzenia,
	Ciezar_KG
FROM stg_GymData;