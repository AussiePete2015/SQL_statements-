DROP VIEW VM_COGDISPCOUNT;

/* Formatted on 3/12/2014 11:05:19 AM (QP5 v5.269.14213.34769) */
/* Written for Cognos 10.x                                     */
CREATE OR REPLACE FORCE VIEW VM_COGDISPCOUNT
(
DISPATCHER,
COGIPF_TARGET_TYPE, 
DISPATCH_COUNT
)
AS
  SELECT DISTINCT
         
         CASE COGIPF_RUNREPORT.COGIPF_HOST_IPADDR
            WHEN '<IP>' THEN 'Disp1'
            WHEN '<IP>' THEN 'Disp2'
            WHEN '<IP>' THEN 'Disp3'
            ELSE 'OTHER'
         END
            DISPATCHER,
         COGIPF_RUNREPORT.COGIPF_TARGET_TYPE,   
         COUNT(COGIPF_RUNREPORT.COGIPF_HOST_IPADDR) AS DISPATCH_COUNT    
    FROM COGIPF_RUNREPORT
    
    WHERE  
        TRUNC (COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP) BETWEEN TRUNC (
                                                                         SYSDATE
                                                                       - 0)
                                                                AND TRUNC (
                                                                       SYSDATE)
         /*AND COGIPF_RUNREPORT.COGIPF_TARGET_TYPE IN ('Report BatchReportService','ReportView BatchReportService')*/
    GROUP BY COGIPF_RUNREPORT.COGIPF_HOST_IPADDR, COGIPF_RUNREPORT.COGIPF_TARGET_TYPE
    ORDER BY DISPATCHER ASC
