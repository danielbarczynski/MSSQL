-- 11.01 (NULL w wyra¿eniach i funkcjach agreguj¹cych)

--a) Wykonaj zapytanie:

SELECT 34+NULL
select 3 * 2 - 5

-- b) Wszystkie dane o tych pracownikach, dla których brakuje numeru PESEL lub daty zatrudnienia 
-- (warunek klauzuli WHERE napisz w taki sposób aby by³ SARG) 13 rekordów 

select * from employees
where PESEL is null or employment_date is null

--c) Zapytanie wybieraj¹ce wszystkie dane z tabeli students_modules.
--Zauwa¿, ¿e dla niektórych egzaminów nie wyznaczono planned_exam_date.

select * from students_modules

/* d) Zapytanie, które dla ka¿dego rekordu z tabeli students_modules zwróci informacjê, 
ile dni minê³o od planowanego egzaminu (wykorzystaj funkcjê DateDiff).
Dane posortowane malej¹co wed³ug daty. 
Zapamiêtaj ile rekordów zwróci³o zapytanie. 94 rekordy, w pierwszych dwóch student_id jest 17 i 1*/ 

SELECT student_id, module_id, planned_exam_date, DATEDIFF(day, planned_exam_date,  getdate()) AS no_days
from students_modules 
order by planned_exam_date desc

/* e) Zapytanie zwracaj¹ce wynik dzia³ania funkcji agreguj¹cej COUNT na polu planned_exam_date tabeli 
students_modules. Zwrócona wartoœæ oznaczaj¹ca liczbê takich rekordów jest mniejsza 
ni¿ liczba rekordów w tabeli. Wyjaœnij dlaczego. 16 rekordów*/ 

select COUNT(planned_exam_date) as no_of_records from students_modules

/* f) Zapytanie zwracaj¹ce wynik dzia³ania funkcji agreguj¹cej COUNT(*) dla tabeli students_modules. 
Wartoœæ oznaczaj¹ca liczbê rekordów jest równa liczbie rekordów w tabeli. Wyjaœnij dlaczego.
Zapytanie zwróci³o liczbê 94*/

select count (*) as quantity from students_modules 
--(*) always returns numbers of rows

--11.02 (DISTINCT)

/* a) Zapytanie zwracaj¹ce identyfikatory studentów wraz z datami przyst¹pienia do egzaminów. 
Jeœli student danego dnia przyst¹pi³ do wielu egzaminów, jego identyfikator ma siê pojawiæ tylko raz.
Dane posortowane malej¹co wzglêdem dat.50 rekordów*/

select distinct student_id, exam_date from student_grades order by exam_date desc

/* b) Zapytanie zwracaj¹ce identyfikatory studentów, którzy przyst¹pili do egzaminu w marcu 2018 roku. 
Identyfikator ka¿dego studenta ma siê pojawiæ tylko raz. Dane posortowane malej¹co wed³ug 
identyfikatorów studentów. 10 rekordów*/

select distinct student_id from student_grades 
where exam_date > '20180301' and exam_date < '20180401'
order by student_id desc

--or

select distinct student_id from student_grades
where exam_date between '20180301' and '20180401'
order by student_id desc

--11.03

/* Spróbuj wykonaæ zapytanie:
SELECT student_id, surname AS family_name
FROM students
WHERE family_name='Fisher'
Wyjaœnij dlaczego jest ono niepoprawne a nastêpnie je skoryguj.*/

SELECT student_id, surname 
FROM students
WHERE surname='Fisher' -- where odwo³uje siê do istniej¹cego rekordu a nie nazwanego przez AS?

--11.04 (SARG) SearchARGument

/*Zapytanie zwracaj¹ce module_name oraz lecturer_id z tabeli modules z tych rekordów, 
dla których lecturer_id jest równy 8 lub NULL. 
Zapytanie napisz dwoma sposobami – raz wykorzystuj¹c funkcjê COALESCE (³¹czyæ)
(jako drugi parametr przyjmij 0) raz tak, aby predykat(w³aœciwoœæ) podany w warunku WHERE by³ SARG. 9 rekordów*/

select lecturer_id, module_name from modules
where lecturer_id = 8 or lecturer_id is null

-- coalesce 

select lecturer_id, module_name from modules
where coalesce(lecturer_id,0) = 0 or lecturer_id = 8

--coalesce2

select lecturer_id, module_name from modules
where lecturer_id = 8 or coalesce(lecturer_id, 0) = 0 -- doesnt work if we put something like (lecturer_id, 50) lol

--other example

select coalesce(lecturer_id, 69420) as lecturer_id, module_name from modules -- maybe cuz here coalesce is with select
where lecturer_id = 8 or lecturer_id is null

--11.05

/*Wykorzystaj funkcjê CAST i TRY_CAST jako parametr instrukcji SELECT próbuj¹c zamieniæ tekst ABC
na liczbê typu INT. Skomentuj otrzymane wyniki.*/

select cast('ABC' AS int) -- b³¹d
SELECT TRY_CAST('ABC' AS int) -- null

--11.06
--Napisz trzy razy instrukcjê SELECT wykorzystuj¹c funkcjê CONVERT zamieniaj¹c¹ dzisiejsz¹ datê na tekst. 
--Jako ostatni parametr funkcji CONVERT podaj 101, 102 oraz 103. Skomentuj otrzymane wyniki.

select CONVERT(varchar(30), getdate(), 101)
select CONVERT(varchar(30), getdate(), 102)
select CONVERT(varchar(30), getdate(), 103) -- this one

-- 11.07 (LIKE)
--Napisz zapytania z u¿yciem operatora LIKE wybieraj¹ce nazwy grup (wielkoœæ liter jest nieistotna):

--a)zaczynaj¹ce siê na DM 6 rekordów

select * from groups where group_no like 'dm%' -- start with dm

--b)niemaj¹ce w nazwie ci¹gu '10' 15 rekordów

select * from groups where group_no not like '%10%'

--c)których drugim znakiem jest M 9 rekordów

select * from groups where group_no like '_m%' -- end with m

--d)których przedostatnim znakiem jest 0 (zero) 11 rekordów

select * from groups where group_no like '%0_'

--e)których ostatnim znakiem jest 1 lub 2 12 rekordów

select * from groups where group_no like '%1' or group_no like '%2'
select * from groups where group_no like '%[12]'

--f)których pierwszym znakiem nie jest litera D 8 rekordów

select * from groups where group_no not like 'd%'
select * from groups where group_no like'[^D]%'

--g)których drugim znakiem jest dowolna litera z zakresu A-P 10 rekordów

select * from groups where group_no like '_[a-p]%'

--11.08 (LIKE i COLLATE) 
--Napisz zapytania z u¿yciem operatora LIKE i/lub klauzuli COLLATE (zestawiæ, porównaæ):

--a)wybieraj¹ce nazwy wyk³adów, które w nazwie maj¹ literê o (wielkoœæ liter nie ma znaczenia) 19 rekordów

select * from modules where module_name like '%o%'

--b)wybieraj¹ce nazwy wyk³adów, które w nazwie maj¹ du¿¹ literê O 1 rekord, Operational systems

select * from modules where module_name like '%O%' collate polish_cs_as -- case sensitive

--c)wybieraj¹ce nazwy grup, które w nazwie maj¹ trzeci¹ literê i (wielkoœæ liter nie ma znaczenia) 16 rekordów

select * from groups where group_no like '__i%'

--d)wybieraj¹ce nazwy grup, które w nazwie maj¹ trzeci¹ literê ma³e i 4 rekordy

select * from groups where group_no like '__i%' collate polish_cs_as

/*11.09 (COLLATE)

Instrukcj¹ CREATE utwórz tabelê #tmp (jeœli stworzymy tabelê, której nazwa bêdzie poprzedzona znakiem #,
tabela zostanie automatycznie usuniêta po zamkniêciu sesji) sk³adaj¹c¹ siê z pól:

id int primary key
nazwisko varchar(30) collate polish_cs_as

Jedn¹ instrukcj¹ INSERT wprowadŸ do tabeli #tmp nastêpuj¹ce rekordy (zwracaj¹c uwagê na wielkoœæ liter):
1	Kowalski
2	kowalski
3	KoWaLsKi
4	KOWALSKI

a)	Wybierz z tabeli #tmp rekordy, które w polu nazwisko maj¹ (wielkoœæ liter jest istotna):
pierwsz¹ literê du¿e K 3 rekordy, napis Kowalski 1 rekord, drug¹ literê od koñca du¿e K 2 rekordy*/

create table #tmp( 
id int primary key,
nazwisko varchar(30) collate polish_cs_as)

insert into #tmp(id, nazwisko)
values
(1, 'Kowalski'),
(2, 'kowalski'),
(3, 'KoWaLsKi'),
(4, 'KOWALSKI')

select * from #tmp where nazwisko like 'K%'
select * from #tmp where nazwisko like '%K_'

/*b)Wyœwietl rekordy, które w polu nazwisko maj¹ (wielkoœæ liter jest nieistotna):
napis kowalski 4 rekordy, drug¹ literê o 4 rekordy
Odpowiedz na pytanie, w którym przypadku, a) czy b), u¿ycie klauzuli COLLATE by³o konieczne i dlaczego.*/

select * from #tmp where nazwisko = 'kowalski' collate polish_ci_as
select * from #tmp where nazwisko like '_o%' collate polish_ci_as 

/*11.10

Napisz zapytanie:
SELECT DISTINCT surname
FROM students
ORDER BY group_no
Wyjaœnij na czym polega b³¹d i skoryguj zapytanie tak, aby zwraca³o nazwiska studentów z tabeli students
posortowane wed³ug numeru grupy. 35 rekordów */

SELECT surname -- without distinct
FROM students
ORDER BY group_no

/*11.11 (TOP)

--a)Napisz zapytanie wybieraj¹ce 5 pierwszych rekordów z tabeli student_grades, które w polu exam_date 
maj¹ najdawniejsze daty 5 rekordów*/

select * from student_grades
select top(5) * from student_grades 
order by exam_date asc

--b)Skoryguj zapytanie z punktu a) dodaj¹c klauzulê WITH TIES. Skomentuj otrzymany wynik. 6 rekordów

select top(5) with ties * from student_grades 
order by exam_date asc
-- with ties allows double returns

--11.12 (TOP, OFFSET)

--a)SprawdŸ, ile rekordów jest w tabeli student_grades

select * from student_grades

--b)Wybierz 20% pocz¹tkowych rekordów z tabeli student_grades. Posortuj wynik wed³ug exam_date. 
--SprawdŸ, ile rekordów zosta³o zwróconych i wyjaœnij dlaczego. 12 rekordów

select top (20) percent * from student_grades order by exam_date asc

--c)Pomiñ pierwszych 6 rekordów i wybierz kolejnych 10 rekordów z tabeli student_grades. 
--Posortuj wynik wed³ug exam_date. pierwszy rekord: student_id=6 i module_id=4

select * from student_grades 
order by exam_date asc 
offset 6 rows 
fetch next 10 rows only -- offset(bootstrap) after orderby

--d)Wybierz wszystkie rekordy z tabeli student_grades z pominiêciem pierwszych 20 
--(sortowanie wed³ug exam_date). 38 rekordów

select * from student_grades order by exam_date asc offset 20 rows

--11.13 (INTERSECT, UNION, EXCEPT)

--a)Wszystkie nazwiska z tabel students i employees (ka¿de ma siê pojawiæ tylko raz) 
--posortowane wed³ug nazwisk 40 rekordów

select surname from students 
union -- union like distinct
select surname from employees 
order by surname desc 

--b)Wszystkie nazwiska z tabel students i employees (ka¿de ma siê pojawiæ tyle razy ile razy wystêpuje w tabelach) 
--posortowane wed³ug nazwisk 77 rekordów

select surname from students 
union all -- without distinct
select surname from employees order by surname desc

--c)Te nazwiska z tabeli students, które nie wystêpuj¹ w tabeli employees 21 rekordów

select surname from students 
except -- z wy³¹czeniem
select surname from employees order by surname -- asc by default

--d)Te nazwiska z tabeli students, które wystêpuj¹ tak¿e w tabeli employees 1 rekord – nazwisko Craven

select surname from students 
intersect -- ³¹czenie cech wspolncyh
select surname from employees order by surname desc

-- e)Informacjê, pracownicy których katedr (departments) nie s¹ przypisani jako potencjalni prowadz¹cy 
--do ¿adnego wyk³adu (u¿yj operatora EXCEPT) 1 rekord – Department of Foreign Affairs

select department from lecturers except select department from modules -- lecturers ktorych nie ma w modules

--f)Informacjê, pracownicy których katedr s¹ przypisani jako potencjalni prowadz¹cy wyk³ady, których nazwa 
-- zaczyna  siê na M 2 rekordy, Department of Economics and Department of Mathematics

select department from lecturers intersect select department from modules where module_name like 'm%'  

--g)Te pary id_studenta, id_wykladu z tabeli student_grades, którym nie zosta³a przyznana 
--dotychczas ¿adna ocena 45 rekordów

select student_id, module_id from students_modules 
except 
select student_id, module_id from student_grades

--h)Identyfikatory studentów, którzy zapisali siê zarówno na wyk³ad o identyfikatorze 3 jak i 12
--Trzech studentów o identyfikatorach 9, 14 i 18

select student_id from students_modules
where module_id = 3
intersect -- to ta sama tabela, wiec laczymy czesc wspolna
select student_id from students_modules
where module_id = 12

/*i)Nazwiska i imiona studentów wraz z numerami grup, zapisanych do grup o nazwach zaczynaj¹cych siê 
na DMIe oraz nazwiska i imiona wyk³adowców wraz z nazwami katedr, w których pracuj¹. 
Ostatnia kolumna ma mieæ nazwê group_department. Dane posortowane rosn¹co wed³ug ostatniej kolumny.
Wskazówka: W zapytaniu wybieraj¹cym dane o wyk³adowcach nale¿y u¿yæ z³¹czenia 37 rekordów*/

select first_name, surname, group_no as group_department from students where group_no like 'dmie%'
union
select surname, first_name, department from employees e
inner join lecturers l
on e.employee_id=l.lecturer_id
order by group_department 

-- without inner join

select first_name, surname from students where group_no like 'dmie%'
union
select surname, first_name from employees 





