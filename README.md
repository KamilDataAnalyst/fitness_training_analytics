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
