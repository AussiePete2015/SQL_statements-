DROP VIEW VW_COGIPF_RPTEXCOUNT;

/* Formatted on 10/07/2015 8:44:46 AM (QP5 v5.269.14213.34769) */
CREATE OR REPLACE FORCE VIEW VW_COGIPF_RPTEXCOUNT
(
   COGIPF_SESSIONID,
   COGIPF_USERNAME,
   RUNDATE,
   COGIPF_EXECOUNT,
   COGIPF_REPORTNAME,
   REPORTNAME,
   PIMART_ROOT,
   PIMART_SUBFLD1,
   PIMART_SUBFLD2,
   ENDFOLDER,
   COGIPF_LOCALTIMESTAMP,
   REPORTDATE,
   YEAR,
   MONTHNUM,
   MONTHOFYEAR
)
AS
     SELECT COGIPF_USERLOGON.COGIPF_SESSIONID,
            COGIPF_USERLOGON.COGIPF_USERNAME,
            TO_CHAR (COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP, 'DD/MM/YYYY')
               RUNDATE,
            COUNT (DISTINCT COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP)
               COGIPF_EXECOUNT,
            COGIPF_RUNREPORT.COGIPF_REPORTNAME "COGIPF_REPORTNAME",
            RTRIM (SUBSTR (COGIPF_RUNREPORT.COGIPF_REPORTNAME,
                             INSTR (COGIPF_RUNREPORT.COGIPF_REPORTNAME,
                                    '''',
                                    1,
                                    1)
                           + 1),
                   ''']')
               REPORTNAME,
            NVL (SUBSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                           INSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                  '''',
                                  1,
                                  1)
                         + 1,
                         (  INSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                   '''',
                                   1,
                                   2)
                          - INSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                   '''',
                                   1,
                                   1)
                          - 1)),
                 'NULL')
               PIMART_ROOT,
            /*COGIPF_RUNREPORT.COGIPF_REPORTPATH,*/
            (CASE
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE
                        '/transientStateFolder%'
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH = TRIM (' ')
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'MYFolders'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE '%adHocReport%'
                THEN
                   'RUN FROM PARENT PACKAGE'
                ELSE
                   SUBSTR (
                      SUBSTR (
                         COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         2)
                         + 15),
                      1,
                        REGEXP_INSTR (
                           SUBSTR (
                              COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   2)
                              + 15),
                           ''']',
                           1)
                      - 1)
             END)
               PIMART_SUBFLD1,
            (CASE
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE
                        '/transientStateFolder%'
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH = ' '
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'MYFolders'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE '%adHocReport%'
                THEN
                   'RUN FROM PARENT PACKAGE'
                ELSE
                   SUBSTR (
                      SUBSTR (
                         COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         3)
                         + 15),
                      1,
                        REGEXP_INSTR (
                           SUBSTR (
                              COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   3)
                              + 15),
                           ''']',
                           1)
                      - 1)
             END)
               PIMART_SUBFLD2,
            (CASE
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE
                        '/transientStateFolder%'
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH = ' '
                THEN
                   'NULL'
                WHEN COGIPF_RUNREPORT.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'NULL'
                ELSE
                   SUBSTR (
                      SUBSTR (
                         COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                           REGEXP_INSTR (
                              COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                              '/folder',
                              1,
                              REGEXP_COUNT (COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                            '/folder',
                                            1))
                         + 15),
                      1,
                        REGEXP_INSTR (
                           SUBSTR (
                              COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   REGEXP_COUNT (
                                      COGIPF_RUNREPORT.COGIPF_REPORTPATH,
                                      '/folder',
                                      1))
                              + 15),
                           ''']',
                           1)
                      - 1)
             END)
               ENDFOLDER,
            COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP,
            TO_CHAR (COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP, 'DD/MM/YYYY')
               REPORTDATE,
            TO_CHAR (
               EXTRACT (YEAR FROM COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP))
               YEAR,
            EXTRACT (MONTH FROM COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP)
               MONTHNUM,
            CASE EXTRACT (MONTH FROM COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP)
               WHEN 1 THEN 'JAN'
               WHEN 2 THEN 'FEB'
               WHEN 3 THEN 'MAR'
               WHEN 4 THEN 'APR'
               WHEN 5 THEN 'MAY'
               WHEN 6 THEN 'JUN'
               WHEN 7 THEN 'JULY'
               WHEN 8 THEN 'AUG'
               WHEN 9 THEN 'SEPT'
               WHEN 10 THEN 'OCT'
               WHEN 11 THEN 'NOV'
               WHEN 12 THEN 'DEC'
            END
               MONTHOFYEAR
       FROM COGIPF_USERLOGON COGIPF_USERLOGON,
            COGIPF_RUNREPORT COGIPF_RUNREPORT
      WHERE     COGIPF_RUNREPORT.COGIPF_SESSIONID =
                   COGIPF_USERLOGON.COGIPF_SESSIONID || ''
            AND COGIPF_RUNREPORT.COGIPF_SESSIONID =
                   COGIPF_USERLOGON.COGIPF_SESSIONID || ''
            AND COGIPF_RUNREPORT.COGIPF_REPORTNAME IS NOT NULL
   GROUP BY COGIPF_USERLOGON.COGIPF_SESSIONID,
            COGIPF_USERLOGON.COGIPF_USERNAME,
            COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP,
            COGIPF_RUNREPORT.COGIPF_REPORTNAME,
            COGIPF_RUNREPORT.COGIPF_REPORTPATH,
            COGIPF_RUNREPORT.COGIPF_PACKAGE
   ORDER BY COGIPF_RUNREPORT.COGIPF_LOCALTIMESTAMP DESC;
