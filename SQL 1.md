SQL is divided like this:





**DDL – Data Definition Language**



**DML – Data Manipulation Language**



**DQL – Data Query Language**



**DCL – Data Control Language**



**TCL – Transaction Control Language**



### 

### DDL – Data Definition Language



DDL is used to define or modify the structure of database objects like:



* Tables



* Databases



* Columns



* Constraints



Main DDL Commands:



* CREATE



* ALTER



* DROP



* TRUNCATE



* RENAME





#### **CREATE TABLE:**



**syntax:**



**CREATE TABLE students (**

    **id INT,**

    **name VARCHAR(50),**

    **age INT**

**);**



The table students will be created and it will have 3 columns (id, name, age).





#### **ALTER:**



1. used to change the structure of the table 
2. It is used to add column

#### **DROP:**





**Syntax:**



DROP TABLE students;





1)Removes entire table



2)Structure + data both gone



3)Cannot use table again unless recreated



#### **TRUNCATE:**



1)Removes all rows



2)Structure remains



3)Faster than DELETE



4)Cannot use WHERE condition



#### **DELETE:**



**Syntax:**



DELETE FROM students;



1)Removes rows



2)Structure remains



3)Can use WHERE condition



4)Slower than TRUNCATE



#### **RENAME:**



1. **It** is used to change the name of the table.



**syntax:**



rename table students to student details

