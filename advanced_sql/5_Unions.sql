--1)--------UNION------------------------------------------------
--Get jobs and companies from JANUARY
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    january_jobs
UNION

--Get jobs and companies from FEBRUARY
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    february_jobs
UNION 

--Get jobs and companies from MARCH
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    march_jobs;


--2)-----------UNION ALL------------------------------------------

--Get jobs and companies from JANUARY
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    january_jobs
UNION ALL

--Get jobs and companies from FEBRUARY
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    february_jobs
UNION ALL 

--Get jobs and companies from MARCH
SELECT
      job_title_short,
      company_id,
      job_location
FROM
    march_jobs;