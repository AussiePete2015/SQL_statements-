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
