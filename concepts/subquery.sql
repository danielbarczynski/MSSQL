-- subquery (podzapytanie jest kompilowane pierwsze)
update Persons2
set HobbyId = null
where FirstName = 'Alex'

select *
from Persons2
where HobbyId in (
    select Id
from Hobbies
)