DROP VIEW C1011ADT.VW_COPG_OBJRUC;
Create View C1011ADT.VW_COPG_OBJRUC
(
CMID,
PCMID,
CLASSID,
TREE
)
AS
SELECT 
    C1011CS.CMOBJECTS.cmid, 
    C1011CS.CMOBJECTS.pcmid,
    C1011CS.CMOBJECTS.CLASSID,
    LPAD(' ', 3*level-1)||sys_connect_by_path(pcmid,' -> ') tree
FROM 
    C1011CS.CMOBJECTS 
connect by prior NULLIF(C1011CS.CMOBJECTS.cmid,C1011CS.CMOBJECTS.pcmid) = C1011CS.CMOBJECTS.pcmid
   
COMMIT;
