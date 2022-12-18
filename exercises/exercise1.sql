create database test;
go

select name from sys.databases;
go

use university; -- use desired database
select * from information_schema.tables
go

-- constraint
create table Persons4
(
    Id int not null,
    FirstName varchar (30),
    Age int,
    constraint NewConstr unique (Id, FirstName)
)

-- foreign key with delete and action
create table Persons5
(
    Id int identity primary key,
    FirstName varchar (30),
    Age int,
    HobbyId int,
    foreign key (HobbyId) references Hobbies (Id)
    on delete cascade on update no action
)

insert into Persons
values
    (1, 'Daiel', 23),
    (2, 'Jack', 44),
    (3, 'Alex', 20)

-- procedure
go
create procedure PersonAge
as
select Age
from Persons

PersonAge
drop procedure PersonAge

-- function
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

-- alter table
alter table Persons
add HobbyId int

alter table Persons
drop column Hobby

select *
from Persons

-- new table
create table Hobbies
(
    Id int identity primary key,
    HobbyName varchar (30)
)

-- insert into with identity
insert into Hobbies
values
    ('Piano'),
    ('Reading'),
    ('Gym')

-- insert into column (must be at least Id column) --! bad practice - use update
insert into Persons
    (Id, HobbyId)
values
    (1, 1),
    (2, 2),
    (3, 2)

-- update/add values
update Persons
set HobbyId = 2
where Id > 1 and Id < 4

update Persons
set Age = 25
where FirstName = 'Alex'

-- delete rows
delete from Persons where FirstName is null

-- procedure with order by
go
create procedure sel
as
select *
from Persons
order by Age
go

sel

-- add foreign key
alter table Persons
add foreign key (HobbyId) references Hobbies (Id)

-- subquery (podzapytanie jest kompilowane pierwsze)
update Persons
set HobbyId = null
where FirstName = 'Alex'

select *
from Persons
where HobbyId in (
    select Id
from Hobbies
)

-- aggregate function
select count (Age) as Columns
from Persons

-- scalar function
select upper (FirstName) as Columns
from Persons

-- copy
select *
into PersonsCopy
from Persons

select *
from PersonsCopy

--like
select *
from Hobbies
where HobbyName like '%a%'