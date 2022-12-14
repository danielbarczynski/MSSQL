-- Wildcards:
-- A wildcard character is used to substitute one or more characters in a string.
-- Wildcard characters are used with the LIKE operator. 
-- % represents 0 or more characters _ represents single character
-- ^	Represents any character not in the brackets
-- WHERE CustomerName LIKE 'a%'	Finds any values that starts with "a"
-- WHERE CustomerName LIKE '%a'	Finds any values that ends with "a"
-- WHERE CustomerName LIKE '%or%' Finds any values that have "or" in any position
-- WHERE CustomerName LIKE '_r%' Finds any values that have "r" in the second position
-- WHERE CustomerName LIKE 'a__%' Finds any values that starts with "a" and are at least 3 characters in length
-- WHERE ContactName LIKE 'a%o'	Finds any values that starts with "a" and ends with "o"
select *
from Hobbies
where HobbyName like '%a%'