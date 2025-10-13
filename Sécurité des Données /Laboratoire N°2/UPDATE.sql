go
use cafe;
go
update [CafeToPointDeVente] set Date_End = NULL where Date_End = '1900-01-01';
insert into cafe (Nom, Intensité, Description, PrixVenteConseillé, Torréfaction) values ('cafe
du Bresil', 5, 'cafe cultivé à la main', 9,2) ;