-- A sp is group of T-SQL statement. If you have any kind of situation, where you are writing the 
-- same query over and over again, you can save that specific query as a stored procedure and then just call by it's name.
-- Basically wrapped this query into sp, and just call that sp.
go
create procedure sel
as
select *
from Persons
order by Age
go

sel

-- insert into procedure
--* difference is procedure allows select and DML (insert/update/delete) whereas function is not
--* funciont can be called with select, procedure with execute
go
create procedure AddHobby
    @HobbyName varchar (30)
as
insert into Hobbies
values
    (@HobbyName)

execute AddHobby 'Cars'
execute AddHobby 'Swimming'

-- procedure like a function
go
alter procedure sp_logic @num int, @num2 int as 
return @num + @num2;

declare @result int;
exec @result = sp_logic 4, 3;
print @result;