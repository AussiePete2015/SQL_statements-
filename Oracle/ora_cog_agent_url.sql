ROP VIEW VW_COG_AGENTURL;

/* Formatted on 9/07/2015 1:10:05 PM (QP5 v5.269.14213.34769) */
CREATE OR REPLACE FORCE VIEW VW_COG_AGENTURL
(
   COGIPF_SESSIONID,
   COGIPF_USERNAME,
   COGIPF_EXECOUNT,
   COGIPF_TARGET_TYPE,
   COGIPF_TARGET_PATH,
   PIMART_ROOT,
   PIMART_JOBFOLDER,
   URL_NAME,
   COGIPF_LOCALTIMESTAMP,
   REPORTDATE,
   YEAR,
   MONTHNUM
   MONTHOFYEAR
)
AS
     SELECT /*+ USE_MERGE(COGIPF_ACTION,COGIPF_USERLOGON) */
           COGIPF_USERLOGON.COGIPF_SESSIONID,
            COGIPF_USERLOGON.COGIPF_USERNAME,
            COUNT (DISTINCT COGIPF_ACTION.COGIPF_LOCALTIMESTAMP)
               COGIPF_EXECOUNT,
            COGIPF_ACTION.COGIPF_TARGET_TYPE,
            COGIPF_ACTION.COGIPF_TARGET_PATH,
            CASE
            WHEN COGIPF_ACTION.COGIPF_TARGET_PATH LIKE 'Chr(126)Chr(126)%'
            THEN 'DELETED'
            ELSE
            NVL (SUBSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                           INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  1)
                         + 1,
                           INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  2)
                         - INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  1)
                         - 1),
                 'NULL')
               PIMART_ROOT,
            NVL (SUBSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                           INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  3)
                         + 1,
                           INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  4)
                         - INSTR (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                  '/',
                                  1,
                                  3)
                         - 1),
                 'NULL')
               PIMART_JOBFOLDER,
            NVL (
               RTRIM (
                  SUBSTR (
                     COGIPF_ACTION.COGIPF_TARGET_PATH,
                       REGEXP_INSTR (
                          COGIPF_ACTION.COGIPF_TARGET_PATH,
                          '/',
                          1,
                          REGEXP_COUNT (COGIPF_ACTION.COGIPF_TARGET_PATH,
                                        '/',
                                        1))
                     + 1),
                  ''']'),
               'NULL')
               URL_NAME,
            COGIPF_ACTION.COGIPF_LOCALTIMESTAMP,
            TO_CHAR (COGIPF_ACTION.COGIPF_LOCALTIMESTAMP, 'DD/MM/YYYY')
               REPORTDATE,
            TO_CHAR (
               EXTRACT (YEAR FROM COGIPF_ACTION.COGIPF_LOCALTIMESTAMP))
               YEAR,
            EXTRACT (MONTH FROM COGIPF_ACTION.COGIPF_LOCALTIMESTAMP)
               MONTHNUM,
            EXTRACT (DAY FROM COGIPF_ACTION.COGIPF_LOCALTIMESTAMP) DAY,
            (CASE EXTRACT (MONTH FROM COGIPF_ACTION.COGIPF_LOCALTIMESTAMP)
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
             END)
               MONTHOFYEAR
      FROM COGIPF_USERLOGON COGIPF_USERLOGON,
            COGIPF_ACTION COGIPF_ACTION
      WHERE     COGIPF_ACTION.COGIPF_SESSIONID =
                   COGIPF_USERLOGON.COGIPF_SESSIONID
            AND COGIPF_ACTION.COGIPF_SESSIONID =
                   COGIPF_USERLOGON.COGIPF_SESSIONID
            AND COGIPF_ACTION.COGIPF_TARGET_TYPE = 'URL'
            AND COGIPF_USERLOGON.COGIPF_LOGON_OPERATION = 'Logon'
            AND COGIPF_USERLOGON.COGIPF_STATUS = 'Success'
            AND COGIPF_ACTION.COGIPF_TARGET_PATH NOT LIKE ('%CAMID%')
   GROUP BY COGIPF_USERLOGON.COGIPF_SESSIONID,
            COGIPF_USERLOGON.COGIPF_USERNAME,
            COGIPF_ACTION.COGIPF_TARGET_TYPE,
            COGIPF_ACTION.COGIPF_TARGET_PATH,
            COGIPF_ACTION.COGIPF_LOCALTIMESTAMP
   ORDER BY COGIPF_ACTION.COGIPF_LOCALTIMESTAMP DESC;
