declare @num int = 5;
select cast(@num as varchar(10))

select cast('ABC' as int) -- b³¹d
select try_cast('ABC' as int) -- null

DECLARE @empid AS INT = 10
SELECT employee_id, first_name, surname
FROM Employees
WHERE  employee_id = @empid;
IF @@ROWCOUNT = 0 -- jesli nic nie znalazlo/zwrocilo
PRINT CONCAT('Employee ', CAST(@empid AS VARCHAR(10)), ' was not found.');
