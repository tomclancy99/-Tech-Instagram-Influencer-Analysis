-- 1. How many unique post types are found in the 'fact_content' table?
select
	count(distinct post_type) as number_of_unique_post_types
from fact_content;

-- 2. What are the highest and lowest recorded impressions for each post type?
select
	post_type,
    max(impressions) as maximum_impressions,
    min(impressions) as minimum_impressions
from fact_content
group by post_type;

-- 3. Filter all the posts that were published on a weekend in the month of March and April and export them to a separate csv file.
select
	dd.month_name,
    dd.weekday_or_weekend,
    dd.weekday_name,
    fc.*
from dim_dates dd join fact_content fc on dd.date = fc.date
where dd.month_name in ("March", "April") and dd.weekday_or_weekend = 'Weekend';

-- 4. Create a report to get the statistics for the account. The final output includes the following fields:
-- • month_name
-- • total_profile_visits
-- • total_new_followers
select
	dd.month_name,
    sum(fa.profile_visits) as total_profile_visits,
    sum(fa.new_followers) as total_new_followers
from dim_dates dd join fact_account fa on dd.date = fa.date
group by dd.month_name;

-- 5. Write a CTE that calculates the 
-- total number of 'likes’ for each 'post_category' 
-- during the month of 'July' and 
-- subsequently, arrange the 'post_category' values in descending order according to their total likes.
select
	post_category,
    sum(likes) as total_likes
from fact_content 
where month(date) = 7
group by post_category
order by total_likes desc;

-- 6. Create a report that displays the unique post_category names alongside their respective counts for each month. The output should have three columns:
-- • month_name
-- • post_category_names
-- • post_category_count
-- Example:
-- • 'April', 'Earphone,Laptop,Mobile,Other Gadgets,Smartwatch', '5'
-- • 'February', 'Earphone,Laptop,Mobile,Smartwatch', '4'
select
	dd.month_name,
    group_concat(distinct fc.post_category) as post_category_names,
    count(distinct fc.post_category) as post_category_count
from fact_content fc join dim_dates dd on fc.date = dd.date
group by dd.month_name;

-- 7. What is the percentage breakdown of total reach by post type? The final output includes the following fields:
-- • post_type
-- • total_reach
-- • reach_percentage
select
	post_type,
    sum(reach) as total_reach,
    concat(round((sum(reach)*100)/(sum(sum(reach)) over()),2)," %") as reach_percentage
from fact_content
group by post_type;

-- 8. Create a report that includes the quarter, total comments, and total saves recorded for each post category. Assign the following quarter groupings:
-- 	(January, February, March) → “Q1”
-- 	(April, May, June) → “Q2”
-- 	(July, August, September) → “Q3”
-- The final output columns should consist of:
-- • post_category
-- • quarter
-- • total_comments
-- • total_saves

with cte as (select
	post_category,
    case
		when month(date) in (1,2,3) then "Q1"
        when month(date) in (4,5,6) then "Q2"
        else "Q3"
    end as quarter,
    month(date) as month_no,
    comments,
    saves
from fact_content)

select	
	post_category,
    quarter,
    sum(comments) as total_comments,
    sum(saves) as total_saves
from cte
group by post_category,quarter;

-- 9. List the top three dates in each month with the highest number of new followers. The final output should include the following columns:
-- • month
-- • date
-- • new_followers
with cte as (select
	dd.month_name,
    dd.date,
    fc.new_followers,
    dense_rank() over(partition by dd.month_name order by fc.new_followers desc) as d_rank
from fact_account fc join dim_dates dd on fc.date = dd.date)
select
	month_name as month,
    date,
    new_followers
from cte
where d_rank in (1,2,3);

-- 10. Create a stored procedure that takes the 'Week_no' as input and generates a report displaying the total shares for each 'Post_type'. The output of the procedure should consist of two columns:
-- • post_type
-- • total_shares
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(in week_no int)
BEGIN
	select
	fc.post_type,
    sum(fc.shares) as total_shares
from fact_content fc join dim_dates dd on fc.date =  dd.date
where dd.week_no = concat("W",week_no)
group by fc.post_type;
END

