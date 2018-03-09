SELECT
       sp.name,
       sp.principal_id as login_principal_id,
       sp.type_desc,
       sp2.name AS dbrole_name,
       sp2.principal_id as role_principal_id
FROM sys.server_principals AS sp
       LEFT JOIN sys.server_role_members AS sr
             ON sp.principal_id = sr.member_principal_id
       LEFT JOIN sys.server_principals AS sp2
             ON sp2.principal_id = sr.role_principal_id

SELECT
       grantee_principal_id,
       class_desc,
       [permission_name],
       state_desc
FROM sys.server_permissions
WHERE grantee_principal_id = 370

SELECT * FROM information_schema.tables

SELECT *
FROM sysobjects sobjects
