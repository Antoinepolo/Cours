GO
USE DB_SecuData_Audit;
GO

CREATE LOGIN [Manip9_Owner]
WITH PASSWORD = 'Tigrou007',
	DEFAULT_DATABASE = [DB_SecuData_Audit],
	CHECK_POLICY = ON;

CREATE USER [Manip9_Owner]
FOR LOGIN [Manip9_Owner]

ALTER ROLE [db_owner] ADD MEMBER [Manip9_Owner];