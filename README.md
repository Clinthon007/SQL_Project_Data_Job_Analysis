# Introduction
 Dive into the data job market! Focusing on data analyst roles. This project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL Queries? Check them out here: [project_sql folder](/project_sql/).

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was made from the innate feeling of showing-off top-paying and in-demand skills, streamlining others to reveal optimal jobs.

### Questions I went on to answer using my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills sre required for these top-paying jobs?
3. What skills are most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
- **SQL** : The bedrock of my analysis, allowing me to query the database and unvail critical insights.
- PostgreSQL: The chosen DBMS which I felt was(is) ideal for handling job posting data.
- VS Code: I felt using it was appropriate for this task ahead of others as I'm more conversant with it.
- Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking/follow-up.

# The Analysis
Each query for this aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average_yearly_salary and Location, focusing on remote job. this query highlights the high paying opportunities in the field.
```sql
SELECT
     job_id,
     job_title,
     job_location,
     job_schedule_type,
     salary_year_avg,
     job_posted_date,
     name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location LIKE '%Anywhere%'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here's a breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range**:** Top 10 paying data analyst roles span from $184,000 to 650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
-**Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\Top_paying_roles.png)
*Bar1 chart was used to visualize the top data analyst salaries; "Google's Gemini" was used to generate this graph from my SQL query outcome.*


**2. Skills for Top Paying Jobs**
To understand what skills are required for the top_paying jobs, I joined the job postings with skills table data, which gave insights into what employers value for high-compensation roles.
```sql
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
    AND job_location LIKE '%Anywhere%'
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
```


| Skill      | Count |
|------------|-------|
| sql        | 8     |
| python     | 7     |
| tableau    | 6     | 
| excel      | 5     |
| pyspark    | 4     |
| bigquery   | 3     |
| looker     | 3     |
| sheets     | 3     |
| qlik       | 1     |
| databricks | 2     |
| aws        | 2     |
| spark      | 2     |
| power bi   | 1     |
| flow       | 2     |
| nosql      | 1     |
| scala      | 1     |
| java       | 1     |
| c++        | 1     |
| cassandra  | 1     |
| redshift   | 1     |
| airflow    | 1     |
| hadoop     | 1     |
| kafka      | 2     |
| no-sql     | 1     |
| redis      | 1     |
| mysql      | 1     |
| gcp        | 1     |


Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** leads with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other sought out skills are **R**, **Snowflake**, **Pandas**, and **Excel**, which show varying degrees in demand.


3. **In-Demand Skills for Data Analysts**

This query helped identify the skills most frequently requested in job postings, shifting focus on areas with high demand.

```sql
SELECT
     skills,
     COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY
       skills
ORDER BY
       demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **EXCEL** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

*Table of the demand for the top 5 skills in data analyst job postings:*

| Skills    | Demand Count |
|-----------|--------------|
| SQL       | 7291         |
| Excel     | 4611         |
| Python    | 4330         |
| Tableau   | 3745         |
| Power BI  | 2609         |

Among the listed skills, **SQL** has the highest demand, followed by **Excel** and **Python**. **Tableau** and **Power BI** also have significant demand, though less than the top 3 skills.

**4. Skills Based on Salary**

```sql
SELECT
     skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
       skills
ORDER BY
       avg_salary DESC
LIMIT 25;
```
Here's the breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML skills:** Top salaries are commanded by analysts skilled in big data technologies (Pyspark, Couchbase), Machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, Numpy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
-**Software Development & Deployment Proficiency:** knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucreative crossover between data analysis and engineering, premium on skills that facilitates automation and efficient data pipeline management.

- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearrch, Databricks, GCP) underscores the growing importance of cloud-based analytics environment, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

*Below's the chart showing average salary for the top 10 paying Data Analyst skills:*
![Top paying skills](assets\Top_paying_skills.png)


**5. Most Optimal Skills To Learn**

This was done through the combination of insights from the demand and salary data query. This query aim to point out skills that are both in high demand with high salary also, offering a strategic focus for honing skills.
```sql
SELECT
       skills_dim.skill_id,
       skills_dim.skills,
       COUNT(skills_job_dim.job_id) AS demand_count,
       ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
     COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here is the result formatted in a tabular form and sorted by salary, along with an analysis:
(I decided to use Table format sine I've been making use of Bar Chart)

| Skill ID | Skills      | Demand Count | Avg Salary  |
|----------|-------------|--------------|-------------|
| 8        | Go          | 27           | $115,320    |
| 234      | Confluence  | 11           | $114,210    |
| 97       | Hadoop      | 22           | $113,193    |
| 80       | Snowflake   | 37           | $112,948    |
| 74       | Azure       | 34           | $111,225    |
| 77       | BigQuery    | 13           | $109,654    |
| 76       | AWS         | 32           | $108,317    |
| 4        | Java        | 17           | $106,906    |
| 194      | SSIS        | 12           | $106,683    |
| 233      | Jira        | 20           | $104,918    |

**Analysis:**
1. **Demand and Salary Correlation:**
   - **Go** has the highest average salary ($115,320) with a moderate demand count (27).
   - **Snowflake** shows a high demand count (37) and a competitive salary ($112,948), indicating strong market demand.
   - **Azure** and **AWS** also have high demand counts (34 and 32, respectively) with slightly lower salaries compared to Go and Snowflake.

2. **Skills with Lower Demand and High Salary:**
   - **Confluence** has a lower demand count (11) but a relatively high average salary ($114,210).
   - **BigQuery** and **SSIS** have lower demand counts (13 and 12, respectively) but maintain competitive salaries ($109,654 and $106,683).

3. **Overall Trends:**
   - There is a general trend that skills with higher demand counts tend to have slightly lower average salaries compared to those with moderate demand, possibly due to supply and demand dynamics in the job market.
   - **Java** and **Jira** have moderate demand and competitive salaries, indicating consistent and steady market value.

This table and analysis provide a snapshot of the demand and salary trends for various skills, helping to identify which skills are both in demand and well-compensated.


# What I Learned

Throughout this project journey, I can say for sure I've been able to hone my SQL toolkit many steps further than before by doing the foloowing:

- **✨ Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for temp table maneuvres.

- **📉 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries. 

# **Conclusions**
## A. *Insights*
1. **Top-Paying Data Analyst Jobs**: the highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!.
2. **Skills for Top-Paying jobs**: high-paying data analyst jobs require advanced proficiency in **SQL**, suggesting it's a critical skill for earning a top salary.
3. **Most In-demand Skills**: **SQL** is also the most demanded skill in the data analyst job market, thus, making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as **SVN** and **Solidity**, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: **SQL** leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

## B. *Closing Thoughts*

This project enhanced my **SQL** skills and provided valuable insights into the data analyst job market. The findings from the analysis serves as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics. 