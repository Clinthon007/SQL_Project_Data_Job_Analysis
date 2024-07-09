/*
✔✔QUESTION: What are the top-paying data analyst jobs?
-- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-- Focusing on job postings with specified salaries(Nulls removed).
-- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment opportunities
*/

WITH top_paying_jobs AS (
    SELECT
       job_id,
       job_title,
       salary_year_avg,
       name AS company_name
    FROM
       job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
       job_title_short = 'Data Analyst'
    AND job_location LIKE '%Africa%'
    AND salary_year_avg IS NOT NULL
    ORDER BY   salary_year_avg DESC
    LIMIT 10
)

SELECT 
      top_paying_jobs.*,
      skills
FROM top_paying_jobs
JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
       salary_year_avg DESC;