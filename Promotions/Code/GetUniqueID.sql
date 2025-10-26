-- Query to generate new single-field key value, from undeclared parameter @InputTableName 
-- Checks for views referencing a single table and generates from there to ensure the application
-- is insulated from the underlying table.

SET NOCOUNT ON

declare @TableName varchar(100)
declare @ViewDefinition varchar(8000)
declare @CurPos int
declare @InBrackets bit
declare @PKFieldName varchar(100)
declare @PKFieldType varchar(100)

set @TableName = '@InputTableName'

select @ViewDefinition = VIEW_DEFINITION from information_schema.views where table_name = @TableName
-- get from clause argument followed by rest of query
set @ViewDefinition = Substring(@ViewDefinition, charindex(' from ', @ViewDefinition)+6, len(@ViewDefinition))
set @ViewDefinition = LTrim(@ViewDefinition)

-- convert newlines to spaces
set @ViewDefinition = Replace(@ViewDefinition, char(13), ' ')

set @CurPos = 1
set @InBrackets = 0

while (@CurPos < len(@ViewDefinition))
begin
  if SubString(@ViewDefinition, @CurPos, 1) = ' ' and @InBrackets = 0
    set @ViewDefinition = SubString(@ViewDefinition, 1, @CurPos-1)
  else
  if SubString(@ViewDefinition, @CurPos, 1) = '[' and @InBrackets = 0
    set @InBrackets = 1
  else
  if SubString(@ViewDefinition, @CurPos, 1) = ']' and @InBrackets = 1
    set @InBrackets = 0
  set @CurPos = @CurPos + 1
end

--print 'Fully qualified identifier '+@ViewDefinition

while CharIndex('.', @ViewDefinition) <> 0 
begin
  set @ViewDefinition = SubString(@ViewDefinition, CharIndex('.', @ViewDefinition)+1, Len(@ViewDefinition))
end

--print 'Table identifier '+@ViewDefinition

if SubString(@ViewDefinition, 1, 1) = '['
  set @ViewDefinition = SubString(@ViewDefinition, 2, Len(@ViewDefinition)-2)


select @TableName = TABLE_NAME 
from information_schema.tables
where TABLE_SCHEMA = 'dbo' and TABLE_NAME = @Viewdefinition

print 'Table name "'+@TableName+'"'

-- get single field primary key, its field name and field datatype (tinyint, smallint, int, bigint)
select @PKFieldName = COLUMN_NAME
from information_schema.constraint_column_usage
where TABLE_NAME = @TableName and CONSTRAINT_NAME like 'PK%'

select @PKFieldType = DATA_TYPE
from information_Schema.columns
where TABLE_SCHEMA = 'dbo' and TABLE_NAME = @TableName and COLUMN_NAME = @PKFieldName

print @PKFieldNAme + ' '+ @PKFieldType

declare @Output bigint 
declare @MaxRange bigint

if @PKFieldType = 'tinyint' 
  set @MaxRange = 255
else
if @PKFieldType = 'smallint'
  set @MaxRange = 65535
else
if @PKFieldType = 'int'
  set @MaxRange = 2147483647
else
  set @MaxRange = 9223372036854775807

exec GetNextUniqueID  @TableName, @PKFieldName, 1, @MaxRange, @NextID = @output OUTPUT

select @Output as Output

SET NOCOUNT OFF