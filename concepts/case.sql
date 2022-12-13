create table numbers
(
    Num int not null,
)

insert into numbers
values
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8)

select *
from numbers

select case
when Num % 2 = 0 then 'Even'
when Num % 5 = 0 then 'Super'
else 'Odd'
end as Num
from numbers
