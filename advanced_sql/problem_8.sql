/*
Find job postings from the first quater that have a salary greater than $70k
- Combine job postings tables from the first quater 0f 2023 (Jan to Mar)
- Get job postings with an average yearly salary > $70k
*/

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quater1_job_postings
    WHERE 
        salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
    ORDER BY salary_year_avg DESC;