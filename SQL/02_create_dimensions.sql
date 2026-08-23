CREATE TABLE DimExercise
(
	ExerciseID INT PRIMARY KEY,
	ExerciseRaw NVARCHAR(100),
	ExerciseClean NVARCHAR(100)
);

CREATE TABLE DimTraining
(
	TrainingID INT PRIMARY KEY,
	TrainingName NVARCHAR(100),
	TrainingDate DATE,
	DurationMinutes DECIMAL(5,1)
);