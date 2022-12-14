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
