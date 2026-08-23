CREATE TABLE FactTrainingSets
(
	SeriesID INT PRIMARY KEY,
	TrainingID INT FOREIGN KEY REFERENCES DimTraining(TrainingID),
	ExerciseID INT FOREIGN KEY REFERENCES DimExercise(ExerciseID),
	SetNumber INT,
	Repetitions INT,
	WeightKg DECIMAL(5,2)
);