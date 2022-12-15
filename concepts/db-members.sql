-- login in master
use master;
go

create login Daniel 
with password = 'Password123!'

-- the rest in the desired database
use learning;
go
create user Daniel for login Daniel 

alter role db_datareader 
add member Daniel 

deny select on Persons
to Daniel 

grant select on people1
to Daniel