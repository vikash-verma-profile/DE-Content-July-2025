-- Task 1: Get latest page view per user using ROW_NUMBER
SELECT *
FROM (
    SELECT 
        id,
        user_id,
        page,
        view_time,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY view_time DESC) AS rn
    FROM page_views
) AS ranked
WHERE rn = 1;

-- Task 2: Time difference between consecutive page views using LAG
SELECT 
    user_id,
    page,
    view_time,
    LAG(view_time) OVER (PARTITION BY user_id ORDER BY view_time) AS previous_view_time,
    TIMESTAMPDIFF(SECOND, 
        LAG(view_time) OVER (PARTITION BY user_id ORDER BY view_time), 
        view_time
    ) AS time_gap_seconds
FROM page_views;

-- Task 3: Top 3 most viewed pages per user based on frequency using RANK
WITH page_counts AS (
    SELECT 
        user_id,
        page,
        COUNT(*) AS view_count
    FROM page_views
    GROUP BY user_id, page
)
SELECT *
FROM (
    SELECT 
        user_id,
        page,
        view_count,
        RANK() OVER (PARTITION BY user_id ORDER BY view_count DESC) AS rnk
    FROM page_counts
) AS ranked_pages
WHERE rnk <= 3;
