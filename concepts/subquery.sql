-- subquery (podzapytanie jest kompilowane pierwsze)
select *
from Persons
where HobbyId in (
    select Id
from Hobbies
)

-- INDEPEDENT subquery with logic
select * from people1
where age > (
    select avg(age) from people2 -- = 22
)

-- CORRELATED subquery cannot be run idependently without the main query
