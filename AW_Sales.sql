--Cleanse Dim_DateTable
SELECT 
  [DateKey], 
  [FullDateAlternateKey] as Date 
  --,[DayNumberOfWeek]
  , 
  [EnglishDayNameOfWeek] as Day 
  --,[SpanishDayNameOfWeek]
  --,[FrenchDayNameOfWeek]
  --,[DayNumberOfMonth]
  --,[DayNumberOfYear]
  , 
  [WeekNumberOfYear] as WeekNumber, 
  [EnglishMonthName] as Month, 
  left([EnglishMonthName], 3) as MonthShort 
  --,[SpanishMonthName]
  --,[FrenchMonthName]
  , 
  [MonthNumberOfYear] as MonthNumber, 
  [CalendarQuarter] as Quarter, 
  [CalendarYear] as Year 
  --,[CalendarSemester]
  --,[FiscalQuarter]
  --,[FiscalYear]
  --,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate] 
Where 
  CalendarYear >= 2020

-- Cleanse DIM_Customers Table
SELECT 
  c.CustomerKey as CustomerKey 
  --,c.[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title]
  , 
  c.firstname as [FirstName] 
  --,[MiddleName]
  , 
  c.lastname as [LastName], 
  c.FirstName + ' ' + c.LastName as [Fullname] 
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  , 
  Case c.Gender when 'M' then 'Male' when 'F' then 'Female' end as Gender 
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  , 
  c.DateFirstPurchase as [DateFirstPurchase], 
  --,[CommuteDistance]
  g.city as [Customer City]
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] as c 
  left join AdventureWorksDW2019..DimGeography as g on g.GeographyKey = c.GeographyKey 
order by 
  CustomerKey

-- Cleanse Product Table
SELECT p.[ProductKey]
      ,p.[ProductAlternateKey] as ProductItemCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,[EnglishProductName] as [Product Name],
	  ps.EnglishProductSubcategoryName as [Sub Category],
	  pc.EnglishProductCategoryName as [Product Category]
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,p.[Color] as [Product Color]
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,p.[Size] as [Product Size]
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,p.[ProductLine] as [Product Line]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,p.[ModelName] as [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription] as [Product Discription]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL(p.Status, 'Outdated') as [Product Status]
	  
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] as p
  left join AdventureWorksDW2019..DimProductSubcategory as ps on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
  left join AdventureWorksDW2019..DimProductCategory as pc on ps.ProductCategoryKey = pc.ProductCategoryKey


