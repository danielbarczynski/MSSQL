-- Having basically is where/if for aggregate function
SELECT Nazwa, AVG(Cena) as srednia, COUNT(*) as liczba
FROM Pokoje
    LEFT JOIN RodzajPokoju ON RodzajPokoju.ID = Pokoje.RodzajPokojID
WHERE Cena > 200
GROUP BY Nazwa
HAVING AVG(Cena) > 230 
ORDER BY COUNT(*), AVG(Cena)

-- grouping by ID make no sens, since every ID is unique
select Nazwa, count(*) as count
from Pokoje
    left join RodzajPokoju on RodzajPokoju.ID = Pokoje.RodzajPokojID
group by Nazwa
having count(*) > 2