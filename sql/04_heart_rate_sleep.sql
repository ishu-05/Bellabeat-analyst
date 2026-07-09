/* 
    This SQL script calculates the resting heart rate estimate for each user based on the 10th percentile of their heart rate values. 
    It then computes the correlation between the resting heart rate estimate and the average active minutes from daily activity data.
*/

SELECT 
    id,
    ROUND(PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY value)::NUMERIC, 2) AS resting_hr_estimate
FROM heart_rate
GROUP BY id
ORDER BY id;


/* 
    This query calculates the average active minutes for each user based on their daily activity data.
    The correlation between the resting heart rate estimate and the average active minutes is then 
    computed to analyze the relationship between these two variables.
    The result 0.02 indicates a very weak positive correlation, suggesting that 
    there is little to no linear relationship between resting heart rate and average active minutes in this dataset.
*/
SELECT
   corr(resting_hr_estimate,avg_active_minutes)
FROM(
   SELECT
       hr_value.id,
       hr_value.resting_hr_estimate,
	   activity.avg_active_minutes 
   FROM (
       SELECT 
	   id,
	   ROUND(percentile_cont(0.1) WITHIN GROUP (ORDER BY heart_rate.value)::NUMERIC, 2) AS resting_hr_estimate
	   FROM heart_rate
	   GROUP BY id
   ) AS hr_value
JOIN (
    SELECT id, ROUND(AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes)::NUMERIC, 2) AS avg_active_minutes
    FROM daily_activity
    GROUP BY id
) AS activity
ON activity.id = hr_value.id
) AS info;
