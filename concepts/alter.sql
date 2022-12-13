alter table Persons2
add HobbyId int

alter table Persons2
drop column Hobby

go
alter view SimpleView
as
    select *
    from Persons2
    where Age < 40