go
create procedure sel
as
select *
from Persons
order by Age
go

sel

-- insert into procedure
go
create procedure AddHobby
    @HobbyName varchar (30)
as
insert into Hobbies
values
    (@HobbyName)

execute AddHobby 'Cars'
execute AddHobby 'Swimming'