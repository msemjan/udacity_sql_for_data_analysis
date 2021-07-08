/* Create a column that divides the standard_amt_usd by the standard_qty to
 * find the unit price for standard paper for each order. Limit the results to
 * the first 10 orders, and include the id and account_id fields. 
 */ 

SELECT 
  id, 
  standard_amt_usd / standard_qty AS standard_unit_price,
  account_id
FROM 
  orders
LIMIT 10;

/* Write a query that finds the percentage of revenue that comes from poster
 * paper for each order. You will need to use only the columns that end with
 * _usd. (Try to do this without using the total column.) Display the id and
 * account_id fields also. NOTE - you will receive an error with the correct
 * solution to this question. This occurs because at least one of the values in
 * the data creates a division by zero in your formula. You will learn later in
 * the course how to fully handle this issue. For now, you can just limit your
 * calculations to the first 10 orders, as we did in question #1, and you'll
 * avoid that set of data that causes the problem. 
 */

SELECT 
  id,
  account_id,
  poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_precentage
FROM
  orders  
LIMIT 10;
