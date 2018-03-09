CREATE VIEW VW_CM_PARENTCHILD
(
CMID
,PARENT_NAME
,REFCMID
,OBJCMID
,CHILD_NAME
)
AS
SELECT A.*, 
       B.* 
  FROM (SELECT DISTINCT CMREFNOORD11.cmid, 
               CMOBJNAMES_BASE1.name 
          FROM PRODCOGNOS10_CS.cmrefnoord1 CMREFNOORD11 
               INNER JOIN PRODCOGNOS10_CS.cmobjnames_base CMOBJNAMES_BASE1 
                  ON PRODCOGNOS10_CS.CMREFNOORD11.cmid = PRODCOGNOS10_CS.CMOBJNAMES_BASE1.cmid 
         WHERE CMOBJNAMES_BASE1.ISDEFAULT = 1 
           AND CMOBJNAMES_BASE1.LOCALEID IN (96, 98)) A 
       RIGHT OUTER JOIN (SELECT CMREFNOORD12.refcmid, 
                                CMREFNOORD12.cmid, 
                                CMOBJNAMES_BASE2.name 
                           FROM PRODCOGNOS10_CS.cmrefnoord1 CMREFNOORD12 
                                INNER JOIN PRODCOGNOS10_CS.cmobjnames_base CMOBJNAMES_BASE2 
                                   ON PRODCOGNOS10_CS.CMREFNOORD12.cmid = PRODCOGNOS10_CS.CMOBJNAMES_BASE2.cmid 
                          WHERE CMOBJNAMES_BASE2.ISDEFAULT = 1 
                            AND (CMOBJNAMES_BASE2.LOCALEID = 96 + UID * 0 
                                  OR CMOBJNAMES_BASE2.LOCALEID = 98)) B 
          ON A.CMID = B.REFCMID
