/* 
 * 1) Which account (by name) placed the earliest order? Your solution should
 * have the account name and the date of the order.
 */

SELECT
  a.name,
  MIN(o.occurred_at) AS earliest_order
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY earliest_order
LIMIT 1;

/* Udacity solution to the problem 1) */

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/*
 * 2) Find the total sales in usd for each account. You should include two
 * columns - the total sales for each company's orders in usd and the company
 * name.
 */

SELECT
  a.name,
  SUM(o.total_amt_usd) AS total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_sales;

/* 
 * 3) Via what channel did the most recent (latest) web_event occur, which
 * account was associated with this web_event? Your query should return only
 * three values - the date, channel, and account name.
 */

SELECT 
  a.name account_name,
  MAX(w.occurred_at) the_date,
  w.channel channel
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name, w.channel
ORDER BY the_date DESC;
 
/* Udacity solution to the problem 3) */

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;

/*
 * 4) Find the total number of times each type of channel from the web_events
 * was used. Your final table should have two columns - the channel and the
 * number of times the channel was used.
 */

SELECT 
  COUNT(w.occurred_at) times_used,
  w.channel channel
FROM web_events w
GROUP BY w.channel
ORDER BY times_used DESC;

/* Udacity solution to the problem 4) */

SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

/*
 * 5) Who was the primary contact associated with the earliest web_event?
 */

SELECT 
  a.primary_poc poc,
  MIN(w.occurred_at) the_date
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY poc
ORDER BY the_date
LIMIT 1;

/* Udacity solution to the problem 5) */

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/* 
 * 6) What was the smallest order placed by each account in terms of total usd.
 * Provide only two columns - the account name and the total usd. Order from
 * smallest dollar amounts to largest.
 */

SELECT
  a.name,
  MIN(o.total_amt_usd) AS smallest_order
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

/* 
 * 7) Find the number of sales reps in each region. Your final table should
 * have two columns - the region and the number of sales_reps. Order from
 * fewest reps to most reps.
 */

SELECT 
  COUNT(s.id) num_of_sales,
  r.name region_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_of_sales;

/*
 * 8) For each account, determine the average amount of each type of paper they
 * purchased across their orders. Your result should have four columns - one
 * for the account name and one for the average quantity purchased for each of
 * the paper types for each account.
 */

SELECT 
  a.name account_name,
  AVG(o.standard_qty) avg_std,
  AVG(o.poster_qty) avg_post,
  AVG(o.gloss_qty) avg_glos
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;
  
/* 
 * 9) For each account, determine the average amount spent per order on each
 * paper type. Your result should have four columns - one for the account name
 * and one for the average amount spent on each paper type.
 */

SELECT 
  a.name account_name,
  AVG(o.standard_amt_usd) avg_std,
  AVG(o.poster_amt_usd) avg_post,
  AVG(o.gloss_amt_usd) avg_glos
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* 
 * 10) Determine the number of times a particular channel was used in the
 * web_events table for each sales rep. Your final table should have three
 * columns - the name of the sales rep, the channel, and the number of
 * occurrences. Order your table with the highest number of occurrences first.
 */

SELECT
  w.channel channel,
  s.name name_sales_rep,
  COUNT(w.occurred_at) num_occurrences
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY channel, name_sales_rep
ORDER BY num_occurrences DESC;

/* Udacity solution of the problem 10) */

SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

/* 
 * 11) Determine the number of times a particular channel was used in the
 * web_events table for each region. Your final table should have three columns
 * - the region name, the channel, and the number of occurrences. Order your
 * table with the highest number of occurrences first.
 */

SELECT
  r.name region,
  w.channel channel,
  COUNT(w.occurred_at) num_occurrences
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
GROUP BY channel, region 
ORDER BY num_occurrences DESC;

/* Udacity solution of the problem 11) */

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

