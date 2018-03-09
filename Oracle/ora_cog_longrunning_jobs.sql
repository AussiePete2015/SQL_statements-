DROP VIEW VW_LONGRUNJOBS;

CREATE VIEW VW_LONGRUNJOBS
(
JOBSTEPID,
JOBREPORT,
JOBFOLDER,
JOBSTATUS,
JOBTIMESTAMP,
RUNTIME,
SPLITRUNTIME,
HOURSOFDAY,
MINUTESOFDAY,
TIMEOFDAY
)
AS
SELECT 
        "COGIPF_RUNJOBSTEP"."COGIPF_STEPID",
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
         SUBSTR ("COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                    INSTR ("COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                           '''',
                           1,
                           7)
                  + 1,
                  (  INSTR ("COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                            '''',
                            1,
                            8)
                   - INSTR ("COGIPF_RUNJOBSTEP"."COGIPF_JOBSTEPPATH",
                            '''',
                            1,
                            7)
                   - 1))
             JOBFOLDER,
      "COGIPF_RUNJOBSTEP"."COGIPF_STATUS",
      "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP",
      "COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME",
      TO_CHAR (
             TO_DATE (ROUND ("COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" / 1000),
                      'SSSSS'),
             'HH24"h" MI"m" ss"s"')
             RUNTIME,
      EXTRACT (HOUR FROM "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP") HOURSOFDAY,
      EXTRACT (MINUTE FROM "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP") MINUTESOFDAY,
      (TO_CHAR (
                 EXTRACT (
                    HOUR FROM "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP"),
                 '00')
             || ' :'
             || TO_CHAR (
                 EXTRACT (
                    MINUTE FROM "COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP"),
                 '00'))
             TIMEOFDAY
FROM "COGIPF_RUNJOBSTEP"
WHERE 
TO_CHAR ("COGIPF_RUNJOBSTEP"."COGIPF_LOCALTIMESTAMP", 'DD/MM/YYYY') = TO_CHAR (CURRENT_DATE, 'DD/MM/YYYY')
AND 
"COGIPF_RUNJOBSTEP"."COGIPF_RUNTIME" > 2400000
ORDER BY "COGIPF_RUNJOBSTEP".COGIPF_REQUESTID;

COMMIT:
