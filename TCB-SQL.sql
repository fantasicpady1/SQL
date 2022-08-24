-- Data đề bài
Drop table if exists Table1
Drop table if exists Table2
Create table Table1(
Emp_id varchar(255),
First_name varchar(255)
)

Create table Table2(
Emp_id int,
Name varchar(255),
Division varchar(255),
[Joining Date] varchar(255)
)

Insert into Table1 values
('E11', 'Hai DA. Nguyen Viet'),
('E12', 'Duc DA. Le Anh'),
('E3158', 'Chi DA. Nguyen Pham Hai'),
('S0056', 'Tung DA. Nguyen Hoang')

Insert into Table2 values
(12, 'Duc', 'DA', '2016/04/18'),
(56, 'Tung', 'DA', '2016-06-19'),
(null, null, 'BF', '2018/09/07'),
(3158, 'Chi', 'DA', '2021-26-03')

--Question 2: Joining in Table
Drop table if exists #SplitTable
Create table #SplitTable
(Emp_id int,
Name varchar(255),
Division varchar (255),
Year varchar (255),
[Month/Date1] varchar (255),
[Month/Date2] varchar (255),
New_date date)
Insert into #SplitTable
Select Emp_id, Name, Division, left([Joining Date], 4) as Year, SUBSTRING([Joining Date], 6,2) as [Month/Date1], SUBSTRING([Joining Date], 9,2) as [Month/Date2], 
Case 
	When cast(SUBSTRING([Joining Date], 6,2) as int) <= 12 then CONCAT_WS('/', left([Joining Date], 4), SUBSTRING([Joining Date], 6,2), SUBSTRING([Joining Date], 9,2))
	Else concat_WS('/', left([Joining Date], 4), SUBSTRING([Joining Date], 9,2), SUBSTRING([Joining Date], 6,2))
End as New_date
From Table2

Drop table if exists Table3
Create table Table3(
Employee_name varchar(255),
Emp_id int,
[Employee / Supervisor] varchar(255),
[# of months in Bank] int)
Insert into Table3
Select b.name, b.Emp_id, 
Case
	When a.Emp_id like 'E%' then 'Employee'
	When a.Emp_id like 'S%' then 'Supervisor'
End as [Employee / Supervisor],
DATEDIFF(month, b.New_date, GETDATE()) as [# of months in Bank]
From Table1 a
Inner join #SplitTable b
on substring(a.Emp_id, 2, LEN(a.First_name) - 1) = b.Emp_id
Order by b.Emp_id;

Select Emp_id, [Employee / Supervisor], [# of months in Bank]
From Table3
Where Emp_id is not null

--Question 3: Alternate records
Select Emp_id, First_name from
(Select Emp_id, First_name, ROW_NUMBER() over (order by Emp_Id) as RowNum
From Table1) A
where RowNum % 2 = 0

Select Emp_id, First_name from
(Select Emp_id, First_name, ROW_NUMBER() over (order by Emp_Id) as RowNum
From Table1) A
where RowNum % 2 <> 0;

--Question 4: 2nd Longest working months
WITH T AS
(
SELECT *,
  Rank() OVER (ORDER BY [# of months in Bank] Desc) AS Rnk
FROM Table3
)
SELECT Employee_name, [# of months in Bank] as Highest_months_in_Bank
FROM T
WHERE Rnk=2;
