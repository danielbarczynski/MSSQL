-- constraint
create table Persons2
(
    Id int not null,
    FirstName varchar (30),
    Age int,
    constraint NewConstr unique (Id, FirstName)
)

insert into Persons2
values
    (1, 'Daiel', 23),
    (2, 'Jack', 44),
    (3, 'Alex', 20)

-- procedure
go
create procedure PersonAge
as
select Age
from Persons2

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
alter table Persons2
add HobbyId int

alter table Persons2
drop column Hobby

select *
from Persons2

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
insert into Persons2
    (Id, HobbyId)
values
    (1, 1),
    (2, 2),
    (3, 2)

-- update/add values
update Persons2
set HobbyId = 2
where Id > 1 and Id < 4

update Persons2
set Age = 25
where FirstName = 'Alex'

-- delete rows
delete from Persons2 where FirstName is null

go
create procedure sel
as select * from Persons2 

sel

-- add foreign key
alter table Persons2
add foreign key (HobbyId) references Hobbies (Id)

-- subquery (podzapytanie jest kompilowane pierwsze)
update Persons2
set HobbyId = null
where FirstName = 'Alex'

select * from Persons2
where HobbyId in (
    select Id from Hobbies
)

