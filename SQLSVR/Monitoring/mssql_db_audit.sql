select *
from sys.configurations

SELECT DB_NAME(database_id) AS DatabaseName,
Name AS Logical_Name,
Physical_Name, (size*8)/1024 SizeMB
FROM sys.master_files

SELECT DB_NAME(st.dbid) AS database_name, 
    OBJECT_SCHEMA_NAME(st.objectid, st.dbid) AS schema_name,
    OBJECT_NAME(st.objectid, st.dbid) AS object_name, 
    st.text AS query_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
WHERE st.objectid IS NOT NULL
AND
	DB_NAME(st.dbid) = '<dbname>';
GO

SELECT
       sp.name,
       sp.principal_id as login_principal_id,
       sp.type_desc,
       sp2.name AS dbrole_name,
       sp2.principal_id as role_principal_id
FROM sys.server_principals AS sp
       LEFT JOIN sys.server_role_members AS sr
             ON sp.principal_id = sr.member_principal_id
       LEFT JOIN sys.server_principals AS sp2
             ON sp2.principal_id = sr.role_principal_id
WHERE
	sp.name = '<user_acc>'

SELECT T.TABLE_TYPE AS OBJECT_TYPE, T.TABLE_SCHEMA AS [SCHEMA_NAME], T.TABLE_NAME AS [OBJECT_NAME], P.PERMISSION_NAME FROM INFORMATION_SCHEMA.TABLES T
CROSS APPLY fn_my_permissions(T.TABLE_SCHEMA + '.' + T.TABLE_NAME, 'OBJECT') P
WHERE P.subentity_name = ''
UNION
SELECT R.ROUTINE_TYPE AS OBJECT_TYPE, R.ROUTINE_SCHEMA AS [SCHEMA_NAME], R.ROUTINE_NAME AS [OBJECT_NAME], P.PERMISSION_NAME
FROM INFORMATION_SCHEMA.ROUTINES R
CROSS APPLY fn_my_permissions(R.ROUTINE_SCHEMA + '.' + R.ROUTINE_NAME, 'OBJECT') P
ORDER BY OBJECT_TYPE, [SCHEMA_NAME], [OBJECT_NAME], P.PERMISSION_NAME

SELECT
 [Current LSN],
 [Transaction ID],
 [Operation],
  [Transaction Name],
 [CONTEXT],
 [AllocUnitName],
 [Page ID],
 [Slot ID],
 [Begin Time],
 [End Time],
 [Number of Locks],
 [Lock Information]
FROM sys.fn_dblog(NULL,NULL)
WHERE Operation IN 
   ('LOP_INSERT_ROWS','LOP_MODIFY_ROW',
    'LOP_DELETE_ROWS','LOP_BEGIN_XACT','LOP_COMMIT_XACT')  


EXEC sp_configure 'Show Advanced Options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure;
