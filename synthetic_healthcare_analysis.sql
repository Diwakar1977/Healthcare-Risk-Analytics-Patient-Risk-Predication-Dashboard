-- Use Database
USE july;

-- Total Patients
SELECT COUNT(*)	total_patients FROM synthetic_healthcare;

-- Average Blood Suger Level
SELECT ROUND(AVG(blood_sugar_level),2) avg_blood_sugar FROM synthetic_healthcare;

-- Diabetes Patients Count
SELECT 
	has_diabetes,
    COUNT(*) Diabetes_Patients
FROM synthetic_healthcare
WHERE has_diabetes = 'Yes';

-- Heart Disease Patients Count
SELECT
	has_heart_disease,
    COUNT(*) Heart_Disease_Patients
FROM synthetic_healthcare
WHERE has_heart_disease = 'Yes';

-- Physical Activity Level Patients
SELECT 
	physical_activity_level,
    COUNT(*) Physical_level_patients
FROM synthetic_healthcare
GROUP BY physical_activity_level;

-- Diabetes Rate by Age Group 
SELECT
	age_group,
    ROUND(SUM(has_diabetes = 'Yes') / COUNT(*) * 100,2) Diabetes_Rate
FROM synthetic_healthcare
GROUP BY age_group;

-- Heart Disease Rate by Family History
SELECT 
	family_history_heart_disease,
	ROUND(SUM(has_heart_disease = 'Yes') / COUNT(*) * 100, 2) Heart_Disease_Rate
FROM synthetic_healthcare
GROUP BY family_history_heart_disease;

-- Average Blood Sugar by Physical Activity
SELECT 
	physical_activity_level,
    ROUND(AVG(blood_sugar_level),2) Avg_Blood_Sugar
FROM synthetic_healthcare
GROUP BY physical_activity_level;

-- Alcohol Consumption vs Heart Disease
SELECT 
	alcohol_consumption_per_week,
    COUNT(*) Total_Patients,
    ROUND(SUM(has_heart_disease = 'Yes') / COUNT(*) * 100,2) Heart_Disease,
    ROUND(SUM(has_heart_disease = 'No') / COUNT(*) * 100,2) normal
FROM synthetic_healthcare
GROUP BY alcohol_consumption_per_week;
    
SELECT 
	CASE 
    WHEN alcohol_consumption_per_week <= 2 THEN 'Low'
    WHEN alcohol_consumption_per_week BETWEEN 3 AND 7 THEN 'Medium'
    ELSE 'High' 
    END alcohol_level,
	ROUND(SUM(has_heart_disease = 'Yes') / COUNT(*) * 100,2) Heart_Disease,
    ROUND(SUM(has_heart_disease = 'No') / COUNT(*) * 100,2) Normal
FROM synthetic_healthcare
GROUP BY alcohol_level;

-- Chronic Condition Patients
SELECT
	has_chronic_condition,
    COUNT(*) Chronic_Condition
FROM synthetic_healthcare
GROUP BY has_chronic_condition;

-- High Risk Patients Multiple Conditions
SELECT *
FROM synthetic_healthcare
WHERE has_diabetes = 'Yes' 
AND has_heart_disease = 'Yes'
AND has_chronic_condition = 'Yes';

-- Avg Hospital Visits by Age Group 
SELECT 
	age_group,
    ROUND(AVG(hospital_visits_last_year),2) Avg_Hospital_Visits
FROM synthetic_healthcare
GROUP BY age_group;

-- Kidney Function vs Diabetes
SELECT 
	CASE
    WHEN kidney_function_score <= 60 THEN 'Poor'
    WHEN kidney_function_score BETWEEN 60 AND 80 THEN 'Medium'
    ELSE 'High'
    END Kidney_Health,
    ROUND(SUM(has_diabetes = 'Yes') / COUNT(*) * 100,2) Diabetes_Rate
FROM synthetic_healthcare
GROUP BY Kidney_Health;
    
-- Medication Usage Analysis
SELECT
	medication_count,
    COUNT(*) Total_Patients,
	ROUND(AVG(blood_sugar_level),2) Avg_Sugar_Level
FROM synthetic_healthcare
GROUP BY medication_count
ORDER BY medication_count;

-- Glucose Tolerance Risk Analysis
SELECT
	CASE
    WHEN glucose_tolerance_test >= 140 THEN 'High Risk'
    WHEN glucose_tolerance_test BETWEEN 100 AND 140 THEN 'Medium'
    ELSE 'Low'
    END AS Risk_level,
    COUNT(*) Total_Patients
FROM synthetic_healthcare
GROUP BY Risk_level;

-- High Risk Patients
SELECT * 
FROM synthetic_healthcare
ORDER BY (has_diabetes + has_heart_disease + has_chronic_condition) DESC,
blood_sugar_level DESC
LIMIT 10;

-- Life Style Impact Analysis
SELECT
	physical_activity_level,
	ROUND(AVG(blood_sugar_level),2)  Avg_sugar_level,
    ROUND(AVG(alcohol_consumption_per_week),2) Avg_alcohol_consumpation
FROM synthetic_healthcare
GROUP BY physical_activity_level;

-- Family History Impact on Diabetes
SELECT
	family_history_diabetes,
    COUNT(*) Total_Patients
FROM synthetic_healthcare
GROUP BY family_history_diabetes;

-- Prdective Risk Segmentation
SELECT 
	CASE
    WHEN blood_sugar_level >= 140 
    AND kidney_function_score >= 50
    AND hospital_visits_last_year >= 5
    THEN 'High risk'
    WHEN blood_sugar_level BETWEEN 100 AND 140 THEN 'Medium risk'
    ELSE 'Low risk'
    END Risk_segment,
    COUNT(*) Total_Patients
FROM synthetic_healthcare
GROUP BY Risk_segment;    
    
	