--daily_activity table
CREATE TABLE daily_activity (
    Id BIGINT,
    ActivityDate DATE,
    TotalSteps INTEGER,
    TotalDistance NUMERIC,
    TrackerDistance NUMERIC,
    LoggedActivitiesDistance NUMERIC,
    VeryActiveDistance NUMERIC,
    ModeratelyActiveDistance NUMERIC,a
    LightActiveDistance NUMERIC,
    SedentaryActiveDistance NUMERIC,
    VeryActiveMinutes INTEGER,
    FairlyActiveMinutes INTEGER,
    LightlyActiveMinutes INTEGER,
    SedentaryMinutes INTEGER,
    Calories INTEGER
);

--sleep_day table
CREATE TABLE sleep_day (
Id BIGINT,
Sleepday DATE,
TotalSleep INTEGER,
TotalMinutesAsleep NUMERIC,
TotalTimeInBed NUMERIC
);

--heart_rate table
CREATE TABLE heart_rate (
    Id BIGINT,
    Time TIMESTAMP,
    Value NUMERIC
);


--Hourly_intensities table
CREATE TABLE hourly_intensities (
Id BIGINT,
ActivityHour TIMESTAMP,
TotalIntensity NUMERIC,
AverageIntensity NUMERIC
);


--Hourly_steps table
CREATE TABLE hourly_steps (
Id BIGINT,
ActivityHour TIMESTAMP,
StepTotal INTEGER
)

--minute_sleep table
CREATE TABLE minute_sleep (
Id BIGINT,      
date TIMESTAMP,
value INTEGER,
logID BIGINT
);

--weight_log table
CREATE TABLE weight_log (
Id BIGINT,
Date TIMESTAMP,
WeightKg NUMERIC,
WeightPounds NUMERIC,
FAT INTEGER,
BMI NUMERIC,
IsManual BOOLEAN,
logId BIGINT
);

--to copy the data from csv to table, use the following command
COPY table_name
FROM 'path_to_csv_file'
DELIMITER ','
CSV HEADER;

