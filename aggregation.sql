/* 
 * 1) Find the total amount of poster_qty paper ordered in the orders table.
 *
 * 2) Find the total amount of standard_qty paper ordered in the orders table.
 * 
 * 3) Find the total dollar amount of sales using the total_amt_usd in the
 * orders table.
 * 
 * 4) Find the total amount spent on standard_amt_usd and gloss_amt_usd paper
 * for each order in the orders table. This should give a dollar amount for
 * each order in the table.
 * 
 * 5) Find the standard_amt_usd per unit of standard_qty paper. Your solution
 * should use both an aggregation and a mathematical operator. 
 */
/*
SELECT
  SUM(poster_qty) total_amt_poster,
  SUM(standard_qty) total_amt_standard,
  SUM(total_amt_usd) total_dollar_amt,
  SUM(standard_amt_usd) + SUM(gloss_amt_usd) std_and_gloss,
  SUM(standard_amt_usd) / SUM(standard_qty) total_standard_unit
FROM 
  orders;
*/ 


SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

/*
 * 1) When was the earliest order ever placed?
 */

SELECT MIN(occurred_at) 
FROM orders;

/* 
 * 2) Try performing the same query as in question 1 without using an
 * aggregation function.
 */

SELECT occurred_at 
FROM orders 
ORDER BY occurred_at
LIMIT 1;

/* 
 * 3) When did the most recent (latest) web_event occur?
 */

SELECT MAX(occurred_at)
FROM web_events;

/* 
 * 4) Try to perform the result of the previous query without using an aggregation function.
 */

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/* 
 * 5) Find the mean (AVERAGE) amount spent per order on each paper type, as
 * well as the mean amount of each paper type purchased per order. Your final
 * answer should have 6 values - one for each paper type for the average number
 * of sales, as well as the average amount.
 */ 

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

/* 
 * 6) Via the video, you might be interested in how to calculate the MEDIAN.
 * Though this is more advanced than what we have covered so far try finding -
 * what is the MEDIAN total_usd spent on all orders? Note, this is more
 * advanced than the topics we have covered thus far to build a general
 * solution, but we can hard code a solution in the following way.
 */ 

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/*
 * Since there are 6912 orders - we want the average of the 3457 and 3456 order
 * amounts when ordered. This is the average of 2483.16 and 2482.55. This gives
 * the median of 2482.855. This obviously isn't an ideal way to compute. If we
 * obtain new orders, we would have to change the limit. SQL didn't even
 * calculate the median for us. The above used a SUBQUERY, but you could use
 * any method to find the two necessary values, and then you just need the
 * average of them.
 */
