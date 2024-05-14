create schema university

create table if not exists
university.faculty (id int primary key,
					name varchar(255),
					price numeric (9,2))

create table if not exists
university.course (id int primary key,
				   number int,
				   faculty_id int references university.faculty)

create table if not exists 
university.student_payment_type (name varchar(50) primary key)

create table if not exists
university.student (id int primary key,
					family_name varchar(255),
					name varchar(255),
					second_name varchar(255),					
					payment_type varchar(50) references university.student_payment_type,
					course_id int references university.course)

insert into
university.faculty values(1, 'Инженерный', 30000),
(2, 'Экономический', 49000)

insert into
university.course values(1, 1, 1),
(2, 1, 2),
(3, 4, 2)

insert into
university.student_payment_type values('бюджетник'),
('частник')

insert into
university.student values(1, 'Петров', 'Петр', 'Петрович', 'бюджетник', 1),
(2, 'Иванов', 'Иван', 'Иваныч', 'частник', 1),
(3, 'Михно', 'Сергей', 'Иваныч', 'бюджетник', 3),
(4, 'Стоцкая', 'Ирина', 'Юрьевна', 'частник', 3),
(5, 'Младич', 'Настасья', '', 'частник', 3)

-- 1. Вывести всех студентов, кто платит больше 30_000.
select stu.family_name || ' ' || stu.name || ' ' || stu.second_name, fac.price
from university.student as stu
inner join university.course as cou on stu.course_id = cou.id
inner join university.faculty as fac on cou.faculty_id = fac.id
where fac.price > 30000

-- 2. Перевести всех студентов Петровых на 1 курс экономического факультета.
update 
university.student
set course_id =
(select cou.id
 from university.course as cou
 inner join university.faculty as fac on cou.faculty_id = fac.id
 where cou.number = 1 and fac.name = 'Экономический') 
where family_name like 'Петров'

-- 3. Вывести всех студентов без отчества или фамилии.
select stu.family_name || ' ' || stu.name || ' ' || stu.second_name
from university.student as stu
where stu.family_name = '' or stu.second_name = '' 

-- 4.Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван".
select stu.family_name || ' ' || stu.name || ' ' || stu.second_name
from university.student as stu
where stu.name like '%ван%' or stu.second_name like '%ван%'

-- 5. Удалить все записи из всех таблиц. 
truncate university.student,
university.student_payment_type,
university.course,
university.faculty