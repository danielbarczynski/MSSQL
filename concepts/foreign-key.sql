create table Persons
(
    Id int identity primary key,
    FirstName varchar (30),
    Age int,
    HobbyId int,
    foreign key (HobbyId) references Hobbies (Id)
    on delete cascade on update no action
)