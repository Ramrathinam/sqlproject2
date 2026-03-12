***subqueries types* :**







**\* single row subquery**

 

\- returns only one row

\- often used with comparison operators like =,<,>,<=,>= ;



**\* multi row sub query**



\- returns multiple rows

\- used with operators like in, any, all;



**\* scalar subquery**



\- returns exactly one value (single row and column)

\- often used in select, where, having clauses;



**\* correlated subquery**



\- a subquery that references columns from the outer query.

\- executes repeatedly for each row in outer query;



* **subquery syntax :**



select column name (s) from the table\_name where column name operator ANY
(select column\_name from table\_name where condition)



**project : supply chain management system.**



* 10 - 15 tables
