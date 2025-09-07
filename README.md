# 📊 Tech Instagram Influencer Analysis

This project focuses on analyzing Instagram performance data using SQL to extract actionable business insights. The analysis covers follower growth, content effectiveness, and audience engagement across different time dimensions.

###  The project was developed as part of the Codebasics Virtual Internship, leveraging three key tables:
- dim_dates → calendar-related attributes (date, month, quarter, weekday, etc.)
- fact_account → account-level metrics (profile visits, new followers, etc.)
- fact_content → post-level metrics (post type, impressions, reach, likes, comments, saves, shares, etc.)

### 🔍 Business Objectives & SQL Solutions

The project addresses practical business questions by writing SQL queries with aggregations, window functions, CTEs, and stored procedures.
- Post Type Diversity
Counted the number of unique post types in the content dataset.

- Content Reach Extremes
Identified the maximum and minimum impressions recorded for each post type.

Weekend Campaign Monitoring

Filtered all posts published on weekends during March and April for export.

Account Statistics by Month

Summarized profile visits and new followers month by month.

Likes by Post Category (CTE Example)

Calculated total likes for each post category in July, sorted in descending order.

Post Category Variety by Month

Reported the distinct categories posted each month, along with their counts.

Reach Contribution by Post Type

Produced a percentage breakdown of total reach by post type.

Quarterly Engagement Report

Generated total comments and saves by post category, grouped into quarterly segments (Q1, Q2, Q3).

Top Growth Dates per Month

Identified the top 3 days in each month with the highest new follower growth using DENSE_RANK().

Stored Procedure: Weekly Shares Report

Created a parameterized stored procedure to return total shares by post type for a given week number.

⚙️ Key SQL Concepts Used

Aggregation (SUM, COUNT, MAX, MIN)

Grouping & Filtering (GROUP BY, HAVING, conditional filtering)

Window Functions (DENSE_RANK, SUM() OVER())

String Aggregation (GROUP_CONCAT)

Conditional Logic (CASE for quarters)

Common Table Expressions (CTEs) for modular queries

Stored Procedures for reusable business reports

📈 Business Value

This analysis provides marketing and strategy teams with:

Visibility into which post types and categories perform best

Insights into engagement patterns across time (month, quarter, weekday/weekend)

Identification of key growth dates for follower acquisition

Reusable SQL logic for report automation

🔗 Resources

SQL scripts and queries: 📂 Project SQL File

Presentation & walkthrough video: 🎥 Watch Here

✨ This project sharpened my ability to transform raw social media data into business insights, while practicing professional SQL techniques aligned with real-world analytics use cases.
