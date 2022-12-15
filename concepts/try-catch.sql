-- divide-by-zero error.  
begin try  
    select 1/0;  
end try  
begin catch  
    print 'error';  
end catch;  

-- real life example 
-- it mostly catches error when action completes but not affects
begin try 
    delete from people1
    where pname > 10
end try
begin catch 
    print 'no person found'
end catch 

select * from people1