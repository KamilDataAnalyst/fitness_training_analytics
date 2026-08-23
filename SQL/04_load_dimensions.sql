INSERT INTO DimExercise
(
	ExerciseID,
	ExerciseRaw,
	ExerciseClean
)
SELECT DISTINCT
	ExerciseID,
	Cwiczenie_Raw,
	CASE
		WHEN Cwiczenie_Raw = 'Podciąganie na drążku nachwytem' THEN 'Pull-ups'
		WHEN Cwiczenie_Raw = 'triceps_1' THEN 'Dips'
		WHEN Cwiczenie_Raw LIKE '%triceps%' THEN 'Triceps'
		WHEN Cwiczenie_Raw = 'shoulders_14' THEN 'Lateral raise'
		WHEN Cwiczenie_Raw LIKE 'shoulders%' THEN 'Shoulders'
		WHEN Cwiczenie_Raw = 'exercise_chest_23' THEN 'Pike push-ups'
		WHEN Cwiczenie_Raw = 'chest_5' THEN 'Decline push-ups'
		WHEN Cwiczenie_Raw LIKE 'chest%' THEN 'Chest'
		WHEN Cwiczenie_Raw = 'thigh_4' THEN 'Dumbbell squat'
		WHEN Cwiczenie_Raw = 'exercise_thigh_13' THEN 'Bulgarian split squat'
		WHEN Cwiczenie_Raw LIKE 'thigh%' THEN 'Thighs'
		WHEN Cwiczenie_Raw LIKE '%gumą%' THEN 'Band-assisted pull-ups'
		WHEN Cwiczenie_Raw LIKE 'back%' THEN 'Back'
		WHEN Cwiczenie_Raw LIKE 'calf%' THEN 'Calves'
		WHEN Cwiczenie_Raw LIKE 'abs%' THEN 'Abs'
		WHEN Cwiczenie_Raw LIKE 'biceps%' THEN 'Biceps'
		ELSE Cwiczenie_Raw
	END AS ExerciseClean
FROM stg_GymData;

INSERT INTO DimTraining
(
	TrainingID,
	TrainingName,
	TrainingDate,
	DurationMinutes
)
SELECT DISTINCT
	Trening_ID,
	Nazwa_Treningu,
	Data_Treningu,
	Czas_Trwania_Min
FROM stg_GymData;