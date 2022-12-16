-- The CREATE INDEX statement is used to create indexes in tables.
-- Indexes are used to retrieve data from the database more quickly than otherwise. 
-- The users cannot see the indexes, they are just used to speed up searches/queries.
--* Note: Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). 
--* So, only create indexes on columns that will be frequently searched against.

-- non custered
-- doesn't affect order of data like clustered, it is stored separately so we can have multiple non clustered index keys
-- when the system is searching by them, first its looking by index table and then looking in the main table by references in the index table 
exec sel 
create index ix_persons_age on persons (age asc)
drop index persons.ix_persons_age

-- exec time with index 00:00:00.004 on 9 records
-- without 00:00:00.004
select * from persons where age > 40 and age < 50

sp_helpIndex persons

-- clustered (slightly faster than non clustered)
-- determines order of data (so we can have only one)
-- doesnt require additional storage as non clustered index keys
-- if creating table with primary key, we automatically are creating clustered unique index
create table uni ( id int primary key, sname varchar(20))
sp_helpIndex uni

-- can't drop index
alter table uni
drop constraint PK__uni__3213E83F27B224B1

insert into uni values (5, 'five'), (3, 'three'), (1, 'one')
select * from uni

-- now its ordered by id
create clustered index ix_uni_Id on uni (id asc)

-- composite clustered index (index which refers to multiple columns)
create clustered index ix_uni_Id on uni (id asc, sname desc)
