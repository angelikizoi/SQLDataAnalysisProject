WITH top_skills_id AS (
    SELECT skill_id, COUNT(job_postings_fact.job_id) AS skill_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
    GROUP BY skill_id)
SELECT 
    top_skills_id.*,
    skills,
    ROUND(skill_count/(SELECT SUM(skill_count) FROM top_skills_id) * 100, 2) || '%' AS skill_perc
FROM top_skills_id
INNER JOIN skills_dim ON top_skills_id.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 10;
