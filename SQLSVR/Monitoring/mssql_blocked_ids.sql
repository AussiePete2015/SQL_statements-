SELECT *
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
WHERE st.objectid IS NOT NULL

order by last_execution_time desc;
GO

Select * 
FROM sys.dm_exec_query_stats
order by last_execution_time desc

USE [Spatial_Data]
DECLARE	@return_value int
EXEC	@return_value = [dbo].[SP_NaturalPerilEventEmailer]

SELECT session_id, blocking_session_id, text 
FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE session_id > 50
