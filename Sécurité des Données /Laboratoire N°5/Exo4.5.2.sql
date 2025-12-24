GO
USE Middleton;
GO

-- On y déplace les tables
ALTER SCHEMA KimServices TRANSFER dbo.Website;
ALTER SCHEMA KimServices TRANSFER dbo.Babysitting;
ALTER SCHEMA KimServices TRANSFER dbo.LowMowning;