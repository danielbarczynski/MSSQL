-- coalesce basically returns the first non-null value in a list
select coalesce(null, null, null, 'hey', null, 'bye');

-- more advanced example
select coalesce(lecturer_id, 111) as lecturer_id, module_name from modules 
where lecturer_id = 8 or lecturer_id is null