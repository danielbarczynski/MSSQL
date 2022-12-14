-- unique key
CREATE TABLE Persons
(
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

-- many unique keys
CREATE TABLE Persons
(
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName)
);

-- procedure
GO
CREATE PROCEDURE nazwiska
AS
select surname
from students
GO;

exec nazwiska

-- trigger
CREATE TABLE Orders
(
    OrdID INT,
    OrdPiority varchar(10)
)
GO
CREATE TRIGGER tr_Orders_Insert
ON Orders
FOR INSERT
AS
IF( SELECT COUNT(*)
FROM Orders
WHERE OrdPiority = 'High') = 1 -- orders can also be written as 'inserted'
    BEGIN
    PRINT 'Email Code Goes Here'
END
GO
INSERT Orders
    (OrdPiority)
VALUES
    ('High')

-- function
GO
create function addNum(@number int)
returns int as
begin
    declare @wynik int = 5
    set @wynik = @wynik + @number
    return @wynik
end
GO

select [dbo].addNum(15)

select *
from students

-- subquery
select *
from students
where student_id in
(select student_id
from student_grades)
-- podzapytanie jest kompilowane pierwsze

-- aggregate function
select COUNT(surname)
from students

-- scalar function
SELECT lower(surname)
FROM students
select UPPER(surname)
from students

-- copy
Select *
into studentcopy
from students

-- empty table from existing table
select *
into studentcopy2
from studentcopy
where 0=1000
select *
from studentcopy2

-- fetching common records from 2 tables
    select student_id
    from students
intersect
    select student_id
    from student_grades

-- fetch first 5 characters from row
select *
from students
select SUBSTRING(surname, 1,5)
from students

-- operator for pattern matching = LIKE
select *
from students
where surname like '%n'

-- increase all empl income by 5%
create table emplyees
(
    empId int primary key,
    surname varchar(10),
    income decimal (4, 1)
)


insert into emplyees
values
    (1, 'bowen', 250.0),
    (2, 'nick', 350.0)

select *
from emplyees
drop table emplyees


update emplyees 
set income = income + (income * 0.05)

select *
from emplyees
where income between 200 and 300

select SUM(number)
from numbers
select *
from numbers

select case
when is_even='Odd' then SUM(number)
else 4
end
from numbers
group by number, is_even