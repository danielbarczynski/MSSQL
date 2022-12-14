--CROSS JOIN (ka¿dy rekord z ka¿dym)
select *
from modules 
cross join students

-- INNER JOIN (czêœæ wspólna) INNER JOIN = JOIN
--58 records (the order in query doesn't matter)
select *
from students s
    inner join student_grades sm on s.student_id=sm.student_id

select *
from student_grades
select *
from students

-- LEFT JOIN (podpiêcie do lewej tablicy (students)  prawej (st_grades) 
--(72 rekordy 14 nulli w st_grades, bo uwzglednia takze studentow, ktorych nie ma w st_grades)
select *
from students s
    left join student_grades sm on s.student_id=sm.student_id
-- where module_id is not null -- with this 58 records again

-- RIGHT JOIN (podpiêcie do prawej (st_grades) lewej (students) 
-- 58 records - all from just student_grades 
select *
from students s
    right join student_grades sm on s.student_id=sm.student_id

-- FULL JOIN = RIGHT + LEFT + INNER
-- 72 records
select *
from students s
    full join student_grades sm on s.student_id=sm.student_id
