-- The ANY operator:
-- returns a boolean value as a result
-- returns TRUE if ANY of the subquery values meet the condition
-- ANY means that the condition will be true if the operation is true for any of the values in the range.
-- 21 r
select * from people1
select * from people2

select * from people1
where age > any 
(
select age from people2
)

-- The ALL operator:
-- returns a boolean value as a result
-- returns TRUE if ALL of the subquery values meet the condition
-- is used with SELECT, WHERE and HAVING statements
select * from people1
where age > all 
(
select age from people2
)

-- The EXISTS operator is used to test for the existence of any record in a subquery.
-- The EXISTS operator returns TRUE if the subquery returns one or more records.
-- empty or full table; true or false
select * from people1
where exists
(
    select * from people2
    where age > 30
)

select * from Persons p
where exists 
(
    select * from Hobbies
    where Id = p.HobbyId
)

-- not exists
select * from Persons p
where not exists 
(
    select * from Hobbies
    where Id = p.HobbyId
)