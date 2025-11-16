CREATE TABLE Store(
Idstore INT
, nome VARCHAR(25)
, DataApertura DATE
, DataChiusura DATE
, categoria VARCHAR(25)
, CONSTRAINT PK_Store PRIMARY KEY  (Idstore) );

CREATE TABLE  Region(
Idregion INT,
citta VARCHAR(25),
Regione VARCHAR(30),
AreaGeogarfica VARCHAR(30));
#la relazione tra le tabella è 1 a n perchè uno store può essere in un solo territorio mentre un territorio può avere più store. d ciò deduciamo che il lato n è la tabella store  e quindi inseriamo una FOREIGN KEY ALL'INTERNO.


