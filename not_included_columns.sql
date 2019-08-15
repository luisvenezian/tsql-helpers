create function fn_index_columns(@ix varchar(300), @included bit = 0)
/* *	
 *	Retorna colunas de index @ix,
 *  
 *  Parâmetros, 
 *  @included = 1, somente colunas is_included = 1 
 *  @included = 0, somente colunas is_included = 0
 *  Luis, 2019/07/25 
 */
returns varchar(max)	
as
begin

	declare @columns varchar(max) = 
	(
	select stuff((select ','+c.name
	from sys.columns as c
		Join sys.indexes i on i.object_id = c.object_id
		Join sys.index_columns as ic on ic.object_id = i.object_id and i.index_id = ic.index_id and ic.column_id = c.column_id
	where i.name = @ix
	and ic.is_included_column = @included order by c.column_id
	for xml path('')), 1, 1, '')
	)

	return @columns
end
-- select dbo.fn_index_columns('indexname',0)
-- select dbo.fn_index_columns('indexname',1)
