--There is no for-loop, only the while-loop:
declare @i int = 0;

while @i < 20
begin
    set @i = @i + 1;
	print @i;
if (@i >= 13)
    break;
else
    continue;
end



