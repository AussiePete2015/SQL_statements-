SELECT spid, program_name, hostname, datediff(second,login_time, getdate()) as    
   ConnectedSeconds FROM master..sysprocesses WHERE spid > 50

SELECT 
TOP 150
spid, blocked, 
    convert(varchar(10),db_name(dbid)) as DBName, 
    cpu, 
    datediff(second,login_time, getdate()) as Secs,
    convert(float, cpu / datediff(second,login_time, getdate())) as PScore,
    convert(varchar(16), hostname) as Host,
    convert(varchar(50), program_name) as Program,
    convert(varchar(20), loginame) as Login
FROM master..sysprocesses
WHERE datediff(second,login_time, getdate()) > 0 and spid > 50
ORDER BY pscore desc

SELECT spid, program_name, hostname, datediff(second,login_time, getdate()) as    
   ConnectedSeconds FROM master..sysprocesses WHERE spid > 50

select sde_id, owner, nodename + ':' + sysname "nodename:sysname", start_time from sde.sde_process_information;

sp_who
