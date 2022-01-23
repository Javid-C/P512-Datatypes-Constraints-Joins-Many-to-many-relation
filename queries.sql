create database P512Company

use P512Company

create table Employee(
	Id int,
	Name nvarchar(20),
	Surname nvarchar(25),
	Email nvarchar(50),
	Salary int
)

insert into Employee(Name,Id,Surname,Email,Salary)
values
('Ricat',1,'Alizade','ricat@gmail.com',1500),
('Ali',2,'Aliyev','ali@gmail.com',1500),
('Idris',3,'Mikayil','idris@yandex.ru',1500),
('Latif',4,'Hasanzade','latif@yandex.ru',1300),
('Madina',5,'Agazade','madina@outlook.com',1500),
('Sama',6,'Mayilova','sama@outlook.com',1500),
('Chimnaz',7,'Mammadova','chimnaz@mail.ru',1500),
('Nursultan',8,'Rabat','rabat@mail.ru',1500),
('Marav',9,'Maravova','marav@hotmail.com',1500),
('Vusal',10,'Asadullayev','vusal@hotmail.com',1500)

select (Name + ' ' + Surname) 'Fullname', SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)) as Domain from Employee


create table Students(
	Id int primary key identity,
	Name nvarchar(30) not null,
	Surname nvarchar(30),
	Email nvarchar(50) Unique
)


insert into Students
values('Ali','Alizade','ricat@gmail.com'),
('Madina','Agazade','madina@gmail.com')

alter table Students
drop constraint UQ__Students__A9D105344AC0C4E4

alter table Students
drop column Email

alter table Students
add Email nvarchar(50) constraint Email_UQ Unique

truncate table Students

alter table Students
add Point int

insert into Students
values('Idris','Mikayil','idris@gmail.com',100)

alter table Students
add constraint Check_Point check(Point<=100)

update Students
set Point=51 where Id in(1,2)


select AVG(Point) 'Average Point' from Students

select Name,Surname from Students where Point>(select AVG(Point) 'Average Point' from Students)

create table Groups(
	Id int primary key identity,
	Name nvarchar(20) Not Null
)

alter table Students
add GroupId int constraint FK_Students_GroupId foreign key references Groups(Id) 

select * from Students

select s.Id,(s.Name+ ' ' +s.Surname) as Fullname,Email,g.Name from Students  s
Inner join Groups  g
on s.GroupId = g.Id

select * from Students
Left join Groups
on Students.GroupId = Groups.Id

select * from Students s
Right outer Join Groups g
on s.GroupId = g.Id

select * from Groups g
full join Students s
on s.GroupId = g.Id

create table Diplomas(
	Id int primary key identity,
	Name nvarchar(30) not null,
	Min int check(Min>=0),
	Max int check(Max<=100)
)

insert into Diplomas
values(N'Adi',65,85),
(N'Şərəf',86,95),
(N'Yüksək Şərəf',96,100)

select (s.Name + ' ' +s.Surname) as Fullname, s.Point,d.Name as Diploma  from Students s
join Diplomas d
on s.Point>=d.Min AND s.Point<=d.Max


create table Movies(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Duration int,
	IMDb decimal(2,1) check(IMDb<=10),
)


create table Categories(
	Id int primary key identity,
	Name nvarchar(30)
)

create table MovieCategories(
	Id int primary key identity,
	MovieId int constraint FK_MovieCategories_MovieId foreign key references Movies(Id),
	CategoryId int foreign key references Categories(Id)
)


insert into Categories
values('Sci-Fi'),
('Thriller'),
('Action'),
('Drama'),
('Horror')

insert into Movies
values('Interstellar',148,8.6),
('Inception',148,8.8),
('Shutter Island',138,8.2),
('Indiana Johns', 140,7.6),
('The Wolf of Wall Street', 188, 8.2)


insert into Movies
values('Dune',140,7.66)


insert into MovieCategories
values(1,1),
(1,4),
(1,2),
(2,3),
(2,4),
(3,2),
(3,3),
(4,1),
(4,3),
(5,2),
(5,3),
(6,5),
(6,1)

select m.Name 'Movie Name', m.Duration, m.IMDb, c.Name as 'Category name' from MovieCategories mc
join Movies m
on mc.MovieId = m.Id
join Categories c
on mc.CategoryId = c.Id
group by m.Name



select m.Name 'Movie Name', Count(c.Name) 'Category Count' from MovieCategories mc
join Movies m
on mc.MovieId = m.Id
join Categories c
on mc.CategoryId = c.Id
group by m.Name
having Count(c.Name)>=2
order by Count(c.Name) desc









