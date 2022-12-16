-- SQL constraints are used to specify rules for the data in a table.
-- Constraints are used to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the table. 
-- If there is any violation between the constraint and the data action, the action is aborted.
-- Constraints can be column level or table level. Column level constraints apply to a column, and table level constraints apply to the whole table.
-- The following constraints are commonly used in SQL:

-- NOT NULL - Ensures that a column cannot have a NULL value
-- UNIQUE - Ensures that all values in a column are different
-- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
-- FOREIGN KEY - Prevents actions that would destroy links between tables
-- CHECK - Ensures that the values in a column satisfies a specific condition
-- DEFAULT - Sets a default value for a column if no value is specified
-- CREATE INDEX - Used to create and retrieve data from the database very quickly

create table Persons6
(
    Id int identity primary key not null,
    FirstName varchar (30) default 'Person',
    Age int check (Age > 18),
    HobbyId int foreign key references Hobbies (Id)
    on delete set null on update no action, -- no restrict keyword in mssql
    constraint NewConstr6 unique (Id, FirstName)
)

alter table Persons6
drop constraint NewConstr6

insert into Persons6 (Age, HobbyId) values (19, 2) -- if age < 18 wont work
select * from Persons6
