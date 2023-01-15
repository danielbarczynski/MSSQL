-- Transactions group a set of tasks into a single execution unit. 
-- Each transaction begins with a specific task and ends when all the tasks in the group successfully complete.
-- If any of the tasks fail, the transaction fails. Therefore, a transaction has only two results: success or failure. 

-- the simples transaction
update people2
set Age = 23
where pname = 'Kate'
-- explicit and multiple transactions
begin transaction 
update people2
set Age = 23
where pname = 'Kate'
update people2 
set Age = 40
where pname = 'Joshs'
commit 

select * from people2

-- rollback
--* transaction cannot be rolled back after a commit statement is executed
begin transaction tran_people1
update people1
set pname = 'wojtek3'
where pname = 'wojtek'
if @@rowcount = 2
       commit transaction tran_people1
else 
       rollback transaction tran_people1

-- rollback without commit
begin transaction dropping_persons6
drop table [Persons6]
--* until commit or rollback database is processing the query all the time
rollback transaction dropping_persons6

-- with tempdb
use tempdb;  
go  
create table valuetable ([value] int); -- without [] it will be a keyword
go  
  
declare @transactionname varchar(20) = 'transaction1';  
  
begin transaction @transactionname  
       insert into valuetable values (1),(2);  
rollback transaction @transactionname;  
  
insert into valuetable values (3),(4);  
  
select [value] from valuetable;  
  
drop table valuetable;

-- save transaction
begin transaction tran_people2_delete
save transaction before_deletion
delete people2 
where Age > 32
commit transaction tran_people2_delete

-- rollbacking to savepoint
--* you can rollback to savepoint after making commit
rollback transaction before_deletion

select * from people2
