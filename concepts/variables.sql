declare @i int = 0;
declare @str varchar (30) = 'hello world';

print @i;
print @str;

select * from people2;

-- assign a value from the table
select @str = pname from people2 where age = 40;

-- assign all values from the table to the temp table
select pname into #temptb2 from people2;

print @str;

-- table
declare @array table (aname varchar(30));
insert into @array values ('manuel'), ('goffrey');
select * from @array;

-- print @array; -- can't print

-- cursor
declare my_cursor cursor for 
select age from people2

-- saving variables after go statement
go
declare @str varchar (30) = 'bye world';
select @str as str into #TempTb

go 

-- print @str; -- won't work
select * from #TempTb; -- works!
select * from #temptb2; 