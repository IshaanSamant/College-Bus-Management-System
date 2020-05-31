create database testbus;
use testbus;

CREATE TABLE Driver
(
D_no int UNIQUE NOT NULL,
D_Name varchar(200) NOT NULL,
Age int NOT NULL,
Salary int NOT NULL,
PRIMARY KEY(D_no)
);

CREATE TABLE Buses
(
Bus_ID int UNIQUE NOT NULL,
Model varchar(200) NOT NULL,
Capacity int NOT NULL,
Occupancy int NOT NULL,
Driver_No int,
PRIMARY KEY(Bus_ID),
FOREIGN KEY (Driver_No) REFERENCES Driver(D_no)
);

CREATE TABLE Route
(
Route_ID int UNIQUE NOT NULL,
ArrivalTime time NOT NULL,
DepartureTime time NOT NULL,
TotalStudent int,
BusNumber int FOREIGN KEY REFERENCES Buses(Bus_ID) ,
PRIMARY KEY(Route_ID)
);

CREATE TABLE Bus_Stops
(
StopName varchar(200) UNIQUE NOT NULL,
StopCode int UNIQUE NOT NULL,
Area varchar(200) NOT NULL,
RouteNumber int FOREIGN KEY REFERENCES Route(Route_ID),
PRIMARY KEY(StopCode)
);

CREATE TABLE Student
(
Student_ID int UNIQUE NOT NULL,
StudentName varchar(200) NOT NULL,
Gender varchar(6) NOT NULL,
Street_Name varchar(200) NOT NULL,
Area varchar(200) NOT NULL,
StopName varchar(200) FOREIGN KEY REFERENCES Bus_Stops(StopName),
Route_number int FOREIGN KEY REFERENCES Route(Route_ID),
PRIMARY KEY(Student_ID)
);

CREATE TABLE Fee
(
Transaction_ID int UNIQUE NOT NULL,
Student_ID int FOREIGN KEY REFERENCES Student(Student_ID),
Amount int NOT NULL CHECK (Amount>=2000),
Paydate date NOT NULL,
ExpiryDate date NOT NULL,
PRIMARY KEY(Transaction_ID)
);

ALTER TABLE Student
ADD CONSTRAINT Valid_Sid CHECK (Student_ID>=1000 AND Student_ID<=9999);



create trigger SuccessfulAddition
on student
for insert
as
begin
declare @sname varchar(200)
select @sname = inserted.StudentName
from inserted
print('The name of the student successfully added is ')
print (@sname)
End


create trigger UpdateRoute
on Student
for insert
as
begin
declare @routeid int,@studentcount int
select @routeid = inserted.Route_number
from inserted
set @studentcount = (select count(Student_ID)
from student
where Route_number=@routeid)

update Route
set TotalStudent=@studentcount
where Route_ID=@routeid
end