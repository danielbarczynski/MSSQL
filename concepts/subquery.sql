-- subquery (podzapytanie jest kompilowane pierwsze)
select * from Persons
where HobbyId in 
(
    select Id from Hobbies
)

--* INDEPEDENT subquery with logic
select * from people1
where age > (
    select avg(age) from people2 -- = 22
)

--* CORRELATED subquery cannot be run idependently without the main query
-- this wont work without exists 
-- "Only one expression can be specified in the select list when the subquery is not introduced with EXISTS."
select * from Persons p
where Id in 
(
    select * from Hobbies
    where Id = p.HobbyId
)

-- this works
select * from Persons p
where exists
(
    select * from Hobbies
    where Id = p.HobbyId
)