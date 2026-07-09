/* 
    This query calculates the engagement consistency of users based on their sleep logs.
    It counts the number of days each user has logged sleep data and calculates the percentage
    of days they have logged sleep data out of a 31-day period. Additionally, it counts the number
    of users who have not logged any sleep data at all.
*/

SELECT
    id,
    COUNT(*) AS days_logged,
	ROUND(COUNT(*)::NUMERIC / 31 * 100, 2) AS consistency_pct
FROM sleep_day
GROUP BY id
ORDER BY id;


/* 
    This query counts the number of users who have not logged any sleep data.
*/
SELECT COUNT(DISTINCT id) AS users_with_zero_sleep_logs
FROM daily_activity
WHERE id NOT IN (SELECT DISTINCT id FROM sleep_day);

/*This analysis compares users' sleep consistency with their average daily activity levels,
 helping identify whether individuals who maintain more consistent sleep patterns also tend 
 to be more physically active.*/
SELECT 
    consistency.id,
    consistency.consistency_pct,
    activity.avg_active_minutes
FROM (
    SELECT id, ROUND(COUNT(*)::NUMERIC / 31 * 100, 2) AS consistency_pct
    FROM sleep_day
    GROUP BY id
) AS consistency
JOIN (
    SELECT id, ROUND(AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes)::NUMERIC, 2) AS avg_active_minutes
    FROM daily_activity
    GROUP BY id
) AS activity
ON consistency.id = activity.id;


/* 
    This query calculates the correlation between engagement consistency and average active minutes.
    It joins the consistency percentage of users with their average active minutes and computes the correlation.
    The result 0.4009 indicates a weak-to-moderate positive correlation, suggesting that users who are more consistent in 
    logging their sleep data tend to have higher average active minutes.
*/
SELECT
    corr(consistency_pct, avg_active_minutes) AS correlation
FROM (
    SELECT
        consistency.id,
        consistency.consistency_pct,
        activity.avg_active_minutes
    FROM (
        SELECT
            id,
            ROUND(COUNT(*)::NUMERIC / 31 * 100, 2) AS consistency_pct
        FROM sleep_day
        GROUP BY id
    ) AS consistency
    JOIN (
        SELECT
            id,
            ROUND(
                AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes)::NUMERIC,
                2
            ) AS avg_active_minutes
        FROM daily_activity
        GROUP BY id
    ) AS activity
    ON consistency.id = activity.id
) AS data;


