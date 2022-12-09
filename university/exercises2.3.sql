/*23/1.01
Liczba studentów zarejestrowanych w bazie danych.
Zapytanie zwraca liczbê 35*/

select COUNT(*) from students

/*23/1.02
Liczba studentów, którzy s¹ przypisani do jakiejœ grupy.
Zapytanie zwraca liczbê 28*/

select COUNT(group_no) from students

/*23/1.03
Liczba studentów, którzy nie s¹ przypisani do ¿adnej grupy.
Zapytanie zwraca liczbê 7*/

select COUNT(*) from students
where group_no is null

/*23/1.04
Liczba grup, do których jest przypisany co najmniej jeden student.
Takich grup jest 12*/

select COUNT(distinct group_no) from students

/*23/1.05
Nazwy grup, do których zapisany jest przynajmniej jeden student wraz z liczb¹ zapisanych studentów. Zapytanie ma zwróciæ tak¿e informacjê,
ilu studentów nie jest zapisanych do ¿adnej grupy. Kolumna zwracaj¹ca liczbê studentów ma mieæ nazwê no_of_students. Dane posortowane 
rosn¹co wed³ug liczby studentów. 13 rekordów w piêciu grupach jest po jednym studencie, w czterech po dwóch,
w jednej czterech, w jednej piêciu, w jednej szeœciu i w jednej siedmiu*/

select distinct group_no, COUNT(*) as no_of_students from students -- domyslnie chyba wlasnie student_id liczy, klucz glowny
group by group_no -- bez tego blad lol
order by no_of_students

/*23/1.06
Nazwy grup, do których zapisanych jest przynajmniej trzech studentów wraz z liczb¹ tych studentów.
Kolumna zwracaj¹ca liczbê studentów ma mieæ nazwê no_of_students. Dane posortowane rosn¹co wed³ug liczby studentów. 4 rekordy*/

select distinct group_no, COUNT(*) as no_of_students from students
group by group_no
having count(*) >= 3

/*23/1.07
Wszystkie mo¿liwe oceny oraz ile razy ka¿da z ocen zosta³a przyznana (kolumna ma mieæ nazwê no_of_grades). Dane posortowane wed³ug ocen.
8 rekordów. Ocena 2.0 zosta³a przyznane 13 razy. Ocena 5.5 4 razy. Ocena 6.0 nie zosta³a przyznana ani raz.*/

select grade, COUNT(*) as no_of_grades from student_grades
group by grade

/*23/1.08
Nazwy wszystkich katedr oraz ile godzin wyk³adów w sumie maj¹ pracownicy zatrudnieni w  tych katedrach. 
Kolumna zwracaj¹ca liczbê godzin ma mieæ nazwê total_hours. Dane posortowane rosn¹co wed³ug kolumny total_hours.
11 rekordówDla pierwszych szeœciu total_hours jest NULLOstatni rekord: Department of Informatics, 117 godzin*/

select d.department, SUM(no_of_hours) total_hours from departments d -- z departments poniewaz WSZYSTKICH
left join lecturers l on d.department=l.department -- dlatego tez left join
left join modules m on l.lecturer_id=m.lecturer_id
group by d.department
order by total_hours

select * from modules

/*23/1.09
Nazwisko ka¿dego wyk³adowcy wraz z liczb¹ prowadzonych przez niego wyk³adów (zapytanie ma zwróciæ tak¿e nazwiska wyk³adowców, którzy 
nie prowadz¹ ¿adnego wyk³adu). Kolumna zawieraj¹ca liczbê wyk³adów ma mieæ nazwê no_of_modules. Dane posortowane malej¹co wed³ug nazwiska.
28 rekordów. Pierwszy: Wright, nie prowadzi ¿adnego wyk³adu. Trzeci: White, prowadzi jeden wyk³ad.*/

select l.lecturer_id ,surname, COUNT(module_id) no_of_modules from lecturers l
left join employees e on l.lecturer_id=e.employee_id
left join modules m on l.lecturer_id=m.lecturer_id
group by surname, l.lecturer_id
order by surname desc

/*23/1.10
Nazwiska i imiona wyk³adowców prowadz¹cych co najmniej dwa wyk³ady wraz z liczb¹ prowadzonych przez nich wyk³adów.
Dane posortowane malej¹co wed³ug liczby wyk³adów a nastêpnie rosn¹co wed³ug nazwiska.
6 rekordów. Pierwszy: Harry Jones, 4 wyk³ady Ostatni: Lily Taylor, 2 wyk³ady*/

select surname, first_name, lecturers.lecturer_id, COUNT(module_id) no_of_modules from lecturers
left join employees on employee_id=lecturer_id
left join modules on modules.lecturer_id=lecturers.lecturer_id
group by surname, first_name, lecturers.lecturer_id
having COUNT(module_id)>=2
order by no_of_modules desc, surname 

--or

SELECT surname, first_name, count(*) AS no_of_modules
FROM modules INNER JOIN employees ON lecturer_id=employee_id
GROUP BY employee_id, surname, first_name
HAVING count(*)>=2
ORDER BY no_of_modules DESC, surname

/*23/1.11a
Nazwiska i imiona wszystkich studentów o nazwisku Bowen, którzy otrzymali przynajmniej jedn¹ ocenê wraz ze œredni¹ ocen 
(ka¿dego Bowena z osobna). Kolumna zwracaj¹ca œredni¹ ma mieæ nazwê avg_grade. Dane posortowane malej¹co wed³ug nazwisk i 
malej¹co wed³ug imion. Dwa rekordy:  Harry Bowen, œrednia 3.7 Charlie Bowen, œrednia 2.0*/

select first_name, surname, AVG(grade) as avg_grade from students s
join student_grades sg on s.student_id=sg.student_id
where surname = 'Bowen'
group by first_name, surname
order by surname desc, first_name desc

/*23/1.11b
Na podstawie powy¿szego zapytania utwórz funkcjê o nazwie avg_grade, która zwróci dane o studentach, których nazwisko zostanie podane 
jako parametr. Pamiêtaj, ¿e w funkcji nie wolno u¿ywaæ klauzuli ORDER BY.*/

create or alter function avg_grade
(@surname as varchar(50))
returns table as return
select s.student_id, first_name, surname, group_no, AVG(grade) avg_grade from students s
join student_grades sg on s.student_id=sg.student_id
where surname = @surname
group by s.student_id, first_name, surname, group_no

SELECT * FROM avg_grade('Fisher') --zwraca jeden rekord: Katie Fisher, œrednia 4.1666

/*23/1.12a
Napisz funkcjê o nazwie student_no, która zwróci liczbê studentów zapisanych na wyk³ad o nazwie podanej jako parametr. 
Spraw, aby w parametrze usuniête zosta³y wszystkie wiod¹ce i koñcowe spacje.*/

create or alter function student_no
(@module as varchar(50))
returns table as return 
select COUNT(student_id) student_no from modules m
join students_modules sm on m.module_id=sm.module_id 
where module_name=@module


SELECT * FROM student_no('Databases') -- z ewentualnymi spacjami na pocz¹tku i koñcu --zwraca liczbê 2
SELECT * FROM student_no('Statistics') --zwraca liczbê 4
SELECT * FROM student_no('Macroeconomics') --zwraca liczbê 0

/*23/1.12b
Zmodyfikuj poprzedni¹ funkcjê, aby zwraca³a nazwy wyk³adów wraz z liczb¹ studentów zapisanych na ka¿dy z wyk³adów o nazwie 
zaczynaj¹cej siê tekstem podanym jako parametr. Jeœli jako parametr zostanie podana wartoœæ NULL, funkcja ma zwróciæ tabelê pust¹.
Wskazówka: w klauzuli WHERE u¿yj operatora +
Na wyk³ad Computer network devices zapisanych jest 9 studentów.
Na Contemporary history 2 studentów.*/

create or alter function student_no
(@module as varchar(50))
returns table as return 
select module_name, COUNT(student_id) student_no from modules m
join students_modules sm on m.module_id=sm.module_id 
where module_name like @module + '%'
group by module_name

SELECT * FROM student_no(NULL) --zwraca tabelê pust¹
SELECT * FROM student_no('C') --Zwraca 5 rekordów. 

/*23/1.12c
Zmodyfikuj poprzedni¹ funkcjê, aby dla parametru NULL funkcja zwraca³a dane o wszystkich wyk³adach.
Wskazówka: w klauzuli WHERE u¿yj funkcji CONCAT*/

create or alter function student_no
(@module as varchar(50))
returns table as return 
select module_name, COUNT(student_id) student_no from modules m
left join students_modules sm on m.module_id=sm.module_id 
where module_name like concat(@module, '%')
group by module_name

SELECT * FROM student_no(NULL) -- zwraca 26 rekordów na cztery wyk³ady nie zapisa³ siê ¿aden student
SELECT * FROM student_no('Macroeconomics') -- zwraca 1 rekord: Marcroeconomics, 0 studentów

/*23/1.13
Nazwiska i imiona wyk³adowców, którzy prowadz¹ co najmniej jeden wyk³ad wraz ze œredni¹ ocen jakie dali studentom 
(jeœli wyk³adowca nie da³ do tej pory ¿adnej oceny, tak¿e ma siê pojawiæ na liœcie). Kolumna zwracaj¹ca œredni¹ ma mieæ
nazwê avg_grade. Dane posortowane malej¹co wed³ug œredniej.
11 rekordów. Pierwszy rekord: James Robinson, œrednia 5.0. Jeden wyk³adowca nie wystawi³ ¿adnej oceny.*/

select surname, first_name, avg(grade) avg_grade from lecturers l
join employees e on l.lecturer_id=e.employee_id
join modules m on l.lecturer_id=m.lecturer_id
left join student_grades sg on m.module_id=sg.module_id
group by l.lecturer_id, surname, first_name -- po dodaniu l.lecturer_id, przybyl rekord. TRZEBA PRZY JOINACH DOPISYWAC TAK¯E DOLACZONE ID
order by avg_grade desc

/*23/1.14a
Nazwy wyk³adów oraz kwotê, jak¹ uczelnia musi przygotowaæ na wyp³aty pracownikom prowadz¹cym wyk³ady ze Statistics i Economics (osobno).
Jeœli jest wiele wyk³adów o nazwie Statistics lub Economics, suma dla nich ma byæ obliczona ³¹cznie. Zapytanie ma wiêc zwróciæ 
dwa rekordy (jeden dla wyk³adów ze Statistics, drugi dla Economics).
Kwotê za jeden wyk³ad nale¿y obliczyæ jako iloczyn stawki godzinowej prowadz¹cego wyk³adowcy oraz liczby godzin przeznaczonych na wyk³ad.
Zapytanie zwraca jeden rekord: Economics 1200.00
Odpowiedz na pytanie, dlaczego zapytanie nie zwróci³o danych o wyk³adzie Statistics.*/

SELECT module_name, SUM(overtime_rate * no_of_hours) sum_of_money FROM acad_positions ap 
JOIN lecturers l ON ap.acad_position=l.acad_position
JOIN modules m ON m.lecturer_id=l.lecturer_id
WHERE module_name in ('Statistics','Economics')
GROUP BY module_name


/*23/1.14b
Zapytanie zwracaj¹ce jedn¹ liczbê: kwotê, jak¹ uczelnia musi przygotowaæ na wyp³aty z tytu³u prowadzonych wyk³adów. 
Kwotê za jeden wyk³ad nale¿y wyliczyæ jako iloczyn stawki godzinowej prowadz¹cego wyk³adowcy oraz liczby godzin przeznaczonych 
na ten wyk³ad. Pamiêtaj, aby nazwaæ kolumnê zwracaj¹c¹ szukan¹ kwotê.
Odpowiedz na pytanie: czy mo¿liwe jest wyliczenie pe³nej kwoty nale¿noœci z tytu³u przeprowadzonych wyk³adów? Uzasadnij odpowiedŸ.
Wynikiem jest kwota 20265.00*/

SELECT SUM(overtime_rate * no_of_hours) sum_of_money FROM acad_positions ap 
JOIN lecturers l ON ap.acad_position=l.acad_position
JOIN modules m ON m.lecturer_id=l.lecturer_id

/*23/1.14c
Kwotê, jak¹ uczelnia musi przygotowaæ na wyp³aty z tytu³u prowadzenia wyk³adów, którym nie jest przypisany ¿aden wyk³adowca, 
przy za³o¿eniu, ¿e za godzinê takiego wyk³adu nale¿y zap³aciæ œredni¹ z pola overtime_rate w tabeli acad_positions.
Wskazówka: wykorzystaj CTE. Wynik CTE, którym bêdzie obliczona œrednia, po³¹cz iloczynem kartezjañskim z tabel¹ modules.
7649.99*/

with cte as
(select avg(overtime_rate) avg_or FROM acad_positions)
select SUM(no_of_hours*avg_or)
from modules cross join cte
where lecturer_id is null

/*23/1.14d
Maksymaln¹ kwotê, jak¹ uczelnia musi przygotowaæ na wyp³aty z tytu³u prowadzenia wyk³adów, dla których nie mo¿na tej kwoty obliczyæ.
S¹ to wyk³ady, którym nie jest przypisany ¿aden wyk³adowca lub wyk³adowca jest przypisany, ale nieznany jest jego stopieñ/tytu³ naukowy.
13200*/

with maksimum as
(select max(overtime_rate) avg_or from acad_positions)
select sum(no_of_hours*avg_or) from modules m 
left join lecturers l on m.lecturer_id=l.lecturer_id
cross join maksimum
where m.lecturer_id is null or acad_position is null

/*23/1.15
Nazwiska i imiona wyk³adowców wraz z sumaryczn¹ liczb¹ godzin wyk³adów prowadzonych przez ka¿dego z nich z osobna ale tylko w przypadku, 
gdy suma godzin prowadzonych wyk³adów jest wiêksza od 30. Kolumna zwracaj¹ca liczbê godzin ma mieæ nazwê no_of_hours. 
Dane posortowane malej¹co wed³ug liczby godzin. 5 rekordów.  Pierwszy: Jones Harry, 72 godziny. Ostatni: Katie Davies 55 godzin.*/

select surname, first_name, SUM(no_of_hours) no_of_hours from lecturers l
join employees e on l.lecturer_id=e.employee_id
join modules m on l.lecturer_id=m.lecturer_id
group by surname, first_name, l.lecturer_id
having SUM(no_of_hours)> 30
order by no_of_hours desc

/*23/1.16
Nazwy wszystkich grup oraz liczbê studentów zapisanych do ka¿dej grupy (kolumna ma mieæ nazwê no_of_students). 
Dane posortowane rosn¹co wed³ug liczby studentów a nastêpnie numeru grupy. 23 rekordy.
Do 11 grup nie zosta³ zapisany ¿aden student. Ostatni rekord: grupa DMIe1011, 6 studentów*/

select g.group_no, COUNT(student_id) as no_of_students from groups g
left join students s on g.group_no=s.group_no 
group by g.group_no
order by no_of_students, group_no

/*23/1.17
Nazwy wszystkich wyk³adów, których nazwa zaczyna siê liter¹ A oraz œredni¹ ocen ze wszystkich tych wyk³adów osobno 
(jeœli jest wiele takich wyk³adów, to œrednia ma byæ obliczona dla ka¿dego z nich oddzielnie). Jeœli z danego wyk³adu nie ma
¿adnej oceny, tak¿e powinien on pojawiæ siê na liœcie. Kolumna ma mieæ nazwê average. 3 rekordy:
Advanced databases NULL Advanced statistics 4.25 Ancient history 4.25*/

select distinct module_name, AVG(grade) average from modules m
left join student_grades sg on m.module_id=sg.module_id
where module_name like 'A%'
group by module_name

/*23/1.18
Nazwy grup, do których jest zapisanych co najmniej dwóch studentów, liczba studentów zapisanych do tych grup 
(kolumna ma mieæ nazwê no_of_students) oraz œrednie ocen dla ka¿dej grupy (kolumna ma mieæ nazwê average_grade).
Dane posortowane malej¹co wed³ug œredniej. 8 rekordów.
Pierwszy: ZMIe2012, liczba studentów 5, œrednia 6.6 Ostatni: DMIe1014, liczba studentów 2, œrednia 3.25*/


SELECT group_no, COUNT(s.student_id) AS no_of_students, 
AVG(grade) AS average_grade FROM students s INNER JOIN student_grades sg 
ON s.student_id=sg.student_id
GROUP BY group_no
HAVING COUNT(s.student_id) >= 2
ORDER BY average_grade DESC
