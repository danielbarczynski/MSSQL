-- printing function
use learning;
go
alter function PrintMessage()
returns varchar(30) as
begin
	declare @str varchar(30) = 'hello world';
	return @str;
end

go
exec dbo.PrintMessage;

declare @print varchar(30) = dbo.PrintMessage();
print @print

-- logic function
go
create function AddNumber(@num int, @num2 int)
returns int
as 
begin
    declare @wynik int = 0
    set @wynik = @num + @num2
    return @wynik
end

go
select dbo.AddNumber(40, 66)
drop function AddNumber

--* you can use select in function as return
go
alter function funcsel()
returns table as 
return select * from people2;

go
select * from dbo.funcsel()

--* but not in the body (same insert into)
go
create function insertpeople(@person varchar(30))
returns varchar (30) as 
begin 
    -- insert into people2 values (@person); -- cannot use in function
    -- select * from people2; -- also cannot use
    return @person;
end

go
select dbo.insertpeople('damian');
