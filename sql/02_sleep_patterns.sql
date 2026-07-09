--==============================================================================================================================
--QUESTION 1: How much are users actually sleeping vs. general health guidelines?
--==============================================================================================================================
/* this command is used to calculates average hours slept per user, to compare against the general
health guideline of 7-9 hours/night. Note: only 24 of 33 users (73%) have
any logged sleep data  */
SELECT 
id,
ROUND(AVG((Totalminutesasleep::NUMERIC/60)),2) AS hours_slept
FROM sleep_day
GROUP BY id
ORDER BY id;


--==============================================================================================================================
--QUESTION 2: What's the gap between time in bed and time actually asleep?
--==============================================================================================================================

/* this command is used to calculate the average minutes awake in bed per user.
It helps us to identify the gap between time in bed and time actually asleep. 
We can identify users who face difficulty falling or staying asleep. */
SELECT 
id,
ROUND(AVG(TotalTimeInBed - TotalMinutesAsleep)::NUMERIC, 2) AS avg_minutes_awake_in_bed
FROM sleep_day
GROUP BY id
ORDER BY id;

/* the per-user breakdown above showed most users (22 of 24) fall within
a healthy 0-50 minute range, but 2 users show gaps over 100 minutes —
this query isolates those two individually rather than letting them
skew interpretation of the population average. */
SELECT id, ROUND(AVG(TotalTimeInBed - TotalMinutesAsleep)::NUMERIC, 2) AS avg_minutes_awake_in_bed
FROM sleep_day
GROUP BY id
HAVING AVG(TotalTimeInBed - TotalMinutesAsleep) > 100
ORDER BY avg_minutes_awake_in_bed DESC;

/* calculates the overall average minutes awake in bed across all 24 users
with sleep data, to establish the general/headline finding. */
SELECT ROUND(AVG(TotalTimeInBed - TotalMinutesAsleep)::NUMERIC, 2) AS avg_minutes_awake_in_bed
FROM sleep_day;


--==============================================================================================================================
--QUESTION 3: Minute-level restlessness during sleep 
--==============================================================================================================================
/* this command is used to calculate the total minutes logged, minutes asleep, minutes restless, and minutes awake per user.
Users with less than 5 hours of total logged data
were identified earlier as having insufficient data for a reliable percentage
and are excluded from this and the following query. */    
SELECT
    id,
    COUNT(*) AS total_minutes_logged,
    COUNT(CASE WHEN value = 1 THEN 1 END) AS minutes_asleep,
    COUNT(CASE WHEN value = 2 THEN 1 END) AS minutes_restless,
    COUNT(CASE WHEN value = 3 THEN 1 END) AS minutes_awake,
    ROUND(COUNT(CASE WHEN value = 1 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_asleep,
    ROUND(COUNT(CASE WHEN value = 2 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_restless,
    ROUND(COUNT(CASE WHEN value = 3 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_awake
FROM minute_sleep
GROUP BY id
HAVING COUNT(*)::NUMERIC / 60 >= 5
ORDER BY id;


/* calculates the overall percentage of minutes asleep, restless, and awake across all users with sufficient data. */
SELECT
    ROUND(COUNT(CASE WHEN value = 1 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_asleep,
    ROUND(COUNT(CASE WHEN value = 2 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_restless,
    ROUND(COUNT(CASE WHEN value = 3 THEN 1 END)::NUMERIC / COUNT(*) * 100, 2) AS pct_awake
FROM minute_sleep
WHERE id NOT IN (
    SELECT id FROM minute_sleep GROUP BY id HAVING COUNT(*)::NUMERIC / 60 < 5
);