# Statement to show SQL statements run on a database
select
  hostname,
  spid,
  blocked,
  cpu,
  physical_io
  memusage,
  program_name,
  loginame,
  cmd,
  text
from sys.sysprocesses
cross apply sys.dm_exec_sql_text (sql_handle)
where 
  text != 'NULL'
AND
  hostname = '<database>'
