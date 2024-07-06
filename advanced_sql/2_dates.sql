--TIME ZONE(+00) conversion to West African Time(-01) 
SELECT
     job_title_short as title,
     job_location as "location",
     job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WAT'  as "date"
FROM job_postings_fact
LIMIT 5;

--Using "EXTRACT" to get the MONTH and YEAR in the SELECT clause
SELECT
     job_title_short as title,
     job_location as "location",
     job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WAT'  as "date",
     EXTRACT(MONTH FROM job_posted_date) as date_month,
     EXTRACT(YEAR FROM job_posted_date) as date_year
FROM job_postings_fact
LIMIT 5;

--tracking Job_postings trends on monthly basis
SELECT
      job_id,
      EXTRACT(MONTH FROM job_posted_date) as monthly_trends
FROM 
    job_postings_fact
LIMIT 15;

--aggregating Job_postings trends on monthly bsais with specifics to "Data Analyst"
SELECT
      COUNT(job_id) as job_posted_count,
      EXTRACT(MONTH FROM job_posted_date) as monthly_trends
FROM 
    job_postings_fact
WHERE
     job_title_short =  'Data Analyst'
GROUP BY
        monthly_trends
ORDER BY 
     job_posted_count DESC
LIMIT 15;