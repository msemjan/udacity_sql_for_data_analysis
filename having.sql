/* 
 * 1) How many of the sales reps have more than 5 accounts that they manage?
 */

SELECT s.name sales_rep, COUNT(*) num_accounts
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
GROUP BY sales_rep
HAVING COUNT(*) > 5
ORDER BY num_accounts;

/* We can obtain this using a Subquery as shown here: */
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
    FROM accounts a
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    GROUP BY s.id, s.name
    HAVING COUNT(*) > 5
    ORDER BY num_accounts) AS Table1;

/* 
 * 2) How many accounts have more than 20 orders?
 */

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
HAVING COUNT(*) > 20
ORDER BY num_orders;

/*
 * 3) Which account has the most orders?
 */

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
HAVING COUNT(*) > 20
ORDER BY num_orders DESC
LIMIT 1;

/*
 * 4) Which accounts spent more than 30,000 usd total across all orders?
 */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_orders DESC;

/*
 * 5) Which accounts spent less than 1,000 usd total across all orders?
 */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_orders;

/*
 * 6) Which account has spent the most with us?
 */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY total_orders DESC
LIMIT 1;

/*
 * 7) Which account has spent the least with us?
 */

SELECT a.id, a.name, SUM(o.total_amt_usd) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY total_orders
LIMIT 1;

/* 
 * 8) Which accounts used facebook as a channel to contact customers more than
 * 6 times?
 */

SELECT a.id, a.name, w.channel, COUNT(*) num_contacts
FROM accounts a
JOIN web_events w
on a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY num_contacts;

/*
 * 9) Which account used facebook most as a channel?
 */

SELECT a.id, a.name, w.channel, COUNT(*) num_contacts
FROM accounts a
JOIN web_events w
on a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING  w.channel = 'facebook'
ORDER BY num_contacts DESC
LIMIT 1;

/*
 * 10) Which channel was most frequently used by most accounts?
 */

SELECT a.id, a.name, w.channel, COUNT(*) num_contacts
FROM accounts a
JOIN web_events w
on a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY num_contacts DESC
LIMIT 10;
