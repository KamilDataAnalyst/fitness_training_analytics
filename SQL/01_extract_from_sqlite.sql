SELECT 
    w.Id AS Trening_ID,
    w.Title AS Nazwa_Treningu,
    datetime(w.StartDate / 10000000 - 62135596800, 'unixepoch', 'localtime') AS Data_Treningu,
    ROUND((w.EndDate - w.StartDate) / 600000000.0, 1) AS Czas_TrwaniaMin,
    e.Id AS ExerciseID,
    COALESCE(e.OwnName, REPLACE(REPLACE(e.Image, 'excercise', ''), '.png', '')) AS Cwiczenie_Raw,
    s.Id AS Series_ID,
    s.Number AS Numer_Serii,
    s.Repeat AS Powtorzenia,
    s.Weight AS Ciezar_KG
FROM workouts w
INNER JOIN workoutExcercises we ON w.Id = we.WorkoutId
INNER JOIN series s ON we.Id = s.ExcerciseId
INNER JOIN excercises e ON we.DatabaseExcerciseId = e.Id
WHERE w.IsFinished = 1 AND s.IsFinished = 1
ORDER BY w.Id DESC, we.Id ASC, s.Number ASC; 