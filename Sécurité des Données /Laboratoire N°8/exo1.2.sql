GO
USE Manip2;
GO

DELETE FROM dbo.Person
WHERE idPerson = (
    SELECT MAX(idPerson) FROM dbo.Person
);
