-- subquery (podzapytanie jest kompilowane pierwsze)
update Persons
set HobbyId = null
where FirstName = 'Alex'

select *
from Persons
where HobbyId in (
    select Id
from Hobbies
)