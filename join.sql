/*
 * 1) Try pulling all the data from the accounts table, and all the data from
 * the orders table.
 *
 * 2) Try pulling standard_qty, gloss_qty, and poster_qty from the orders
 * table, and the website and the primary_poc from the accounts table.
 */

SELECT 
  accounts.*, 
  orders.*
FROM 
  accounts
JOIN 
  orders
ON 
  accounts.id = orders.account_id;

SELECT 
  orders.standard_qty, 
  orders.gloss_qty, 
  orders.poster_qty,
  accounts.website, 
  accounts.primary_poc
FROM 
  accounts
JOIN 
  orders
ON 
  accounts.id = orders.account_id;

/* 
 * 1) Provide a table for all web_events associated with account name of
 * Walmart. There should be three columns. Be sure to include the primary_poc,
 * time of the event, and the channel for each event. Additionally, you might
 * choose to add a fourth column to assure only Walmart events were chosen.
 *
 * 2) Provide a table that provides the region for each sales_rep along with
 * their associated accounts. Your final table should include three columns:
 * the region name, the sales rep name, and the account name. Sort the accounts
 * alphabetically (A-Z) according to account name.
 * 
 * 3) Provide the name for each region for every order, as well as the account
 * name and the unit price they paid (total_amt_usd/total) for the order. Your
 * final table should have 3 columns: region name, account name, and unit
 * price. A few accounts have 0 for total, so I divided by (total + 0.01) to
 * assure not dividing by zero.
 */

SELECT
  a.name, 
  a.primary_poc, 
  w.occurred_at,
  w.channel
FROM
  accounts a
JOIN
  web_events w
ON 
  a.id = w.id
WHERE 
  a.name = 'Walmart';

SELECT
  r.name region,
  a.name account,
  s.name rep
FROM 
  accounts a
JOIN
  sales_reps s
ON 
  a.sales_rep_id = s.id
JOIN
  region r
ON
  s.region_id = r.id
ORDER BY a.name ASC;

SELECT
  a.name account,
  r.name region, 
  o.total_amt_usd / (o.total + 0.01) AS unit_price
FROM 
  accounts a
JOIN
  sales_reps s
ON 
  a.sales_rep_id = s.id
JOIN
  region r
ON 
  s.region_id = r.id
JOIN
  orders o
ON
  a.id = o.account_id;

/* 
 * 1) Provide a table that provides the region for each sales_rep along with
 * their associated accounts. This time only for the Midwest region. Your final
 * table should include three columns: the region name, the sales rep name, and
* the account name. Sort the accounts alphabetically (A-Z) according to account
* name.
 */

SELECT
  r.name AS region_name,
  s.name AS sales_rep_name,
  a.name AS account_name
FROM 
  accounts a
JOIN
  sales_reps s
ON 
  a.sales_rep_id = s.id
JOIN
  region r
ON
  r.id = s.region_id AND r.name = 'Midwest'
ORDER BY 
  a.name;

/* 
 * 2) Provide a table that provides the region for each sales_rep along with
 * their associated accounts. This time only for accounts where the sales rep
 * has a first name starting with S and in the Midwest region. Your final table
* should include three columns: the region name, the sales rep name, and the
* account name. Sort the accounts alphabetically (A-Z) according to account
 * name.
 */

SELECT
  r.name AS region_name,
  s.name AS sales_rep_name,
  a.name AS account_name
FROM 
  accounts a
JOIN
  sales_reps s
ON 
  a.sales_rep_id = s.id
JOIN
  region r
ON
  r.id = s.region_id AND r.name = 'Midwest' AND a.name LIKE 'S%'
ORDER BY 
  a.name;

/* 
 * 3) Provide a table that provides the region for each sales_rep along with
 * their associated accounts. This time only for accounts where the sales rep
 * has a last name starting with K and in the Midwest region. Your final table
 * should include three columns: the region name, the sales rep name, and the
 * account name. Sort the accounts alphabetically (A-Z) according to account
 * name.
 */ 

SELECT
  r.name AS region_name,
  s.name AS sales_rep_name,
  a.name AS account_name
FROM 
  accounts a
JOIN
  sales_reps s
ON 
  a.sales_rep_id = s.id
JOIN
  region r
ON
  r.id = s.region_id AND r.name = 'Midwest' AND sales_rep_name LIKE '% K%'
ORDER BY 
  a.name;

/* 
 * 4) Provide the name for each region for every order, as well as the account
 * name and the unit price they paid (total_amt_usd/total) for the order.
 * However, you should only provide the results if the standard order quantity
 * exceeds 100. Your final table should have 3 columns: region name, account
 * name, and unit price. In order to avoid a division by zero error, adding .01
 * to the denominator here is helpful total_amt_usd/(total+0.01).
 */

SELECT 
  r.name region, 
  a.name account, 
  o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

/* 
 * 5) Provide the name for each region for every order, as well as the account
 * name and the unit price they paid (total_amt_usd/total) for the order.
 * However, you should only provide the results if the standard order quantity
 * exceeds 100 and the poster order quantity exceeds 50. Your final table
 * should have 3 columns: region name, account name, and unit price. Sort for
 * the smallest unit price first. In order to avoid a division by zero error,
 * adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
 */ 

SELECT 
  r.name region, 
  a.name account, 
  o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50;
ORDER BY unit_price ASC;

/* 
 * 6) Provide the name for each region for every order, as well as the account
 * name and the unit price they paid (total_amt_usd/total) for the order.
 * However, you should only provide the results if the standard order quantity
 * exceeds 100 and the poster order quantity exceeds 50. Your final table
 * should have 3 columns: region name, account name, and unit price. Sort for
 * the largest unit price first. In order to avoid a division by zero error,
 * adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
 */

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

/* 
 * 7) What are the different channels used by account id 1001? Your final table
 * should have only 2 columns: account name and the different channels. You can
 * try SELECT DISTINCT to narrow down the results to only the unique values.
 */ 

SELECT DISTINCT
  a.name account_name,
  w.channel channel
FROM 
  accounts a
JOIN 
  web_events w
ON 
  a.id = w.account_id AND a.id = '1001';

/* 
 * 8) Find all the orders that occurred in 2015. Your final table should have 4
 * columns: occurred_at, account name, order total, and order total_amt_usd.
 */

SELECT
  o.occurred_at occurred_at,
   a.name account_name,
  o.total total,
  o.total_amt_usd total_amt_usd
FROM
  orders o
JOIN 
  accounts a
ON 
  o.account_id = a.id
WHERE 
  o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY 
  o.occurred_at DESC;
