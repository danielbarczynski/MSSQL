-- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
--* with primary key we don't have to specify not null property
-- FOREIGN KEY - Prevents actions that would destroy links between tables foreign key
-- so it has resticr as default behavior

create table Persons
(
    Id int identity primary key,
    FirstName varchar (30),
    Age int,
    HobbyId int,
    foreign key (HobbyId) references Hobbies (Id)
    on delete cascade on update no action
)

create table customers 
(
    id int,
    cname varchar (30)
)

--* cannot create foreign key where there is no primary or candidate key on referenced table
-- i've altered the table and it works

create table employees
(
    id int,
    ename varchar(30),
    customer_id int foreign key references customers (id)
)
-- Candidate Key ((secondary key) is a column or combination of columns, which can be a Primary key for the Table.
-- There may be multiple Candidate Keys In a Table. Any Candidate Key can be a Primary Key.

-- Unique Key is a column which has unique value for each row, but it also allow nulls (Primary Key doesn't).

-- Alternate key - other candidate keys that you didn't choose as primary key
-- PESEL is candidate key but if u combine PESEL column with first_name column you will get a super key
create table ppp 
(
    id int primary key,
    pesel char (11) unique not null, -- this declaration is candidate key
    id_card char (6) unique, -- unique key, can be null
)

-- Super key - any candidate key can become super key if you add attribute to it for example:
create table pppp 
(
    pesel int,
    id_card char (6),
    constraint super_key primary key (pesel, id_card)
)

-- composite key - if table doesn't have a column hat qualifies for a candidate key, you have to combine 
-- other columns to make unique column and that is composite key
create table ppppp
(
    pname varchar (30),
    surname varchar (50),
    age int,
    constraint composite_key primary key (pname, surname, age)
)

insert into ppppp values ('norman', 'obrien', 55)
select * from ppppp