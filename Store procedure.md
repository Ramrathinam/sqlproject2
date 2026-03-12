**Store procedure :**



* Store procedure s are precompiled collection of one or more SQL statements that can be executed as a unit. 
* They help to improve performance and security  by encapsuling logic on the server side





**Syntax :**



create procedure p\_n

as



begin 



--sql statements



end 





**Trigger:**



Triggers are special types of stored procedures that automatically execute in response to another certain events on the table or view, such as 

insert, update or delete.



**syntax :**



create trigger t\_n



for each row



after insert | update | delete on



begin   



sql statement 





end  

