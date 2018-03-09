drop view VW_CM_PARENTCHILD_REL;

CREATE VIEW VW_CM_PARENTCHILD_REL
(
pcmid
,PCMID_Parent
,pclassid
,CMID
,CMID_child
,cclassid
)
AS
Select
        q2.pcmid,
        q1.Parent,
        q1.classid,
        q1.cmid CMID,
        q2.child,
        q2.classid
FROM
    (SELECT
            A.name Parent,
            B.CMID,
            B.classid
      FROM  PRODCOGNOS10_CS.CMOBJECTS b
      JOIN  PRODCOGNOS10_CS.CMOBJNAMES_BASE a
      ON    b.PCMID = A.CMID 
      WHERE
            A.ISDEFAULT = 1 AND
            B.CLASSID = 10
    ) q1
     LEFT JOIN
     (SELECT 
            cmobjects.pcmid,
            cmobjects.cmid,
            cmobjects.classid,
            cmobjnames_base.name child
      FROM  PRODCOGNOS10_CS.cmobjects, PRODCOGNOS10_CS.cmobjnames_base
      WHERE   
            cmobjnames_base.isdefault = 1        
      AND   cmobjects.cmid = cmobjnames_base.cmid
      
      ) q2
ON q1.cmid =  q2.cmid
