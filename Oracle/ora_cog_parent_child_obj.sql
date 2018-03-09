DROP VIEW VW_CM_PARENTCHILD;

/* Formatted on 18/Feb/16 9:46:26 AM (QP5 v5.287) */
CREATE OR REPLACE FORCE VIEW VW_CM_PARENTCHILD
(
   CMID,
   PARENT_NAME,
   OBJCMID,
   CLASSID,
   CREATED,
   MODIFIED,
   PCMID,
   REFCMID,
   CHILD_NAME
)
AS
   SELECT A."CMID",
          A."PARENT_NAME",
          A."CMOBJCMID",
          A."CLASSID",
          A."CREATED",
          A."MODIFIED",
          B."REFCMID",
          B."CCMID",
          B."CHILDNAME"
     FROM (  SELECT /*+ INDEX(CMREFNOORD11) */
                    DISTINCT CMREFNOORD11.cmid,
                             CMOBJNAMES_BASE1.name parent_name,
                             cmobjects.cmid cmobjcmid,
                             CMOBJECTS.CLASSID,
                             CMOBJECTS.CREATED,
                             CMOBJECTS.MODIFIED
               FROM PRODCOGNOS10_CS.cmrefnoord1 CMREFNOORD11
                    INNER JOIN PRODCOGNOS10_CS.cmobjnames_base CMOBJNAMES_BASE1
                       ON PRODCOGNOS10_CS.CMREFNOORD11.cmid =
                             PRODCOGNOS10_CS.CMOBJNAMES_BASE1.cmid
                    INNER JOIN PRODCOGNOS10_CS.cmobjects
                       ON PRODCOGNOS10_CS.cmobjects.cmid =
                             PRODCOGNOS10_CS.CMOBJNAMES_BASE1.cmid
              WHERE     CMOBJNAMES_BASE1.ISDEFAULT = 1
                    AND CMOBJNAMES_BASE1.LOCALEID IN (96, 98)
           ORDER BY CMREFNOORD11.CMID) A
          RIGHT OUTER JOIN
          (SELECT CMREFNOORD12.refcmid,
                  CMREFNOORD12.cmid ccmid,
                  CMOBJNAMES_BASE2.name childname
             FROM PRODCOGNOS10_CS.cmrefnoord1 CMREFNOORD12
                  INNER JOIN PRODCOGNOS10_CS.cmobjnames_base CMOBJNAMES_BASE2
                     ON PRODCOGNOS10_CS.CMREFNOORD12.cmid =
                           PRODCOGNOS10_CS.CMOBJNAMES_BASE2.cmid
            WHERE     CMOBJNAMES_BASE2.ISDEFAULT = 1
                  AND CMOBJNAMES_BASE2.LOCALEID IN (96, 98)) B
             ON A.CMID = B.REFCMID;
