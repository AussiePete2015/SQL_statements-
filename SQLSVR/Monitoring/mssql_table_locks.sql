SELECT LPAD(' ',DECODE(l.xidusn,0,3,0)) || l.oracle_username "User Name",
o.owner, o.object_name, o.object_type
FROM v$locked_object l, dba_objects o
WHERE l.object_id = o.object_id
ORDER BY o.object_id, 1 desc

SELECT username, gv$lock.sid,
TRUNC(id1/power(2,16)) rbs,
BITAND(id1,TO_NUMBER('ffff','xxxx'))+0 slot, id2 seq, lmode, request
FROM gv$lock, gv$session
WHERE gv$lock.type = 'TX'
AND gv$lock.sid = gv$session.sid
AND gv$session.username = '<username>';

SELECT SUBSTR(a.object,1,25) TABLENAME,
SUBSTR(s.username,1,15) USERNAME,
SUBSTR(p.pid,1,5) PID,
SUBSTR(p.spid,1,10) SYSTEM_ID,
DECODE(l.type,
  'RT','Redo Log Buffer',
  'TD','Dictionary',
  'TM','DML',
  'TS','Temp Segments',
  'TX','Transaction',
  'UL','User',
  'RW','Row Wait',
  l.type) LOCK_TYPE
FROM gv$access a, gv$process p, gv$session s, gv$lock l
WHERE s.sid = a.sid
AND s.paddr = p.addr
AND l.sid = p.pid
GROUP BY a.object, s.username, p.pid, l.type, p.spid
ORDER BY a.object, s.username;

SELECT o.owner, o.object_name, o.object_type, o.last_ddl_time, o.status, l.session_id, l.oracle_username, l.locked_mode
FROM dba_objects o, gv$locked_object l
WHERE o.object_id = l.object_id;

SELECT object_id FROM dba_objects WHERE object_name='<TABLENAME>' - 76473

SELECT sid FROM v$lock WHERE id1=103867
76473 (98, 117, 135)

SELECT sid, serial# from v$session where sid in (117, 135)

ALTER SYSTEM KILL SESSION '117 3051'
ALTER SYSTEM KILL SESSION (SID,SERIAL#)

truncate table <TABLENAME>;
commit;
