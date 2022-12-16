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