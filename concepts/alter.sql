alter table Persons
add HobbyId int

alter table Persons
drop column Hobby

go
alter view SimpleView
as
    select *
    from Persons
    where Age < 40