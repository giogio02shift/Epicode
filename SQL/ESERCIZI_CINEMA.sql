#10- Il titolo dei film in cui recitano M. Mastroianni e S.Loren
#metto la percentuale perchè mi recupera tutti i caratteri prima di mastroiani indipendententemente da quello che c'è prima 
select F.titolo
FROM Film F
WHERE F.titolo IN(
	select F.titolo
	from Film F 
	join Recita R on F.CodFilm = R.IdFilm
	join Attori A on R.CodAttore = A.CodAttore
	Where A.Nome like "%Mastroianni"
) AND F.titolo IN (
select F.titolo
from Film F 
join Recita R on F.CodFilm = R.IdFilm
join Attori A on R.CodAttore = A.CodAttore
Where A.Nome like "%Loren");

#I titoli dei film dello stesso regista di “Shutter Island”;
select Regista from film where Titolo like 'Shutter Island';
#adesso annido la query
select F.Titolo from film F
where F.Regista = (select Regista from film where Titolo like 'Shutter Island');


