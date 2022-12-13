--  View is a virtual table based on the result-set of an SQL statement.
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.
create view SimpleView as 
select * from Persons2
where Age < 40

go
select * from SimpleView;