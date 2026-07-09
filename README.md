# Bellabeat Case Study: How Can a Wellness Company Play It Smart?

Google Data Analytics Capstone — Case Study 2, analyzing FitBit smart device usage data to inform marketing strategy for Bellabeat's **Leaf** wellness tracker.

## Business Task

Analyze smart device usage data from FitBit users to identify trends in activity, sleep, and engagement patterns, then apply these insights to Bellabeat's Leaf tracker to inform marketing strategy that increases user engagement and highlights Leaf's value across daily activity, sleep, and stress tracking.

## Data Source

[FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit-fitness-tracker-data) (CC0: Public Domain, via Mobius on Kaggle) — personal fitness tracker data from 30+ consenting FitBit users, including activity, steps, sleep, and heart rate.

**Key limitation:** a small, self-selected sample (33 users), with declining engagement across features — 100% activity logging, 73% sleep tracking, 42% heart rate tracking. This dataset was used as-is (not supplemented with additional data), with limitations documented and treated as findings in their own right rather than hidden.

## Tools & Pipeline

| Stage | Tool |
|---|---|
| Cleaning & exploration | Python (pandas, Jupyter) |
| Analysis | PostgreSQL |
| Visualization | Power BI |

Full pipeline: raw CSVs → Python cleaning (type conversion, duplicate removal, date/time standardization) → PostgreSQL (7 relational tables, 11 analytical queries across 5 SQL files) → Power BI (5-page interactive dashboard, DAX measures, custom date table).

## Key Findings

- **Activity is bimodal, not uniform.** Users split into two distinct sedentary-activity segments — 60% highly sedentary (~19 hrs/day), 40% moderately sedentary (~12 hrs/day) — suggesting Bellabeat needs two different messaging strategies, not a single activity goal.
- **Steps alone don't fully explain calories burned** (r = 0.59, moderate correlation) — supporting the value of Leaf's intensity tracking beyond simple step counts.
- **Daily activity follows a bimodal intraday rhythm**, peaking around lunchtime (12–13) and early evening (18–19) — informing when engagement notifications would land best.
- **More active users have meaningfully lower resting heart rates** (r = -0.69, n = 14) — the dashboard's strongest finding, reinforcing Leaf's cardiovascular fitness value proposition.
- **Feature engagement drops off sharply**: 73% of users track sleep, but only 42% track heart rate — a clear opportunity for Bellabeat to drive deeper feature adoption via Leaf.
- **Sleep quality is generally strong** among trackers (91.5% of tracked minutes are genuine sleep), though 2 users show notably higher restlessness, worth flagging as a stress-tracking use case.
- **Sleep duration does not predict next-day activity** (r = -0.08) — these behaviors appear largely independent, so messaging shouldn't assume one drives the other.

## Repository Structure

```
bellabeat-analysis/
├── data/
│   ├── raw/           # original Kaggle export
│   └── processed/      # cleaned CSVs, output of Python pipeline
├── python/             # cleaning & exploration notebook
├── sql/                # 5 files, 11 questions across Activity, Sleep, Engagement, Heart Rate
├── dashboard/           # dashboard file 
└── docs/                # detailed findings report, data cleaning log
```

## Dashboard

5-page interactive Power BI dashboard: Overview, Activity, Sleep, Engagement, and Heart Rate deep-dive. See `docs/report.md` and  for a detailed walkthrough of each visualization and its business implication.

## Top Recommendations

1. **Segment Leaf's activity messaging** — gentle activation nudges for highly sedentary users, progress/goal-tracking features for moderately active users, rather than one universal activity target.
2. **Lead with intensity and cardiovascular fitness, not just step counts** — the steps-calories and resting-HR findings both support marketing Leaf's deeper physiological tracking as a differentiator from simple pedometers.
3. **Invest in engagement-driving features** (reminders, streaks, personalized nudges) to close the adoption gap between activity tracking (100%) and sleep/heart-rate tracking (73%/42%) — the biggest opportunity found in this analysis isn't better data, it's better feature adoption.

## Author

Ishwandeep Kaur — [GitHub](https://github.com/ishu-05) · [LinkedIn](https://linkedin.com/in/ishwandeepkaur03)
