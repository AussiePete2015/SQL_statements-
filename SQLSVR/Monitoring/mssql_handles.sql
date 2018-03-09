SELECT DB_NAME(dbid) AS DBName,
       COUNT(dbid)   AS NumberOfConnections,
       loginame      AS LoginName,
       nt_domain     AS NT_Domain,
       nt_username   AS NT_UserName,
	   net_address   AS NET_Address,
	   client_net_address AS IP_Address,
       hostname      AS HostName
FROM   sys.sysprocesses AS S
INNER JOIN    sys.dm_exec_connections AS decc ON S.spid = decc.session_id
WHERE  dbid > 0
GROUP  BY dbid,
          hostname,
		  net_address,
		  client_net_address,
          loginame,
          nt_domain,
          nt_username
ORDER  BY HostName DESC;

****

SELECT s2.dbid, 
    s1.sql_handle,  
    (SELECT TOP 1 SUBSTRING(s2.text,statement_start_offset / 2+1 , 
      ( (CASE WHEN statement_end_offset = -1 
         THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2) 
         ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement,
    execution_count, 
    plan_generation_num, 
    last_execution_time
FROM sys.dm_exec_query_stats AS s1 
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2  
WHERE s2.objectid is null and (SELECT TOP 1 SUBSTRING(s2.text,statement_start_offset / 2+1 , 
      ( (CASE WHEN statement_end_offset = -1 
         THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2) 
         ELSE statement_end_offset END)  - statement_start_offset) / 2+1)) LIKE 'INSERT INTO SPATIAL_DATA%'
ORDER BY s1.last_execution_time DESC;


****
SELECT *
FROM sys.dm_exec_query_stats AS deqs
CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
WHERE dest.dbid = DB_ID('Spatial_Data')
ORDER BY deqs.last_execution_time DESC
