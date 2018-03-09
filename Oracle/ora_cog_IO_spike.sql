/* Formatted on 26/03/2015 8:35:34 AM (QP5 v5.269.14213.34769) */
define pdate = to_char(:pdate)
SELECT *
  FROM (  SELECT cogipf_runreport.COGIPF_LOCALTIMESTAMP AS RR_DATETIME,
                 cogipf_runreport.COGIPF_REPORTNAME AS RR_REPORTNAME,
                 TO_CHAR (
                    TO_DATE (ROUND (cogipf_runreport.COGIPF_RUNTIME / 1000),
                             'SSSSS'),
                    'HH24"h" MI"m" ss"s"')
                    RR_SPLRUNTIME
            FROM cogipf_runreport
           WHERE    cogipf_runreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                      &pdate || ' 09:00:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                                                               AND TO_DATE (
                                                                      &pdate || ' 09:10:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                      &pdate || ' 09:40:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                                                               AND TO_DATE (
                                                                      &pdate || ' 9:50:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                      &pdate || ' 12:30:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                                                               AND TO_DATE (
                                                                      &pdate || ' 12:40:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                      &pdate || ' 14:00:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
                                                               AND TO_DATE (
                                                                      &pdate || ' 14:10:00',
                                                                      'DD-MM-YYYY HH24:MI:SS')
        ORDER BY cogipf_runreport.COGIPF_LOCALTIMESTAMP DESC) SQL1
       FULL OUTER JOIN
       (  SELECT cogipf_viewreport.COGIPF_LOCALTIMESTAMP AS VR_DATETIME,
                 NVL (
                    RTRIM (
                       SUBSTR (
                          cogipf_viewreport.COGIPF_REPORTPATH,
                            REGEXP_INSTR (
                               cogipf_viewreport.COGIPF_REPORTPATH,
                               '/report',
                               1,
                               REGEXP_COUNT (
                                  cogipf_viewreport.COGIPF_REPORTPATH,
                                  '/report',
                                  1)-1)
                          + 1),
                       ''']'),
                    'NULL') VR_REPORTNAME
            FROM cogipf_viewreport
           WHERE        
                   (cogipf_viewreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                           &pdate || ' 09:00:00',
                                                                           'DD-MM-YYYY HH24:MI:SS')
                                                                    AND TO_DATE (
                                                                           &pdate || ' 09:10:00',
                                                                           'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_viewreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 09:40:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 09:50:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_viewreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 12:30:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 12:40:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_viewreport.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 14:00:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 14:10:00',
                                                                       'DD-MM-YYYY HH24:MI:SS'))
                 AND 
                 (cogipf_viewreport.COGIPF_TARGET_TYPE IN ('REPORTVIEW', 'REPORT'))                                                      
        ORDER BY cogipf_viewreport.COGIPF_LOCALTIMESTAMP DESC) SQL2
          ON SQL1.RR_DATETIME = SQL2.VR_DATETIME
       FULL OUTER JOIN
       (  SELECT cogipf_runjobstep.COGIPF_LOCALTIMESTAMP AS JS_DATETIME,
                 NVL (
                    RTRIM (
                       SUBSTR (
                          cogipf_runjobstep.COGIPF_JOBSTEPPATH,
                            REGEXP_INSTR (
                               cogipf_runjobstep.COGIPF_JOBSTEPPATH,
                               '/',
                               1,
                               REGEXP_COUNT (
                                  cogipf_runjobstep.COGIPF_JOBSTEPPATH,
                                  '/',
                                  1))
                          + 1),
                       ''']'),
                    'NULL')
                    JS_REPORTNAME,
                 TO_CHAR (
                    TO_DATE (ROUND (cogipf_runjobstep.COGIPF_RUNTIME / 1000),
                             'SSSSS'),
                    'HH24"h" MI"m" ss"s"')
                    JS_SPLRUNTIME
            FROM cogipf_runjobstep
           WHERE    cogipf_runjobstep.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 09:00:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 09:10:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runjobstep.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 09:40:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 09:50:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runjobstep.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 12:30:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 12:40:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                 OR cogipf_runjobstep.COGIPF_LOCALTIMESTAMP BETWEEN TO_DATE (
                                                                       &pdate || ' 14:00:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                AND TO_DATE (
                                                                       &pdate || ' 14:10:00',
                                                                       'DD-MM-YYYY HH24:MI:SS')
                                                                       AND 
                 (cogipf_runjobstep.COGIPF_TARGET_TYPE IN ('REPORTVIEW', 'REPORT'))   
        ORDER BY cogipf_runjobstep.COGIPF_LOCALTIMESTAMP DESC) SQL3
          ON SQL3.JS_DATETIME IN (SQL1.RR_DATETIME,
                                            SQL2.VR_DATETIME)
