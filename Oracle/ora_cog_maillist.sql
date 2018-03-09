DROP VIEW VW_JOBEMAIL_LIST

CREATE VIEW VW_JOBEMAIL_LIST
(
COMPLETION_TIME,
RUNTIME,
JOB_DEFINITION,
REPORT_TYPE,
EMAIL_SENDTYPE,
EMAIL_DISTRIBUTION
)
AS
SELECT VW_JOBREPORTS.RUNJOBSTEP_COMPTIME,
         VW_JOBREPORTS."RUNTIME_HH:MM:SS",
         VW_JOBREPORTS.RUNJOB_JOBDEF,
         VW_JOBREPORTS.RUNJOBSTEP_RPTVIEW,
         COGIPF_PARAMETER.COGIPF_PARAMETER_NAME,
         COGIPF_PARAMETER.COGIPF_PARAMETER_VALUE
    FROM (  SELECT /*+ INDEX("COGIPF_RUNJOBSTEP") */
                  "COGIPF_RUNJOB"."COGIPF_PROC_ID" "RUNJOB_SESSIONID",
                   CASE "COGIPF_RUNJOB"."COGIPF_HOST_IPADDR"
                      WHEN '<IP>' THEN 'Disp1'
                      WHEN '<IP>' THEN 'Disp2'
                   END
                      "RUNJOB_COGDISPIP",
                   CASE "COGIPF_RUNJOBSTEP"."COGIPF_HOST_IPADDR"
                      WHEN '<IP>' THEN 'Disp1'
                      WHEN '<IP>' THEN 'Disp2'
                   END
                      "RUNJOBSTEP_COGDISPIP",
                   "COGIPF_RUNJOBSTEP"."COGIPF_REQUESTID" "RUNJOBSTEP_REQID",
                   "COGIPF_RUNJOB"."COGIPF_LOCALTIMESTAMP" "RUNJOB_STARTPTIME",
                   "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP"
                      "RUNJOBSTEP_COMPTIME",
                   NVL (
                      RTRIM (
                         SUBSTR (
                            "COGIPF_RUNJOB"."COGIPF_JOBPATH",
                              REGEXP_INSTR (
                                 "COGIPF_RUNJOB"."COGIPF_JOBPATH",
                                 '/',
                                 1,
                                 REGEXP_COUNT ("COGIPF_RUNJOB"."COGIPF_JOBPATH",
                                               '/',
                                               1))
                            + 1),
                         ''']'),
                      'NULL')
                      "RUNJOB_JOBDEF",
                   NVL (
                      RTRIM (
                         SUBSTR (
                            "COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                              REGEXP_INSTR (
                                 "COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                                 '/',
                                 1,
                                 REGEXP_COUNT (
                                    "COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                                    '/',
                                    1))
                            + 1),
                         ''']'),
                      'NULL')
                      "RUNJOBSTEP_RPTVIEW",
                   "COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" "RUNJOBSTEP_RUNTIME",
                      TO_CHAR (
                         TRUNC (
                              ROUND ("COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" / 1000)
                            / 3600),
                         'FM9900')
                   || ':'
                   || TO_CHAR (
                         TRUNC (
                              MOD (
                                 ROUND (
                                    "COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" / 1000),
                                 3600)
                            / 60),
                         'FM00')
                   || ':'
                   || TO_CHAR (
                         MOD (
                            ROUND ("COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" / 1000),
                            60),
                         'FM00')
                      "RUNTIME_HH:MM:SS"
              FROM "COGIPF_RUNJOB" "COGIPF_RUNJOB",
                   "COGIPF_RUNJOBSTEP" "COGIPF_RUNJOBSTEP"
             WHERE "COGIPF_RUNJOB"."COGIPF_STEPID" =
                      "COGIPF_RUNJOBSTEP"."COGIPF_SUBREQUESTID"
          ORDER BY "COGIPF_RUNJOB"."COGIPF_LOCALTIMESTAMP" DESC) VW_JOBREPORTS,
         COGIPF_PARAMETER
   WHERE     VW_JOBREPORTS.RUNJOBSTEP_REQID = COGIPF_PARAMETER.COGIPF_REQUESTID
         AND TRUNC (VW_JOBREPORTS.RUNJOB_STARTPTIME) BETWEEN TRUNC (
                                                                SYSDATE - 7)
                                                         AND TRUNC (SYSDATE)
         AND COGIPF_PARAMETER.COGIPF_PARAMETER_NAME LIKE '%Address'
ORDER BY VW_JOBREPORTS.RUNJOB_STARTPTIME DESC

