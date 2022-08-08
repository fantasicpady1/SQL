select * 
from BCTT..Sales2022

-- Gross revenue 
select sum(revenue) as Revenue2022
from BCTT..Sales2022
where year = 2022

select month, sum(revenue) as MonthRevenue
from BCTT..Sales2022
where year = 2022
group by month
order by 1

select year, sum(revenue) as YearRevenue
from BCTT..Sales2022
--where year = 2022
group by year
order by 1

--AvgProfit
select month, sum(profit) as MonthProfit, sum(profit)/sum(revenue) as ProductProfitMargin
from BCTT..Sales2022
where year = 2022
group by month
order by 1

select year, sum(profit) as Profit, sum(profit)/sum(revenue) as ProfitMargin
from BCTT..Sales2022
--where year = 2022
group by year
order by 1

--Category trend
select year, catogory, sum(revenue) as Revenue2022
from BCTT..Sales2022
Where catogory <> 'Unknown'
Group by catogory, year
order by 1

--Product trend
select product, catogory, sum(revenue) as Revenue2022
from BCTT..Sales2022
Where catogory <> 'Unknown'
and year = 2022
Group by product, catogory
order by 3 desc

select product, catogory, sum(profit) as Profit2022
from BCTT..Sales2022
Where catogory <> 'Unknown'
and year = 2022
Group by product, catogory
order by 3 desc

--Timeline sales
select date, catogory, sum(revenue) as Revenue
from BCTT..Sales2022
Where catogory <> 'Unknown'
Group by date, catogory
Order by 1
--Number of orders
select year, count('Order ID') as OrderCount
from BCTT..Sales2022
Group by year
order by 1

select catogory, count('Order ID') as OrderCount2022
from BCTT..Sales2022
where year = 2022
Group by catogory
order by 2 desc


--Number of customers
select year, count(Custumer) as CustomerCount
from BCTT..Sales2022
Group by year
order by 1

select month, count(distinct Custumer) as CustomerCount
from BCTT..Sales2022
Where year = 2022
Group by month
order by 1

select year, count(distinct Custumer) as CustomerCount
from BCTT..Sales2022
--Where year = 2022
Group by year
order by 1
--Profit
select catogory, sum(Profit) as ProfitCategory
from BCTT..Sales2022
--Where year = 2022
Group by catogory
Order by 2 desc

--Biggest Customers
select custumer, sum(revenue) as Revenue, sum(quantity) as Quantity
from BCTT..Sales2022
where year = 2022
and Unit = 'Kg'
group by custumer
order by 2 desc

--Employee
Select Employee, sum(revenue) as EmployeeRevenue
From BCTT..Sales2022
Where year = 2022
Group by Employee

--Timeline sales
Select date, catogory, sum(revenue) as CategorySales
From BCTT..Sales2022
Where year = 2022 and Catogory <> 'Unknown'
Group by date, catogory

--Sell loss
Select year, count(profit) as SellLossNumber, sum(profit) as SellLossMoney
From BCTT..Sales2022
Where profit < 0
and Catogory <> 'Unknown'
Group by year
Order by 1

--KPI
Select Team, Sum(KPI) as KPIRevenue
From BCTT..KPI
Where Quarter in (1,2)
Group by Team

Select Catogory, Sum(Revenue) as Revenue
From BCTT..Sales2022
Where year = 2022
and Catogory <> 'Unknown'
group by Catogory