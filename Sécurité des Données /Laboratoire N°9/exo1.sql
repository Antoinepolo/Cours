GO
USE DB_SecuData_Audit;
GO

CREATE LOGIN [Manip9_Reader]
WITH PASSWORD = 'Tigrou007',
	DEFAULT_DATABASE = [DB_SecuData_Audit],
	CHECK_POLICY = ON;

CREATE USER [Manip9_Reader]
FOR LOGIN [Manip9_Reader]

ALTER ROLE [db_datareader] ADD MEMBER [Manip9_Reader];

GRANT SELECT ON dbo.Personne TO [Manip9_Reader];