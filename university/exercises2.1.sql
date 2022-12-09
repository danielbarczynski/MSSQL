/*21.01
Identyfikatory i nazwy wyk³adów, na które nie zosta³ zapisany ¿aden student. Dane posortowane malej¹co 
wed³ug nazw wyk³adów. U¿yj sk³adni podzapytania. 4 rekordy, studenci o identyfikatorach 26, 25, 24 i 23 (w podanej kolejnoœci)*/

select * from modules
where module_id not in
(select module_id from students_modules)
order by module_id desc -- wyklady na ktore nikt sie nie zapisal

/*21.02
Identyfikatory studentów, którzy przyst¹pili do egzaminu zarówno 2018-03-22 jak i 2018 09 30. Dane posortowane malej¹co wed³ug identyfikatorów. 
Napisz dwie wersje tego zapytania: raz u¿ywaj¹c sk³adni podzapytania, drugi raz operatora INTERSECT.
Studenci o identyfikatorach 18 i 2 (w podanej kolejnoœci)*/

select student_id from student_grades
where exam_date = '20180322' and student_id in
(select student_id from student_grades
where exam_date = '20180930')
order by student_id desc

--INTERSECT:

select student_id from student_grades
where exam_date = '2018-03-22' 
intersect
select student_id from student_grades
where exam_date = '2018-09-30'
order by student_id desc

/*21.03
Identyfikatory, nazwiska, imiona i numery grup studentów, którzy zapisali siê zarówno na wyk³ad o identyfikatorze 2 jak i 4. 
Dane posortowane malej¹co wed³ug nazwisk. U¿yj sk³adni podzapytania a w zapytaniu zewnêtrznym tak¿e z³¹czenia.
3 rekordy, studenci o identyfikatorach 16, 3, 20 (w podanej kolejnoœci)*/

select s.student_id, first_name, surname, group_no from students s
inner join students_modules sm on sm.student_id=s.student_id -- gdy bylo module id na student id, wyskakiwaly te same student id tylko ze z jednym gosciem
where module_id = 2 and s.student_id in
(select sm.student_id from students_modules sm
where module_id = 4)
order by surname desc

/*21.04
Identyfikatory, nazwiska i imiona studentów, którzy zapisali siê na wyk³ad z matematyki (Mathematics) ale nie zapisali siê 
na wyk³ad ze statystyki (Statistics). Zapytanie napisz korzystaj¹c ze sk³adni podzapytania, wed³ug nastêpuj¹cego algorytmu:
•	najbardziej wewnêtrznym zapytaniem wybierz identyfikatory studentów, którzy zapisali siê na wyk³ad ze statystyki 
(tu potrzebne bêdzie z³¹czenie),
•	kolejnym zapytaniem wybierz identyfikatory studentów, którzy zapisali siê na wyk³ad z matematyki (tak¿e potrzebne bêdzie z³¹czenie) 
oraz nie zapisali si¹ na wyk³ad ze statystyki (ich identyfikatory nie nale¿¹ do zbioru zwróconego przez poprzednie zapytanie),
•	zewnêtrznym zapytaniem wybierz dane o studentach, których identyfikatory nale¿¹ do zbioru zwróconego przez zapytanie œrodkowe.
5 rekordów, studenci o identyfikatorach 3, 6, 16, 20, 33*/

select * from students
where student_id in
(select student_id
from students_modules sm inner join modules m on m.module_id=sm.module_id
where module_name = 'mathematics' and student_id not in
(select student_id
from students_modules sm inner join modules m on m.module_id=sm.module_id
where module_name = 'statistics'))


/*21.05
Imiona, nazwiska i numery grup studentów z grup, których nazwa zaczyna siê na DMIe i koñczy cyfr¹ 1 i którzy nie s¹ zapisani na wyk³ad„Ancient history”. 
U¿yj sk³adni zapytania negatywnego a w zapytaniu wewnêtrznym tak¿e z³¹czenia.
3 rekordy (studenci z grupy DMIe1011 o nazwiskach Hunt, Holmes i Lancaster)*/

SELECT first_name, surname, group_no
FROM students 
WHERE group_no LIKE 'DMIe%1' AND student_id NOT IN 
(SELECT student_id FROM students_modules sm 
INNER JOIN modules m ON sm.module_id=m.module_id
 WHERE module_name='Ancient history')

/*21.06
Nazwy wyk³adów o najmniejszej liczbie godzin. Zapytanie, oprócz nazw wyk³adów, ma zwróciæ tak¿e liczbê godzin.
U¿yj operatora ALL.
Jeden wyk³ad: Advanced Statistics, 9 godzin*/

select module_name, no_of_hours from modules
where no_of_hours = 
(select MIN(no_of_hours)
from modules)

--ALL:

select module_name, no_of_hours from modules
where no_of_hours <= all  -- bez znaku "=" w ogole nie dziala, po all/any/some nastepuje subquery
(select no_of_hours from modules)

/*21.07
Identyfikatory i nazwiska studentów, którzy otrzymali ocenê wy¿sz¹ od najni¿szej. Dane ka¿dego studenta maj¹ 
siê pojawiæ tyle razy, ile takich ocen otrzyma³. U¿yj operatora ANY. W zapytaniu nie wolno pos³ugiwaæ siê 
liczbami oznaczaj¹cymi oceny 2, 3, itd.) ani funkcjami agreguj¹cymi (MIN, MAX).45 rekordów
SprawdŸ, czy liczba rekordów zwróconych przez zapytanie jest poprawna, wykonuj¹c odpowiednie 
zapytanie do tabeli student_grades (wybieraj¹ce rekordy, w których ocena jest wy¿sza ni¿ 2).*/

select s.student_id, surname from students s
inner join student_grades sg on s.student_id=sg.student_id 
where grade > any
(select grade from student_grades)

/*21.08
Napisz jedno zapytanie, które zwróci dane o najm³odszych i najstarszych studentach (do po³¹czenia tych danych 
u¿yj jednego z operatorów typu SET). W zapytaniu nie wolno u¿ywaæ funkcji agreguj¹cych (MIN, MAX).
Uwaga: nale¿y uwzglêdniæ fakt, ¿e data urodzenia w tabeli students mo¿e byæ NULL, do porównania nale¿y wiêc 
wybraæ rekordy, które w polu date_of_birth maj¹ wpisane daty. Najstarszym studentem jest Melissa Hunt urodzona 
1978-10-18 Najm³odszym studentem jest Layla Owen urodzona 2001-06-20. Napisz zapytanie do tabeli students i sprawdŸ,
czy otrzymane dane o najm³odszych i najstarszych studentach s¹ poprawne.*/

select * from students
where date_of_birth <= all
(select date_of_birth from students where date_of_birth is not null)
union
select * from students
where date_of_birth >= all
(select date_of_birth from students where date_of_birth is not null)

/*21.09a
Identyfikatory, imiona i nazwiska studentów z grupy DMIe1011, którzy otrzymali oceny z egzaminu wczeœniej, ni¿
wszyscy pozostali studenci z innych grup (nie uwzglêdniamy studentów, którzy nie s¹ zapisani do ¿adnej grupy).
Dane ka¿dego studenta maj¹ siê pojawiæ tylko raz. U¿yj z³¹czenia i operatora ALL. 3 rekordy, studenci o 
identyfikatorach 1, 3 i 6*/

select distinct s.student_id, first_name, surname, group_no from students s
inner join student_grades sg on s.student_id=sg.student_id
where group_no = 'DMIe1011' and exam_date < all
(select exam_date from students s
inner join student_grades sg on s.student_id=sg.student_id
where group_no <> 'DMIe1011')

/*21.09b
Jak wy¿ej, ale tym razem nale¿y uwzglêdniæ studentów, którzy nie s¹ zapisani do ¿adnej grupy. 
Wynikiem jest tabela pusta
Odpowiedz na pytanie, jaki jest identyfikator studenta, który spowodowa³, ¿e wynikiem jest tabela pusta.*/

select distinct s.student_id, first_name, surname, group_no, exam_date from students s
inner join student_grades sg on s.student_id=sg.student_id
where group_no = null and exam_date <= all
(select exam_date from student_grades)

-- wyjasnienie dlaczego:

select distinct s.student_id, first_name, surname, group_no, exam_date from students s
inner join student_grades sg on s.student_id=sg.student_id
where group_no is null and exam_date <= all
(select exam_date from student_grades)

/*21.10
Nazwy wyk³adów, którym przypisano najwiêksz¹ liczbê godzin (wraz z liczb¹ godzin).
Wykorzystaj sk³adniê podzapytania z operatorem =. W zapytaniu wewnêtrznym u¿yj funkcji MAX.
Jeden rekord: Econometrics, 45 godzin*/

select module_name, no_of_hours from modules
where no_of_hours >= all
(select no_of_hours from modules)

-- max:

select module_name, no_of_hours from modules
where no_of_hours =
(select MAX (no_of_hours) from modules)

/*21.11
Nazwy wyk³adów, którym przypisano liczbê godzin wiêksz¹ od najmniejszej. 
U¿yj funkcji MIN i sk³adni podzapytania z operatorem >.
25 rekordów*/

select module_name from modules
where no_of_hours >
(select MIN(no_of_hours) from modules)

/*21.12a
Wszystkie dane o najm³odszym studencie z ka¿dej grupy. 
U¿yj fujnkcji MIN i sk³adni podzapytania skorelowanego z operatorem =.
11 rekordów, np. w grupie DMIe1013 najm³odszy jest Elliot Fisher, ur. 1998-07-19*/

select * from students s1
where date_of_birth =
(select min(date_of_birth) from students s2 where s1.group_no=s2.group_no)

/*21.12b
Wszystkie numery grup z tabeli students posortowane wed³ug numerów grup. Ka¿da grupa ma siê pojawiæ jeden raz.
Zapytanie zwróci³o 13 rekordów. Poniewa¿ jedn¹ z wartoœci jest NULL, wiêc studenci s¹ przypisani do 12 ró¿nych grup.
Poprzednie zapytanie, zwracaj¹ce dane o najm³odszym studencie z ka¿dej grupy, zwróci³o 11 rekordów. ZnajdŸ przyczynê 
tej ró¿nicy.*/

select distinct group_no from students
order by group_no

/*21.13
Identyfikatory, nazwiska i imiona studentów, którzy otrzymali ocenê 5.0. Nazwisko ka¿dego studenta ma siê pojawiæ 
jeden raz.  U¿yj operatora EXISTS. 6 studentów o identyfikatorach 1, 2, 14, 18, 19, 21
Napisz zapytanie: SELECT * FROM student_grades where grade=5 i sprawdŸ otrzymany wynik.*/

select distinct surname, s.student_id, first_name from students s
left join student_grades sg on s.student_id=sg.student_id
where grade = 5

-- exist:

select distinct surname, s.student_id, first_name from students s
where exists
(select grade from student_grades sg where s.student_id=sg.student_id and grade = 5) -- musi byc dolaczenie (bez joina)

SELECT * FROM student_grades where grade=5


/*21.14a
Wszystkie dane o wyk³adach, w których uczestnictwo wymaga wczeœniejszego uczestnictwa w wyk³adzie o identyfikatorze 3. 
U¿yj operatora EXISTS.
Trzy wyk³ady o identyfikatorach 10, 16 i 25*/

-- wystarczyloby...

select * from modules where
preceding_module = 3

select * from modules m1
where exists
(select * from modules m2 where m1.module_id=m2.module_id and preceding_module = 3)

/*21.15a
Dane studentów z grupy DMIe1011 wraz z najwczeœniejsz¹ dat¹ planowanego dla nich egzaminu (pole planned_exam_date w tabeli students_modules). 
Zapytanie nie zwraca danych o studentach, którzy nie maj¹ wyznaczonej takiej daty. Sortowanie rosn¹ce wed³ug planned_exam_date a nastêpnie
student_id. U¿yj operatora APPLY.
Uwaga: nale¿y uwzglêdniæ fakt, ¿e data planowanego egzaminu mo¿e byæ NULL.
3 rekordy, studenci o identyfikatorach 3, 29 i 1 (w takiej kolejnoœci)
Najwczeœniejsza planned_exam_date dla studenta o id=3 to 2018-03-21*/

select * from students s
cross apply
(select top(1) planned_exam_date from students_modules sm
where s.student_id=sm.student_id and planned_exam_date is not null
order by planned_exam_date) as t
where group_no = 'DMIe1011'
order by planned_exam_date, student_id

/*21.15b
Jak wy¿ej, tylko zapytanie ma zwróciæ najpóŸniejsz¹ datê planowanego egzaminu. Ponadto zapytanie ma tak¿e zwróciæ dane o studentach, 
którzy nie maj¹ wyznaczonej takiej daty. Sortowanie rosn¹ce wed³ug planned_exam_date. U¿yj operatora APPLY.
6 rekordów, studenci o identyfikatorach 4, 6, 30 (dla których planned_exam_date jest NULL)
oraz 29, 3 i 1 (z istniej¹c¹ planned_exam_date). Najwczeœniejsza planned_exam_date dla studenta o id=3 to 2018-10-13*/

select * from students s
outer apply
(select top(1) planned_exam_date from students_modules sm
where s.student_id=sm.student_id and planned_exam_date is not null
order by planned_exam_date desc) as t
where group_no = 'DMIe1011'
order by planned_exam_date, student_id


/*21.16a
Identyfikatory i nazwiska studentów oraz dwie najlepsze oceny dla ka¿dego studenta wraz z datami ich przyznania. 
Zapytanie uwzglêdnia tylko studentów, którym zosta³a przyznana co najmniej jedna ocena. U¿yj operatora APPLY. 37 rekordów.
Ostatni rekord: 33, Bowen, 2.0, 2018-09-23 Np. w przypadku studentów o id=1, 2 i 3 zwrócone zosta³y po dwie oceny. 
W przypadku studenta o id=4 jedna ocena. Student o id=5 nie otrzyma³ ¿adnej oceny.*/

select * from students s -- bierzemy jednego studenta
cross apply -- dziala jak inner join, musi miec alias
--outer apply -- dziala jak outer join, wypisuje rowniez studentow ktorzy nie maja oceny
(select top (2) grade, exam_date from student_grades sg-- szukamy dla niego wszystkich ocen, zwraca tez exam_date, dziala inaczej niz subquery
where s.student_id=sg.student_id
order by grade desc)
as A

/*21.16b
Identyfikatory i nazwiska studentów oraz dwie najgorsze oceny dla ka¿dego studenta wraz z datami ich przyznania. 
Zapytanie uwzglêdnia tak¿e studentów, którym nie zosta³a przyznana ¿adna ocena. U¿yj operatora APPLY. 51 rekordów.
Pierwszy: 1, Bowen, 2.0, 2018-03-22 Ostatni: 35, Fisher, NULL, NULL
W kilku przypadkach (np. studenci o id: 5, 11, 13, 16) studenci nie otrzymali ¿adnej oceny.*/

select * from students s
outer apply
(select top(1) grade, exam_date from student_grades sg 
where s.student_id=sg.student_id order by grade) as app

/*21.17
Identyfikatory i nazwiska studentów oraz kwoty dwóch ostatnich wp³at za studia wraz z datami tych wp³at. 
Zapytanie uwzglêdnia tak¿e studentów, którzy nie dokonali ¿adnej wp³aty. U¿yj operatora APPLY. 54 rekordy.
Trzeci: 2, Palmer, 450.00, 2018-10-30. W kilku przypadkach (np. studenci o id: 9, 10, 20) studenci nie dokonali ¿adnej wp³aty.*/

select * from students s
outer apply
(select top(2) fee_amount, date_of_payment from tuition_fees tf
where s.student_id=tf.student_id
order by date_of_payment desc) as app


