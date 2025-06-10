START TRANSACTION;
SELECT * FROM region;
UPDATE region
SET  citta = 'Cagliari'
WHERE Idregion =2;
COMMIT;
START TRANSACTION;
UPDATE region
SET Regione = 'Sardegna'
WHERE Idregion=2;
COMMIT;
SELECT * FROM region;
BEGIN;
UPDATE region
SET AreaGeografica='Sud'
WHERE Idregion=2;
ROLLBACK;
BEGIN;
DELETE FROM region
WHERE Idregion =1;
SELECT * FROM region;#QUESTA SELECT MI SERVE PER  VISUALIZZARE LE MODIFICHE APPORTATE(OVVERO NESSUNA FINO A QUANDO FACCIO COMMIT)
ROLLBACK;
select * FROM Region; #infatti i record della tabella regioni sono rimasti invariati.

