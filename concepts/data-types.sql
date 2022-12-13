print 'hello world'

-- (digit of all numbers, numbers after point)
declare @decimal decimal(5, 2) = 199.99;
print @decimal;

-- hh:mm:ss[.nnnnnnn]
declare @time time(7) = '12:34:54';  
print @time;

-- yyyy-mm-dd
declare @date date = '2000-01-08';
print @date;

declare @pesel char(11) = '12345678910';
print @pesel;

declare @isBool bit = 1;
print @isBool;

-- prints Jan 8 2000 6:05AM
declare @datetime datetime = '2000-01-08 6:05:00'
print @datetime
