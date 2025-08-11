CREATE TABLE hospital (
			hospital_name VARCHAR(100),	
			location VARCHAR(70),	
			department VARCHAR(70),
			doctors_count INT,
			patients_count INT,
			admission_date DATE,
			discharge_date DATE,
			medical_expenses NUMERIC(10,2)
);

SELECT * FROM hospital;

-- Q1. Total Number of Patients
SELECT SUM(patients_count) AS total_patients
FROM hospital;

-- Q2. Average Number of Doctors per Hospital
SELECT hospital_name, 
ROUND(AVG(doctors_count)) AS avg_doctors
FROM hospital
GROUP BY hospital_name, doctors_count
ORDER BY avg_doctors DESC;

-- Q3. Top 3 Departments with the Highest Number of Patients
SELECT department, 
SUM(patients_count) AS highest_patients
FROM hospital
GROUP BY department
ORDER BY highest_patients DESC;

-- Q4. Hospital with the Maximum Medical Expenses
SELECT hospital_name,
SUM(medical_expenses) AS total_expenses
FROM hospital
GROUP BY hospital_name
ORDER BY total_expenses DESC;

-- Q5. Daily Average Medical Expenses
SELECT hospital_name, 
SUM(medical_expenses) / SUM(discharge_date - admission_date) AS day_wise_expenses 
FROM hospital
GROUP BY hospital_name
ORDER BY day_wise_expenses DESC;

-- Q6. Longest Hospital Stay
SELECT hospital_name,
SUM(discharge_date - admission_date) AS total_stay
FROM hospital
GROUP BY hospital_name 
ORDER BY total_stay DESC;

-- Q7. Total Patients Treated Per City
SELECT location,
SUM(patients_count) AS total
FROM hospital
GROUP BY location
ORDER BY total DESC;

-- Q8. Average Length of Stay Per Department
SELECT department,
ROUND (AVG (discharge_date - admission_date)) AS avg_stay
FROM hospital
GROUP BY department
ORDER BY avg_stay DESC;

-- Q9. Identify the 2 Department with the Lowest Number of Patients
SELECT department,
SUM (patients_count) AS total_Patients 
FROM hospital
GROUP BY department
ORDER BY total_patients
LIMIT 2;

-- Q10. Monthly Medical Expenses Report
SELECT 
TO_CHAR(DATE_TRUNC('month', admission_date), 'YYYY-MM') AS month, hospital_name,
SUM(medical_expenses) AS total_expenses
FROM hospital
GROUP BY DATE_TRUNC('month', admission_date), hospital_name
ORDER BY month, total_expenses;








