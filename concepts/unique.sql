-- when adding unique constraint we are automatically creating a non clustered index
create table forunique 
(
	uname varchar(30) unique,
	age int
)

insert into forunique values ('kevin', 20)
insert into forunique values ('kevin', 20) -- it wont add again the same name because of unique uname
