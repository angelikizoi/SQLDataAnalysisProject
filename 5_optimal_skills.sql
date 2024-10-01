SELECT 
    skills_dim.skill_id,
    skills,
    COUNT(job_postings_fact.job_id) AS skill_count,
    ROUND(AVG(salary_year_avg),0) AS average_skill_payment
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
GROUP BY 
    skills_dim.skill_id,
    skills_dim.skills
HAVING 
    COUNT(job_postings_fact.job_id) > 15
ORDER BY
    average_skill_payment DESC,
    skill_count DESC
LIMIT 20;
