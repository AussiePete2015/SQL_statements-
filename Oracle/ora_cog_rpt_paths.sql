DROP VIEW VW_CS10_OBJECTS;

/* Formatted on 14/01/2016 11:39:51 AM (QP5 v5.287) */
CREATE OR REPLACE FORCE VIEW VW_CS10_OBJECTS
(
   CONTENT_MANAGERID_BASE,
   CONTENT_MANAGER_ID,
   CREATE_DATE,
   MODIFIED_DATE,
   OBJECT_NAME,
   TREE,
   FOLDER_ROOT,
   PIMART_FOLDER_ROOT,
   THIRD_TIER_FOLDER,
   FOURTH_TIER_FOLDER,
   FIFTH_TIER_FOLDER,
   SIXTH_TIER_FOLDER,
   SEVENTH_TIER_FOLDER,
   EIGHTH_TIER_FOLDER,
   REPORT_NAME,
   REPORTVIEW_NAME,
   POWERPLAY_REPORTNAME,
   URL_NAME,
   PACKAGE_NAME
)
AS
   SELECT CMOBJNAMES_BASE.CMID CONTENT_MANAGERID_BASE,
          CMOBJECTS.CMID CONTENT_MANAGER_ID,
          CMOBJECTS.CREATED CREATE_DATE,
          CMOBJECTS.MODIFIED MODIFIED_DATE,
          CMOBJNAMES_BASE.NAME OBJECT_NAME,
          VW_CM_CMID_LDSPACTREE.TREE,
          UPPER (NVL (SUBSTR (TREE,
                                INSTR (TREE,':',
                                       1,
                                       1)
                              + 1,
                                INSTR (TREE,
                                       ':',
                                       1,
                                       2)
                              - INSTR (TREE,
                                       ':',
                                       1,
                                       1)
                              - 1),
                      'NULL'))
             FOLDER_ROOT,
          UPPER (NVL (SUBSTR (TREE,
                                INSTR (TREE,
                                       ':',
                                       1,
                                       3)
                              + 1,
                                INSTR (TREE,
                                       ':',
                                       1,
                                       4)
                              - INSTR (TREE,
                                       ':',
                                       1,
                                       3)
                              - 1),
                      'NULL'))
             PIMART_FOLDER_ROOT,
          CASE
             WHEN REGEXP_COUNT (TREE, '/folder', 2) >= 2
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    2)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               2)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      2)
                      + 15))
             ELSE
                'NULL'
          END
             THIRD_TIER_FOLDER,
          CASE
             WHEN (REGEXP_COUNT (TREE, '/folder', 3)) >= 3
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    3)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               3)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      3)
                      + 15))
             ELSE
                'NULL'
          END
             FOURTH_TIER_FOLDER,
          CASE
             WHEN (REGEXP_COUNT (TREE, '/folder', 4)) >= 4
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    4)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               4)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      4)
                      + 15))
             ELSE
                'NULL'
          END
             FIFTH_TIER_FOLDER,
          CASE
             WHEN (REGEXP_COUNT (TREE, '/folder', 5)) >= 5
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    5)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               5)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      5)
                      + 15))
             ELSE
                'NULL'
          END
             SIXTH_TIER_FOLDER,
          CASE
             WHEN (REGEXP_COUNT (TREE, '/folder', 6)) >= 6
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    6)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               6)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      6)
                      + 15))
             ELSE
                'NULL'
          END
             SEVENTH_TIER_FOLDER,
          CASE
             WHEN (REGEXP_COUNT (TREE, '/folder', 7)) >= 7
             THEN
                SUBSTR (
                   REPLACE (TREE, CHR (34), CHR (39)),
                   (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/folder',
                                    1,
                                    7)
                    + 15),
                     (  INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                               ']',
                               1,
                               7)
                      - 1)
                   - (  REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                      '/folder',
                                      1,
                                      7)
                      + 15))
             ELSE
                'NULL'
          END
             EIGHTH_TIER_FOLDER,
          CASE REGEXP_COUNT (TREE, '/report[[.[.]]', 1)
             WHEN 1
             THEN
                SUBSTR (
                   SUBSTR (
                      REPLACE (TREE, CHR (34), CHR (39)),
                      REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/report[[.[.]]',
                                    1,
                                    1)),
                     INSTR (
                        SUBSTR (
                           REPLACE (TREE, CHR (34), CHR (39)),
                           REGEXP_INSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              '/report[[.[.]]',
                              1,
                              1)),
                        '''',
                        1,
                        1)
                   + 1,
                     (  INSTR (
                           SUBSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              REGEXP_INSTR (
                                 REPLACE (TREE, CHR (34), CHR (39)),
                                 '/report[[.[.]]',
                                 1,
                                 1)),
                           ']',
                           1,
                           1)
                      - 1)
                   - INSTR (
                        SUBSTR (
                           REPLACE (TREE, CHR (34), CHR (39)),
                           REGEXP_INSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              '/report[[.[.]]',
                              1,
                              1)),
                        '''',
                        1,
                        1)
                   - 1)
             ELSE
                'NULL'
          END
             REPORT_NAME,
          CASE REGEXP_COUNT (TREE, '/reportView[[.[.]]', 1)
             WHEN 1
             THEN
                SUBSTR (
                   SUBSTR (
                      REPLACE (TREE, CHR (34), CHR (39)),
                      REGEXP_INSTR (REPLACE (TREE, CHR (34), CHR (39)),
                                    '/reportView[[.[.]]',
                                    1,
                                    1)),
                     INSTR (
                        SUBSTR (
                           REPLACE (TREE, CHR (34), CHR (39)),
                           REGEXP_INSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              '/reportView[[.[.]]',
                              1,
                              1)),
                        '''',
                        1,
                        1)
                   + 1,
                     (  INSTR (
                           SUBSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              REGEXP_INSTR (
                                 REPLACE (TREE, CHR (34), CHR (39)),
                                 '/reportView[[.[.]]',
                                 1,
                                 1)),
                           ']',
                           1,
                           1)
                      - 1)
                   - INSTR (
                        SUBSTR (
                           REPLACE (TREE, CHR (34), CHR (39)),
                           REGEXP_INSTR (
                              REPLACE (TREE, CHR (34), CHR (39)),
                              '/reportView[[.[.]]',
                              1,
                              1)),
                        '''',
                        1,
                        1)
                   - 1)
             ELSE
                'NULL'
          END
             REPORTVIEW_NAME,
          CASE REGEXP_COUNT (TREE, '/powerPlay8Report', 1)
             WHEN 1
             THEN
                SUBSTR (
                   SUBSTR (TREE,
                           REGEXP_INSTR (TREE,
                                         '/powerPlay8Report',
                                         1,
                                         1)),
                     INSTR (SUBSTR (TREE,
                                    REGEXP_INSTR (TREE,
                                                  '/powerPlay8Report',
                                                  1,
                                                  1)),
                            '''',
                            1,
                            1)
                   + 1,
                     (  INSTR (SUBSTR (TREE,
                                       REGEXP_INSTR (TREE,
                                                     '/powerPlay8Report',
                                                     1,
                                                     1)),
                               ']',
                               1,
                               1)
                      - 1)
                   - INSTR (SUBSTR (TREE,
                                    REGEXP_INSTR (TREE,
                                                  '/powerPlay8Report',
                                                  1,
                                                  1)),
                            '''',
                            1,
                            1)
                   - 1)
             ELSE
                'NULL'
          END
             POWERPLAY_REPORTNAME,
          CASE REGEXP_COUNT (TREE, '/URL', 1)
             WHEN 1
             THEN
                SUBSTR (SUBSTR (TREE,
                                REGEXP_INSTR (TREE,
                                              '/URL',
                                              1,
                                              1)),
                          INSTR (SUBSTR (TREE,
                                         REGEXP_INSTR (TREE,
                                                       '/URL',
                                                       1,
                                                       1)),
                                 '''',
                                 1,
                                 1)
                        + 1,
                          (  INSTR (SUBSTR (TREE,
                                            REGEXP_INSTR (TREE,
                                                          '/URL',
                                                          1,
                                                          1)),
                                    ']',
                                    1,
                                    1)
                           - 1)
                        - INSTR (SUBSTR (TREE,
                                         REGEXP_INSTR (TREE,
                                                       '/URL',
                                                       1,
                                                       1)),
                                 '''',
                                 1,
                                 1)
                        - 1)
             ELSE
                'NULL'
          END
             URL_NAME,
          CASE REGEXP_COUNT (TREE, '/package', 1)
             WHEN 1
             THEN
                SUBSTR (SUBSTR (TREE,
                                REGEXP_INSTR (TREE,
                                              '/package',
                                              1,
                                              1)),
                          INSTR (SUBSTR (TREE,
                                         REGEXP_INSTR (TREE,
                                                       '/package',
                                                       1,
                                                       1)),
                                 '''',
                                 1,
                                 1)
                        + 1,
                          (  INSTR (SUBSTR (TREE,
                                            REGEXP_INSTR (TREE,
                                                          '/package',
                                                          1,
                                                          1)),
                                    ']',
                                    1,
                                    1)
                           - 1)
                        - INSTR (SUBSTR (TREE,
                                         REGEXP_INSTR (TREE,
                                                       '/package',
                                                       1,
                                                       1)),
                                 '''',
                                 1,
                                 1)
                        - 1)
             ELSE
                'NULL'
          END
             PACKAGE_NAME
     FROM PRODCOGNOS10_CS.CMOBJNAMES_BASE,
          PRODCOGNOS10_CS.CMOBJECTS,
          C1021ADT.VW_CM_CMID_LDSPACTREE
    WHERE 
        prodcognos10_CS.CMOBJNAMES_BASE.CMID = prodcognos10_CS.CMOBJECTS.PCMID
    AND C1021ADT.VW_CM_CMID_LDSPACTREE.CMID = prodcognos10_CS.CMOBJECTS.CMID    
    AND prodcognos10_CS.CMOBJNAMES_BASE.ISDEFAULT = 1
    AND prodcognos10_CS.CMOBJNAMES_BASE.MAPDLOCALEID = 96;
