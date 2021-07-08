/*
 * 1) Use DISTINCT to test if there are any accounts associated with more than one region.
 */ 

SELECT DISTINCT 
  a.name account,
  r.name region
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY account;

/* Udacity solutions to the problem 1): 
 * The below two queries have the same number of resulting rows (351), so we
 * know that every account is associated with only one region. If each account
 * was associated with more than one region, the first query should have
* returned more rows than the second query.
 */

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

/* and */

SELECT DISTINCT id, name
FROM accounts;


/* 
 * 2)  Have any sales reps worked on more than one account?
 */

SELECT DISTINCT 
  s.name sales_rep,
  a.name account
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
ORDER BY sales_rep;

/* Udacity solutions to the problem 2):
 * Actually all of the sales reps have worked on more than one account. The
 * fewest number of accounts any sales rep works on is 3. There are 50 sales
 * reps, and they all have more than one account. Using DISTINCT in the second
* query assures that all of the sales reps are accounted for in the first
* query.
 */

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;


/* and */

SELECT DISTINCT id, name
FROM accounts;

