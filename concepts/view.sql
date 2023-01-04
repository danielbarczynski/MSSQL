--  View is a virtual table based on the result-set of an SQL statement.
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.
-- n brief, a programmer cannot create views without using tables.
alter view SimpleView
as
    select *
    from Persons
    where Age < 40

go
select *
from SimpleView;

create table test (tname varchar (30))
insert into test values ('hey'), ('bye')

go
create view testview as
select * from test 

go
drop table test

-- it wont work when the table is deleted - it just a data holder
select * from testview
