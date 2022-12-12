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