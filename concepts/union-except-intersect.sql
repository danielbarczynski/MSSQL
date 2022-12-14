-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- Every SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in every SELECT statement must also be in the same order
select * from students order by surname desc -- 35 records
select * from employees order by surname desc -- 42 records

--* THE TABLES AREN'T CONNECTED BY FOREIGN KEY!
create table p ( pname varchar(10))
create table p2 ( pname varchar(10))

insert into p values ('a'), ('a'), ('b'), ('c') 
insert into p2 values ('b'), ('b'), ('c'), ('d') 

-- union (distinct) 40 records
    select surname
    from students
union
    select surname
    from employees
order by surname desc

-- 4 records: a b c d (distinct)
select pname from p
union
select pname
from p2

-- union all 77 records
    select surname
    from students
union all
    select surname
    from employees
order by surname desc

-- EXCEPT returns distinct rows from the left input query that arent output by the right input query.
-- To combine the result sets of two queries that use EXCEPT or INTERSECT, the basic rules are:
-- The number and the order of the columns must be the same in all queries.
-- The data types must be compatible.

-- except 21 records 
-- so if there are any duplicates in second table, they will not be shown
    select surname
    from students
except
    select surname
    from employees
order by surname
-- asc by default

-- 1 record: a (distinct)
    select pname
    from p
except
    select pname
    from p2

-- INTERSECT returns distinct rows that are output by both the left and right input queries operator.
-- combining two tables when there are similarities (like inner join) - 1 record
    select surname
    from students
intersect
    select surname
    from employees
order by surname desc

-- 2 records: b, c (distinct)
    select pname
    from p
intersect
    select pname
    from p2