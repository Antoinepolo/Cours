GO
USE Manip2;
GO

INSERT INTO dbo.Person (name, age, job) VALUES
('Autouser' + FORMAT(GETDATE(), 'HHmmss'), 20, 'Insertion Automatique');

PRINT 'Nouvelle personne ajoutée avec succès'