-- simple trigger (its just a stored procedure)
go 
alter trigger tr_persons_insert on persons
after insert as 
print 'new person added'

insert into persons (Id, FirstName, Age) values (9, 'Yasmine', 14) 

go
alter trigger reminder 
on persons
after insert, update   
as raiserror ('notify staff about the changes', 16, 8);  

update persons 
set age = 30
where id = 5

select * from persons

--* show inserted values (without begin end)
go
alter trigger tr_people1_insert on people1
after insert as 
select pname, age from inserted

insert into people1 values ('Tino', 33)
-- with declaration
go
create trigger tr_people2_insert on people2
after insert as 
begin
    select pname, age from inserted
    declare @pname varchar(30);
    set @pname = (select pname from inserted)
    print @pname
end

insert into people2 values ('Tino', 33)

-- more complex trigger
go
create trigger tr_orders_insert on orders
for insert as
if 
(select count(*) from orders
where ordpiority = 'high') = 1 
begin
    print 'there are high piority orders'
end

insert orders
    (ordpiority)
values
    ('high')

select * from orders

