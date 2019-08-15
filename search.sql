-- to search 
-- procedures
create procedure spc
@pcname varchar(100)
as
select s.name +'.'+t.name as tb from 
sys.procedures t, sys.schemas  s
where t.name like '%'+@pcname+'%'
and 
t.schema_id = s.schema_id

-- views
create procedure svw
@viewName varchar(100)
as
select s.name +'.'+t.name as tb from 
sys.views t, sys.schemas  s
where t.name like '%'+@viewName+'%'
and 
t.schema_id = s.schema_id


-- tables
create procedure stb
@tbname varchar(100)
as
select s.name +'.'+t.name as tb from 
sys.tables t, sys.schemas  s
where t.name like '%'+@tbname+'%'
and 
t.schema_id = s.schema_id