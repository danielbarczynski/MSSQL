-- temporary table
use university;
go
create table #tmp
(
    id int primary key,
    nazwisko varchar(30) collate polish_cs_as -- case sensitive
)

insert into #tmp
    (id, nazwisko)
values
    (1, 'Kowalski'),
    (2, 'kowalski'),
    (3, 'KoWaLsKi'),
    (4, 'KOWALSKI')

select *
from #tmp
where nazwisko like 'K%'

select *
from #tmp
where nazwisko like '%K_'