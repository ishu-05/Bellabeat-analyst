--========================================================================================
-- QUESTION 1: What's the distribution of activity levels across users?
--========================================================================================

/*Calculating per-user averages first, rather than jumping straight to a population-wide average, 
to check whether users behave similarly enough for one overall number to be meaningful.*/
SELECT 
id,
ROUND(AVG(VeryActiveMinutes)::NUMERIC, 2) AS avg_very_active_minutes,
ROUND(AVG(FairlyActiveMinutes)::NUMERIC, 2) AS avg_fairly_active_minutes,
ROUND(AVG(LightlyActiveMinutes)::NUMERIC, 2) AS avg_lightly_active_minutes,
ROUND(AVG(SedentaryMinutes)::NUMERIC, 2) AS avg_sedentary_minutes
FROM daily_activity
GROUP BY id
ORDER BY id;

/*this command tells us about the overall average activity trends level of all the users*/
SELECT 
ROUND(AVG(VeryActiveMinutes)::NUMERIC, 2) AS avg_very_active_minutes,
ROUND(AVG(FairlyActiveMinutes)::NUMERIC, 2) AS avg_fairly_active_minutes,
ROUND(AVG(LightlyActiveMinutes)::NUMERIC, 2) AS avg_lightly_active_minutes,
ROUND(AVG(SedentaryMinutes)::NUMERIC, 2) AS avg_sedentary_minutes
FROM daily_activity;

/*this command is used to calculate the minimum, maximum, average and standard deviation of the average sedentary minutes of all users.
to check for variation across users. Result: sedentary minutes ranged from ~662 to ~1317 with a high standard 
deviation (227.68), indicating the population average conceals real differences between users*/
SELECT 
MIN(avg_sedentary) AS min_sedentary,
MAX(avg_sedentary) AS max_sedentary,
ROUND(STDDEV(avg_sedentary)::NUMERIC, 2) AS stddev_sedentary
FROM (
SELECT id, AVG(SedentaryMinutes) AS avg_sedentary
FROM daily_activity
GROUP BY id
) AS per_user_avg;


/*this command is used to segment the users into two groups based on their average sedentary minutes.
Segments users into two groups based on the natural gap found around 850–1000 minutes. 
Result: 13 users 'Moderately Sedentary' (~746 min avg) vs. 20 users 'Highly Sedentary' (~1164 min avg)*/
SELECT 
CASE 
WHEN avg_sedentary <= 850 THEN 'Moderately Sedentary'
ELSE 'Highly Sedentary'
END AS sedentary_segment,
COUNT(*) AS num_users,
ROUND(AVG(avg_sedentary)::NUMERIC, 2) AS segment_avg_minutes
FROM (
SELECT id, AVG(SedentaryMinutes) AS avg_sedentary
FROM daily_activity
GROUP BY id
) AS per_user_avg
GROUP BY sedentary_segment;



--========================================================================================
-- QUESTION 2: Is there a relationship between total steps and calories burned?
--========================================================================================

/* this command is used to analyze the relationship between total steps and calories burned per user. It helps us to identify if users who walk more burn more calories. */
SELECT id, activitydate, totalsteps, calories
FROM daily_activity
ORDER BY id, activitydate;

/* this command is used to count the the number of days where
calories and count is both zero, This might indicate that the
user may not have worn the device on those days. */
SELECT COUNT(*) AS zero_step_zero_cal_days
FROM daily_activity
WHERE totalsteps = 0 AND calories = 0;

/* this command helps us to find the correlation between total steps and total calories.
The result (0.587) indicated a moderate positive correlation, suggesting that 
as the number of steps increases, the total calories also tend to increase. */
SELECT 
ROUND(CORR(TotalSteps, Calories)::NUMERIC, 3) AS steps_calories_correlation
FROM daily_activity
WHERE NOT (TotalSteps = 0 AND Calories = 0);


--==============================================================================================================================
--QUESTION 3 : What does the intraday activity pattern look like — which hours of the day are people most/least active?
--==============================================================================================================================
/* this command is used to count the number of records for each hour of the day in the hourly_intensities table. 
It helps us to identify which hours of the day have the most and least activity records.*/
SELECT 
EXTRACT(HOUR FROM ActivityHour) AS hour_of_day,
COUNT(*) AS num_records
FROM hourly_intensities
GROUP BY EXTRACT(HOUR FROM ActivityHour)
ORDER BY hour_of_day;

/* this command is used to calculate the average total intensity for each hour of the day in the hourly_intensities table.
It helps us to identify which hours of the day have the highest and lowest average total intensity. */
SELECT
EXTRACT(hour from ActivityHour) as hour_of_day,
ROUND(avg(TotalIntensity)::NUMERIC,2) as avg_intensity
FROM hourly_intensities
GROUP BY hour_of_day
ORDER BY hour_of_day;


--==============================================================================================================================
--QUESTION 4 : How does activity vary by day of week?
--==============================================================================================================================

/* this command extracts the day name from the activity date and then calculates 
the average active minutes (sum of VeryActiveMinutes, FairlyActiveMinutes, and LightlyActiveMinutes) for each day of the week.
The results are grouped by day name and ordered accordingly. This analysis helps to identify patterns in user
activity levels across different days of the week, providing insights into when users are most and least active. */
SELECT 
TO_CHAR(activitydate, 'Day') AS day_name,
ROUND(AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes)::NUMERIC, 2) AS avg_active_minutes
FROM daily_activity
GROUP BY day_name;

