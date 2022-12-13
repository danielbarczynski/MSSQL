-- with groupby (3 rows with different results)
SELECT Nazwa, AVG(Cena) as srednia, COUNT(*) as liczba
FROM Pokoje
    LEFT JOIN RodzajPokoju ON RodzajPokoju.ID = Pokoje.RodzajPokojID
WHERE Cena > 200
GROUP BY Nazwa
HAVING AVG(Cena) > 230
ORDER BY COUNT(*), AVG(Cena)

-- without groupby (common result in one row)
SELECT AVG(Cena) as srednia, COUNT(*) as liczba
FROM Pokoje
    LEFT JOIN RodzajPokoju ON RodzajPokoju.ID = Pokoje.RodzajPokojID
WHERE Cena > 200
HAVING AVG(Cena) > 230
ORDER BY COUNT(*), AVG(Cena)