-- DELETE 
-- DML COMMAND
-- Delete Rows from the table one by one
-- We can use where clause with Delete to delete single row
-- Delete is slower than truncate
-- ROLLBACK is possible with DELETE
delete from
    Persons2
where
    Id > 10
    
-- DROP
-- DDL COMMAND
-- Delete the entire structure or schema
-- We can't use where clause with drop
-- Drop is slower than DELETE & TRUNCATE
-- ROLLBACK IS NOT POSSIBLE WITH DROP
drop table Persons2
drop database test
drop function AddNumber

-- TRUNCATE
-- DDL COMMAND
-- Truncate deletes rows at a one goal
-- We can't use where clause with Truncate
-- Truncate faster than both DELETE & DROP
-- Rollback is not possible with Truncate
create table Persons3
(
    Id int
)
insert into
    Persons3
values
    (1),
    (2),
    (3)
select
    *
from
    Persons3
truncate table Persons3