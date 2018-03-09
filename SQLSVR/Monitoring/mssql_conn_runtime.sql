SELECT * FROM master.dbo.sysprocesses

SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName,
    nt_username,
    hostname,
    hostprocess,
    program_name,
	datediff(second,login_time, getdate()) as Secs,
    convert(float, cpu / datediff(second,login_time, getdate())) as PScore
FROM
    master..sysprocesses
WHERE datediff(second,login_time, getdate()) > 0 and spid > 50 AND DB_NAME(dbid) = 'BI_SANDPIT'
GROUP BY 
    dbid, loginame, nt_username, hostname, hostprocess, program_name, datediff(second,login_time, getdate()),
    convert(float, cpu / datediff(second,login_time, getdate()))
;


DECLARE @SQL varchar(max)
SET @SQL = ''

SELECT 
@SQL = @SQL + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DB_Name(dbid) = 'BI_SANDPIT' and hostname = 'D9913970' and SPID <> @@SPID

Select @SQL

EXEC (@SQL)
