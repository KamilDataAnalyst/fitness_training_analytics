# 🏋️ Fitness Data Analysis

This is a data analysis project based on my personal training data from the Gymlify app.

The dataset covers approximately 7–10 months of training history, depending on the exercise being analyzed. The main goal was to analyze strength progression in weighted Pull-ups and Dips, compare changes over time, and calculate additional performance metrics.

The project resulted in an interactive Power BI dashboard presenting the analysis and key insights.

## 🎯 Project Goal

The main goal of the project was to analyze how weighted Pull-ups and Dips progressed over time.

I focused on strength progression, changes in estimated 1RM, and monthly training volume. I also compared monthly training volume, the number of training sessions, and average volume per session.

## 🛠️ Tools & Technologies

| Tool                   | Usage                                                                                                                       |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **SQLite**             | Inspected the raw `.sqlite3` database and extracted key columns into a staging table.                                       |
| **SQL Server** | Cleaned and transformed the data, built the Star Schema, and created analytical views for Power BI.                         |
| **DAX**                | Created the date table and analytical measures, including estimated 1RM, KPI metrics, and virtual filtering with `TREATAS`. |
| **Power BI**           | Built an interactive and easy-to-understand dashboard for analyzing the training data.                                      |

## 🔄 Data Pipeline

The process started with inspecting the raw SQLite database and extracting the required data into a staging table. The data was then cleaned and transformed in SQL Server, where I built a Star Schema and prepared analytical views.

Finally, I created DAX measures and used the prepared data to build an interactive Power BI dashboard.

## 🗄️ Data Model — Star Schema

The data model was designed using a Star Schema approach. It consists of one fact table, `FactTrainingSets`, and two dimension tables: `DimTraining` and `DimExercise`.

`FactTrainingSets` stores data at the individual set level, while the dimension tables provide descriptive information about training sessions and exercises.

<details>
<summary>View SQL Server Star Schema</summary>

![SQL Server Data Model](Screenshots/sql_data_model.png)

</details>
