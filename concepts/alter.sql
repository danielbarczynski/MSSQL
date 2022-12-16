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

go
create table customers 
(
    id int,
    cname varchar (30)
)

alter table customers 
alter column id varchar (40)


