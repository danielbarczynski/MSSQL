-- Introduction

-- A cursor is a database object that points to a result set. We use cursor to fetch any specific row from result set. 
-- Most of time cursor is used by application programmer. We can implement cursor through standard database API or Transact-SQL.

-- DECLARE : It is used to define a new cursor.
-- OPEN : It is used to open a cursor
-- FETCH : It is used to retrieve a row from a cursor.
-- CLOSE : It is used to close a cursor.
-- DEALLOCATE : It is used to delete a cursor and releases all resources used by cursor.

-- easy fetch
select *
from Hobbies
order by Id  
offset 2 rows 
fetch next 2 rows only

USE learning;
GO
-- Declare the variables to store the values returned by FETCH.  
DECLARE @FirstName VARCHAR(50);

DECLARE contact_cursor CURSOR FOR  
SELECT FirstName
FROM Persons
WHERE FirstName LIKE '%a%'
ORDER BY FirstName;

OPEN contact_cursor;

-- Perform the first fetch and store the values in variables.  
-- Note: The variables are in the same order as the columns in the SELECT statement.   

FETCH NEXT FROM contact_cursor  
INTO @FirstName;

-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN
    -- Concatenate and display the current values in the variables.  
    PRINT 'Name: ' + @FirstName 

    -- This is executed as long as the previous fetch succeeds.  
    FETCH NEXT FROM contact_cursor  
   INTO @FirstName;
END

CLOSE contact_cursor;
DEALLOCATE contact_cursor;  
GO

