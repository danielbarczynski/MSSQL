create table Persons
(
    Id int not null,
    FirstName varchar (30),
    Age int,
    constraint NewConstr unique (Id, FirstName)
)