/* Formatted on 14/01/2016 8:28:07 AM (QP5 v5.287) */
SELECT DISTINCT
       (COGIPF_USERLOGON.COGIPF_SESSIONID),
       COGIPF_USERLOGON.COGIPF_USERNAME,
       SUBSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                 INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                        CHR (39),
                        1,
                        3)
               + 1,
               (  INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                         CHR (39),
                         1,
                         4)
                - INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                         CHR (39),
                         1,
                         3)
                - 1))
          DEPT_CUBEPACKAGE,
       NVL (SUBSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                      INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                             CHR (39),
                             1,
                             1)
                    + 1,
                    (  INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                              CHR (39),
                              1,
                              2)
                     - INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                              CHR (39),
                              1,
                              1)
                     - 1)),
            'storeID')
          PIMART_ROOT,
       /* Folder sublevel 1 */
       (CASE
           WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
           THEN
              'NULL'
           WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
           THEN
              'NULL'
           ELSE
              SUBSTR (
                 SUBSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         2)
                         + 15),
                 1,
                   REGEXP_INSTR (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         2)
                         + 15),
                      ''']',
                      1)
                 - 1)
        END)
          PIMART_SUBFLD1,
       /*Folder sublevel 2 */
       (CASE
           WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
           THEN
              'NULL'
           WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
           THEN
              'NULL'
           ELSE
              SUBSTR (
                 SUBSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         3)
                         + 15),
                 1,
                   REGEXP_INSTR (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
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
           WHEN 
                REGEXP_REPLACE (
                    (CASE
                        WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
                        THEN
                           'NULL'
                        WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE
                                'storeID%'
                        THEN
                           'NULL'
                        ELSE
                           SUBSTR (
                              SUBSTR (
                                 COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   REGEXP_INSTR (
                                      COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                      '/folder',
                                      1,
                                      4)
                                 + 15),
                              1,
                                REGEXP_INSTR (
                                   SUBSTR (
                                      COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                        REGEXP_INSTR (
                                           COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                           '/folder',
                                           1,
                                           4)
                                      + 15),
                                   ']',
                                   1)
                              - 1)
                     END),
                    '"') LIKE 'r[@name=%' 
        THEN
                '\END OF PATH'
        ELSE
             REGEXP_REPLACE(
                     (CASE
                         WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
                         THEN
                            'NULL'
                         WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
                         THEN
                            'NULL'
                         ELSE
                            SUBSTR (
                               SUBSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                                       '/folder',
                                                       1,
                                                       4)
                                       + 15),
                               1,
                                 REGEXP_INSTR (
                                    SUBSTR (
                                       COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                                       '/folder',
                                                       1,
                                                       4)
                                       + 15),
                                    ']',
                                    1)
                               - 1)
                      END),'"')
         END)          
             PIMART_SUBFLD3,
         /* Last Folder in Path */
         (CASE
             WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
             THEN
                'NULL'
             WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
             THEN
                'NULL'
             ELSE
                SUBSTR (
                   REPLACE (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (
                              COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                              '/folder',
                              1,
                              REGEXP_COUNT (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                            '/folder',
                                            1))
                         + 15),
                      CHR (34),
                      CHR (39)),
                   1,
                     REGEXP_INSTR (
                        REPLACE (
                           SUBSTR (
                              COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   REGEXP_COUNT (
                                      COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                      '/folder',
                                      1))
                              + 15),
                           CHR (34),
                           CHR (39)),
                        ''']',
                        1)
                   - 1)
          END)
            ENDFOLDER,
            NVL (SUBSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                  CHR (39),
                                  1,
                                  1)
                         + 1,
                         (  INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   CHR (39),
                                   1,
                                   2)
                          - INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   CHR (39),
                                   1,
                                   1)
                          - 1)),
                 'storeID')
         || '->'
         || (CASE
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'NULL'
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
                THEN
                   'NULL'
                ELSE
                   SUBSTR (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         2)
                         + 15),
                      1,
                        REGEXP_INSTR (
                           SUBSTR (
                              COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   2)
                              + 15),
                           ''']',
                           1)
                      - 1)
             END)
         || '->'
         || (CASE
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'NULL'
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
                THEN
                   'NULL'
                ELSE
                   SUBSTR (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                           REGEXP_INSTR (COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1,
                                         3)
                         + 15),
                      1,
                        REGEXP_INSTR (
                           SUBSTR (
                              COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                REGEXP_INSTR (
                                   COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   '/folder',
                                   1,
                                   3)
                              + 15),
                           ''']',
                           1)
                      - 1)
             END)
         || '->...'
         || (CASE
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'CAMID%'
                THEN
                   'NULL'
                WHEN COGIPF_POWERPLAY.COGIPF_REPORTPATH LIKE 'storeID%'
                THEN
                   'NULL'
                ELSE
                   SUBSTR (
                      REPLACE (
                         SUBSTR (
                            COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                              REGEXP_INSTR (
                                 COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                 '/folder',
                                 1,
                                 REGEXP_COUNT (
                                    COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                    '/folder',
                                    1))
                            + 15),
                         CHR (34),
                         CHR (39)),
                      1,
                        REGEXP_INSTR (
                           REPLACE (
                              SUBSTR (
                                 COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                   REGEXP_INSTR (
                                      COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                      '/folder',
                                      1,
                                      REGEXP_COUNT (
                                         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
                                         '/folder',
                                         1))
                                 + 15),
                              CHR (34),
                              CHR (39)),
                           ''']',
                           1)
                      - 1)
             END)
            FOLDERPATH,
         COGIPF_POWERPLAY.COGIPF_REPORTNAME REPORTNAME,
         COGIPF_POWERPLAY.COGIPF_PACKAGE,
         (CASE
             WHEN COGIPF_POWERPLAY.COGIPF_PACKAGE LIKE 'CAMID%'
             THEN
                'NULL'
             WHEN COGIPF_POWERPLAY.COGIPF_PACKAGE LIKE 'storeID%'
             THEN
                'NULL'
             ELSE
                SUBSTR (
                   REPLACE (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_PACKAGE,
                           REGEXP_INSTR (
                              COGIPF_POWERPLAY.COGIPF_PACKAGE,
                              '/folder',
                              1,
                              REGEXP_COUNT (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                                            '/folder',
                                            1))
                         + 15),
                      CHR (34),
                      CHR (39)),
                   1,
                     REGEXP_INSTR (
                        REPLACE (
                           SUBSTR (
                              COGIPF_POWERPLAY.COGIPF_PACKAGE,
                                REGEXP_INSTR (
                                   COGIPF_POWERPLAY.COGIPF_PACKAGE,
                                   '/folder',
                                   1,
                                   REGEXP_COUNT (
                                      COGIPF_POWERPLAY.COGIPF_PACKAGE,
                                      '/folder',
                                      1))
                              + 15),
                           CHR (34),
                           CHR (39)),
                        ''']',
                        1)
                   - 1)
          END)
            JOBFOLDER_NAME,
         (CASE
             WHEN COGIPF_POWERPLAY.COGIPF_PACKAGE LIKE 'CAMID%'
             THEN
                'NULL'
             WHEN COGIPF_POWERPLAY.COGIPF_PACKAGE LIKE 'storeID%'
             THEN
                'NULL'
             ELSE
                RTRIM (
                   REPLACE (
                      SUBSTR (
                         COGIPF_POWERPLAY.COGIPF_PACKAGE,
                           REGEXP_INSTR (
                              COGIPF_POWERPLAY.COGIPF_PACKAGE,
                              '/package',
                              1,
                              REGEXP_COUNT (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                                            '/package',
                                            1))
                         + 16),
                      CHR (34),
                      CHR (39)),
                   ''']')
          END)
            PACKAGE_NAME,
         SUBSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                   INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                          CHR (39),
                          1,
                          5)
                 + 1,
                 (  INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                           CHR (39),
                           1,
                           6)
                  - INSTR (COGIPF_POWERPLAY.COGIPF_PACKAGE,
                           CHR (39),
                           1,
                           5)
                  - 1))
            COGPACKAGE_TYPE,
         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
         COGIPF_POWERPLAY.COGIPF_PACKAGE COGIPF_PACKAGE_PATH,
         COGIPF_POWERPLAY.COGIPF_DATASOURCE,
         COGIPF_POWERPLAY.COGIPF_DATASOURCE_CONNECTION,
         COGIPF_POWERPLAY.COGIPF_CUBEPATH,
         COUNT (COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP) COGIPF_EXECOUNT,
         COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP,
         TO_CHAR (COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP, 'DD/MM/YYYY')
            REPORTDATE,
         EXTRACT (HOUR FROM COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP) HOURSOFDAY,
         EXTRACT (MINUTE FROM COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP)
            MINUTESOFDAY,
         (   TO_CHAR (
                EXTRACT (HOUR FROM COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP),
                '00')
          || ' :'
          || TO_CHAR (
                EXTRACT (MINUTE FROM COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP),
                '00'))
            TIMEOFDAY
    FROM COGIPF_USERLOGON COGIPF_USERLOGON, COGIPF_POWERPLAY COGIPF_POWERPLAY
   WHERE     COGIPF_POWERPLAY.COGIPF_SESSIONID =
                COGIPF_USERLOGON.COGIPF_SESSIONID || ''
         AND COGIPF_POWERPLAY.COGIPF_SESSIONID =
                COGIPF_USERLOGON.COGIPF_SESSIONID || ''
         AND COGIPF_USERLOGON.COGIPF_USERNAME NOT LIKE 'not available'
GROUP BY COGIPF_USERLOGON.COGIPF_SESSIONID,
         COGIPF_USERLOGON.COGIPF_USERNAME,
         COGIPF_POWERPLAY.COGIPF_REPORTNAME,
         COGIPF_POWERPLAY.COGIPF_REPORTPATH,
         COGIPF_POWERPLAY.COGIPF_PACKAGE,
         COGIPF_POWERPLAY.COGIPF_DATASOURCE,
         COGIPF_POWERPLAY.COGIPF_DATASOURCE_CONNECTION,
         COGIPF_POWERPLAY.COGIPF_CUBEPATH,
         COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP
ORDER BY COGIPF_POWERPLAY.COGIPF_LOCALTIMESTAMP DESC;
