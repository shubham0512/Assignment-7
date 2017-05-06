1) 
a = LOAD '/tmp/employee_details.txt' USING PigStorage(',') as (empid:int,empname:chararray,salary:int,rating:int);
b = ORDER a by rating desc,empname asc;
c = LIMIT b 5;
d = FOREACH c GENERATE empid,empname;dump d;

-----------------------------------------------------------------------------------------
2)
a = LOAD '/tmp/employee_details.txt' USING PigStorage(',') as (empid:int,empname:chararray,salary:int,rating:int);
b = foreach a generate empid,empname,salary,(CASE empid%2 WHEN 0 THEN 'Even' WHEN 1 THEN 'Odd' END) as Type;
c = FILTER b BY Type=='Odd';
d = ORDER c by salary desc,empname asc;
e = LIMIT d 3;
f = FOREACH e GENERATE empid,empname;

dump f;

------------------------------------------------------------------------------------------
3) 
a = LOAD '/tmp/employee_details.txt' USING PigStorage(',') as (empid:int,empname:chararray,salary:int,rating:int);
b = LOAD '/tmp/employee_expenses.txt' USING PigStorage('\t') as (empid:int,expenses:int);
c = JOIN a by empid,b by empid;
d = ORDER c by expenses desc,empname asc;
e = LIMIT d 1;
f = foreach a generate a.empid,a.empname;
dump f;


-------------------------------------------------------------------------------------------
4)
a = LOAD '/tmp/employee_details.txt' USING PigStorage(',') as (empid:int,empname:chararray,salary:int,rating:int);
b = LOAD '/tmp/employee_expenses.txt' USING PigStorage('\t') as (empid:int,expenses:int);
c = JOIN a by empid,b by empid;
d = foreach c generate a.empid,a.empname;
dump d;


-------------------------------------------------------------------------------------------
5)
a = LOAD '/tmp/employee_details.txt' USING PigStorage(',') as (empid:int,empname:chararray,salary:int,rating:int);
b = LOAD '/tmp/employee_expenses.txt' USING PigStorage('\t') as (empid:int,expenses:int);
c = JOIN a by empid full,b by empid;
d = filter c by b::empid is null;
e = FOREACH d GENERATE a.empid,a.empname;

dump e;


-------------------------------------------------------------------------------------------