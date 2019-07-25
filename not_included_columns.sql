create function not_included_columns (@ix varchar(300))
/* *	
 *	Retorna colunas de index @ix que exceto included_columns. 
 *	Para retornar todas, excluir cláusula where de is_included_column
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
	and ic.is_included_column <> 1 order by c.column_id
	for xml path('')), 1, 1, '')
	)

	return @columns
end
-- select dbo.not_included_columns('indexname')
