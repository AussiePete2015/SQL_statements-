SELECT
(physical_memory_in_use_kb/1024) AS Memory_usedby_Sqlserver_MB,
(locked_page_allocations_kb/1024) AS Locked_pages_used_Sqlserver_MB,
(total_virtual_address_space_kb/1024) AS Total_VAS_in_MB,
process_physical_memory_low,
process_virtual_memory_low
FROM sys.dm_os_process_memory;

with fs
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
from sys.databases db

SELECT DB_NAME(database_id) AS DatabaseName,
Name AS Logical_Name,
Physical_Name, (size*8)/1024 SizeMB
FROM sys.master_files

SELECT
SCHEMA_NAME(sysTab.SCHEMA_ID) as SchemaName,
sysTab.NAME AS TableName,
parti.rows AS RowCounts,
SUM(alloUni.total_pages) * 8 AS TotalSpaceKB,
SUM(alloUni.used_pages) * 8 AS UsedSpaceKB,
(SUM(alloUni.total_pages) - SUM(alloUni.used_pages)) * 8 AS UnusedSpaceKB
FROM
sys.tables sysTab

INNER JOIN
sys.indexes ind ON sysTab.OBJECT_ID = ind.OBJECT_ID and ind.Index_ID<=1
INNER JOIN
sys.partitions parti ON ind.OBJECT_ID = parti.OBJECT_ID AND ind.index_id = parti.index_id
INNER JOIN
sys.allocation_units alloUni ON parti.partition_id = alloUni.container_id
WHERE
sysTab.is_ms_shipped = 0
AND ind.OBJECT_ID > 255
AND parti.rows>0
GROUP BY
sysTab.Name, parti.Rows,sysTab.SCHEMA_ID
Order BY parti.rows desc

--SCRIPT NO 2

--Get total size of each schema available in your SQL Server database

SELECT
SCHEMA_NAME(sysTab.SCHEMA_ID) as SchemaName,
SUM(alloUni.total_pages) * 8 AS TotalSpaceKB,
SUM(alloUni.used_pages) * 8 AS UsedSpaceKB,
(SUM(alloUni.total_pages) - SUM(alloUni.used_pages)) * 8 AS UnusedSpaceKB
FROM
sys.tables sysTab
INNER JOIN
sys.indexes ind ON sysTab.OBJECT_ID = ind.OBJECT_ID  and ind.Index_ID<=1
INNER JOIN
sys.partitions parti ON ind.OBJECT_ID = parti.OBJECT_ID AND ind.index_id = parti.index_id
INNER JOIN
sys.allocation_units alloUni ON parti.partition_id = alloUni.container_id
WHERE
sysTab.is_ms_shipped = 0
AND ind.OBJECT_ID > 255
AND parti.rows>0
GROUP BY
sysTab.SCHEMA_ID
ORDER BY
TotalSpaceKB DESC
