-- subquery (podzapytanie jest kompilowane pierwsze)
select *
from Persons
where HobbyId in (
    select Id
from Hobbies
)