DROP VIEW VW_COGIPF_AS_USAGE;

/* Formatted on 13/07/2015 9:26:30 AM (QP5 v5.269.14213.34769) */
CREATE VIEW VW_COGIPF_AS_USAGE
(
   COGIPF_SESSIONID,
   COGIPF_USERNAME,
   COGIPF_EXECOUNT,
   DEPT_ASPACKAGE,
   PIMART_ROOT,
   PIMART_SUBFLD1,
   PIMART_SUBFLD2,
   COGIPF_TARGET_TYPE,
   COGIPF_QUERYNAME,
   QUERYNAME,
   COGPACKAGE_NAME,
   COGIPF_LOCALTIMESTAMP,
   REPORTDATE,
   YEAR,
   MONTHNUM,
   MONTHOFYEAR,
   HOURSOFDAY,
   MINUTESOFDAY,
   TIMEOFDAY
)
AS
/* Formatted on 13/07/2015 10:02:15 AM (QP5 v5.269.14213.34769) */
  SELECT /*+ INDEX_DESC(COGIPF_EDITQUERY) */
        COGIPF_USERLOGON.COGIPF_SESSIONID,
         COGIPF_USERLOGON.COGIPF_USERNAME,
         COUNT (DISTINCT COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP)
            COGIPF_EXECOUNT,
         SUBSTR (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                   INSTR (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                          '''',
                          1,
                          3)
                 + 1,
                   INSTR (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                          '''',
                          1,
                          4)
                 - INSTR (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                          '''',
                          1,
                          3)
                 - 1)
            DEPT_ASPACKAGE,
         NVL (SUBSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                        INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                               '''',
                               1,
                               1)
                      + 1,
                        INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                               '''',
                               1,
                               2)
                      - INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                               '''',
                               1,
                               1)
                      - 1),
              'NULL')
            PIMART_ROOT,
         CASE
            WHEN COGIPF_EDITQUERY.COGIPF_QUERYPATH LIKE '%adHocReport'
            THEN
               'RUN FROM PARENT PACKAGE'
            WHEN COGIPF_EDITQUERY.COGIPF_QUERYPATH LIKE 'CAMID%'
            THEN
               'MYFolders'
            ELSE
               SUBSTR (
                  SUBSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                            REGEXP_INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                                          '/folder',
                                          1,
                                          2)
                          + 15),
                  1,
                    REGEXP_INSTR (
                       SUBSTR (
                          COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                            REGEXP_INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                                          '/folder',
                                          1,
                                          2)
                          + 15),
                       ''']',
                       1)
                  - 1)
         END
            PIMART_SUBFLD1,
         CASE
            WHEN COGIPF_EDITQUERY.COGIPF_QUERYPATH LIKE '%adHocReport'
            THEN
               'RUN FROM PARENT PACKAGE'
            WHEN COGIPF_EDITQUERY.COGIPF_QUERYPATH LIKE 'CAMID%'
            THEN
               'MYFolders'
            ELSE
               SUBSTR (
                  SUBSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                            REGEXP_INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                                          '/folder',
                                          1,
                                          3)
                          + 15),
                  1,
                    REGEXP_INSTR (
                       SUBSTR (
                          COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                            REGEXP_INSTR (COGIPF_EDITQUERY.COGIPF_QUERYPATH,
                                          '/folder',
                                          1,
                                          3)
                          + 15),
                       ''']',
                       1)
                  - 1)
         END
            PIMART_SUBFLD2,
         COGIPF_EDITQUERY.COGIPF_TARGET_TYPE,
         COGIPF_EDITQUERY.COGIPF_QUERYNAME,
         CASE
            WHEN COGIPF_EDITQUERY.COGIPF_QUERYNAME LIKE 'adHocReport'
            THEN
               'RUN FROM PARENT PACKAGE'
            ELSE
               RTRIM (SUBSTR (COGIPF_EDITQUERY.COGIPF_QUERYNAME, 17), ''']')
         END
            QUERYNAME,
         SUBSTR (
            SUBSTR (
               COGIPF_EDITQUERY.COGIPF_PACKAGE,
                 REGEXP_INSTR (
                    COGIPF_EDITQUERY.COGIPF_PACKAGE,
                    '/package',
                    1,
                    REGEXP_COUNT (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                                  '/package',
                                  1))
               + 16),
            1,
              REGEXP_INSTR (
                 SUBSTR (
                    COGIPF_EDITQUERY.COGIPF_PACKAGE,
                      REGEXP_INSTR (
                         COGIPF_EDITQUERY.COGIPF_PACKAGE,
                         '/package',
                         1,
                         REGEXP_COUNT (COGIPF_EDITQUERY.COGIPF_PACKAGE,
                                       '/package',
                                       1))
                    + 16),
                 '''',
                 1)
            - 1)
            COGPACKAGE_NAME,
         COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP,
         TO_CHAR (COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP, 'DD/MM/YYYY')
            REPORTDATE,
         TO_CHAR (EXTRACT (YEAR FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP))
            YEAR,
         EXTRACT (MONTH FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP) MONTHNUM,
         CASE EXTRACT (MONTH FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP)
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
            MONTHOFYEAR,
         EXTRACT (HOUR FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP) HOURSOFDAY,
         EXTRACT (MINUTE FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP)
            MINUTESOFDAY,
            TO_CHAR (
               EXTRACT (HOUR FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP),
               '00')
         || ' :'
         || TO_CHAR (
               EXTRACT (MINUTE FROM COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP),
               '00')
            TIMEOFDAY
    FROM COGIPF_USERLOGON COGIPF_USERLOGON, COGIPF_EDITQUERY COGIPF_EDITQUERY
   WHERE     COGIPF_EDITQUERY.COGIPF_SESSIONID =
                COGIPF_USERLOGON.COGIPF_SESSIONID
         AND COGIPF_EDITQUERY.COGIPF_SESSIONID =
                COGIPF_USERLOGON.COGIPF_SESSIONID
         AND COGIPF_EDITQUERY.COGIPF_TARGET_TYPE =
                'Analysis ReportService' || SUBSTR (UID, 1, 0)
GROUP BY COGIPF_USERLOGON.COGIPF_SESSIONID,
         COGIPF_USERLOGON.COGIPF_USERNAME,
         COGIPF_EDITQUERY.COGIPF_TARGET_TYPE,
         COGIPF_EDITQUERY.COGIPF_QUERYNAME,
         COGIPF_EDITQUERY.COGIPF_QUERYPATH,
         COGIPF_EDITQUERY.COGIPF_PACKAGE,
         COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP
ORDER BY COGIPF_EDITQUERY.COGIPF_LOCALTIMESTAMP DESC

COMMIT;
