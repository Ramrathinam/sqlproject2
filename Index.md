# **Index**



**syntax:**



create index index

on table column;



CREATE INDEX idx\_empname

on empdetails (emp\_name);





**Window functions**



window function performs calculation across a set of table rows that are somehow related to the current row. unlike aggregate functions,

window functions do not cause rows to become grouped into single output row, rows contains their separate identities.



**syntax**





SELECT column1,

       column2,

       window\_function() OVER (

           PARTITION BY column

           ORDER BY column

       ) AS alias\_name

FROM table\_name;







**TYPES**



1. row\_number
2. rank()
3. dense\_rank()
4. sum() over (partition by)
5. avg() over (partition by)
6. lead() and lag()
