use learning

create table Persons (
    Id int not null,
    FisrtName varchar (30),
    Age int,
)

insert into Persons values 
    (1, 'Daiel', 23), 
    (2, 'Jack', 44), 
    (3, 'Alex', 20)

select * from Persons

drop table Persons
drop database test