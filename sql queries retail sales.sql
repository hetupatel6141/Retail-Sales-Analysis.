create database retail;
use retail;
create table supplychain(
Row_ID	BIGINT PRIMARY KEY,
Order_ID VARCHAR(20),	
Order_Date DATE,	
Ship_Date DATE,	
Ship_Mode VARCHAR(30),	
Customer_ID VARCHAR(20),	
Customer_Name	VARCHAR(100),
Segment	VARCHAR(30),	
Country	VARCHAR(50),	
City	VARCHAR(50),
State	VARCHAR(50),
Postal_Code	VARCHAR(50),
Region	VARCHAR(20),	
Retail_Sales_People	VARCHAR(100),
Product_ID	VARCHAR(30),	
Category	VARCHAR(50),
Sub_Category	VARCHAR(50),
Product_Name	VARCHAR(255),
Returned	VARCHAR(30),
Sales	BIGINT,
Quantity	INT,
Discount	decimal(5,2),
Profit decimal(10,2)
);
drop table supplychain;
Create table supportingdatasheet(
Date	DATE,
Year	YEAR,
Quarter	INT,
Quarter_Q varchar(5),
Quarter_Year	varchar(15),
Month	int,
Month_Name	varchar(15),
Month_Year	varchar(15),
Week_Year	int,
Week_of_Year 	varchar(15),
Day_Week	int,
Day_Name varchar(15)
);
select COUNT(*) FROM supplychain;
select * from  supportingdatasheet;
select sum(Sales), YEAR(Order_Date)
from supplychain
group by YEAR(Order_Date)
order by  sum(Sales) asc;
select year(Order_Date), sum(Profit)
from supplychain
group by year(Order_Date)
order by sum(Profit);
select count( Order_ID), year(Order_Date)
from supplychain
group by year(Order_Date)
order by year(Order_Date);
select count(distinct Customer_ID), year(Order_Date)
from supplychain
group by year(Order_Date)
order by count(distinct Customer_ID) desc;
select Category, SUM(Sales), year(Order_Date)
from supplychain
group by Category , year(Order_Date)
order by year(Order_Date) desc;
select Category, sum(Quantity), year(Order_Date)
from supplychain
where Category = 'Office Supplies'
group by  year(Order_Date)
order by year(Order_Date) desc;
select Category, SUM(Profit)
from supplychain 
group by Category
order by SUM(Profit) desc;
select Region, SUM(Sales)
from supplychain 
group by Region
order by SUM(Sales) desc;
select City, SUM(Sales)
from supplychain 
group by City
order by SUM(Sales) desc;
select sum(Sales)/ COUNT(distinct Order_ID)
from supplychain; 
select Category, SUM(Quantity)
from supplychain
where Returned = 'NOT'
group by Category;
select Sub_Category , Category , sum(Quantity)
from supplychain
where Returned = 'NOT'
group by Sub_Category,  Category
order by  sum(Quantity) desc;
select Sub_Category, COUNT(Order_id)
from supplychain
where Returned = 'NOT'
group by  Sub_Category
order by COUNT(Order_id) desc;
select Sub_Category,  Category,SUM(Profit)
from supplychain
where Returned = 'NOT'
group by Sub_Category,Category
having SUM(Profit) < 0 
order by SUM(Profit);
select segment, count(distinct Customer_ID)
from supplychain
group by segment
order by count(distinct Customer_ID) desc;
select segment, sum(Sales)
from supplychain
group by segment 
order by sum(Sales) desc;
 select segment, sum(Profit)
from supplychain
group by segment 
order by sum(Profit) desc;
select Sub_Category, SUM(Sales), SUM(Profit)
from supplychain
where returned = 'NOT'
group by Sub_Category
order by SUM(Sales)desc, SUM(Profit)asc
limit 20;
use retail;
select Sub_Category, sum(Profit)
from supplychain 
group by Sub_Category
having sum(Profit) < 0
order by sum(Profit) asc;
select State, sum(Profit)
from supplychain 
group by State
having sum(Profit) < 0
order by sum(Profit) asc;
select City, sum(Profit)
from supplychain 
group by City
having sum(Profit) < 0
order by sum(Profit) asc;
select Region, sum(Sales), sum(Profit), round((sum(Profit) / sum(Sales)) * 100)
from supplychain
group by  Region
order by  sum(Profit), round((sum(Profit) / sum(Sales))) * 100 asc;
select Category, avg(Discount) * 100
from supplychain 
group by Category 
order by avg(Discount) * 100 desc;
select Sub_Category, avg(Discount) * 100
from supplychain 
group by Sub_Category 
order by avg(Discount) * 100 desc;
select Sub_Category, Category, sum(Profit), avg(Discount) * 100
from supplychain 
group by Sub_Category ,  Category
order by avg(Discount) * 100 desc;
select Category, sum(Sales), sum(Profit), avg(Discount) * 100
from supplychain 
group by  Category
order by avg(Discount) * 100 desc;
select Sub_Category, sum(Sales), sum(Profit), avg(Discount) * 100
from supplychain 
group by Sub_Category
having avg((Discount) * 100) > 0.20 and sum(Profit) < 0
order by sum(Profit) asc;
USE retail;
select 
round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2)
from supplychain; 
select Sub_Category,Category, round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2)
from supplychain 
group by  Sub_Category,Category
order by  round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2) desc;
select  sum(Profit)
from supplychain 
where Sub_Category = 'Machines';
select State, round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2)
from supplychain
group by State
order by round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2) desc;
select Category, SUM(Sales), round(sum(case when Returned = 'Yes' then 1 else 0 end) * 100
/ count(*), 2) 
from supplychain 
group by Category 
order by SUM(Sales);
select Category, SUM(Profit)
from supplychain
group by Category 
order by SUM(Profit);
select Sub_Category, sum(Sales),SUM(Profit)
from supplychain 
group by Sub_Category 
order by SUM(Profit) desc
limit 10;
SELECT Sub_Category,
       SUM(Sales) AS total_sales,
       SUM(Profit) AS total_profit,
       (SUM(Profit)/SUM(Sales))*100 AS profit_margin
FROM supplychain
GROUP BY Sub_Category
HAVING SUM(Sales) > (SELECT AVG(Sales) FROM supplychain)
   AND SUM(Profit) > (SELECT AVG(Profit) FROM supplychain)
   limit 10 ;
   SELECT
    Product_Name,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM supplychain
GROUP BY Product_Name
ORDER BY Total_Sales DESC, Total_Profit DESC
LIMIT 10;
use retail; 
select State, sum(Sales), sum(Profit)
from supplychain 
group by State 
having sum(Profit) > 0
order by sum(Profit) desc, sum(Sales) desc
limit 10;
select Customer_Name, count(distinct Order_ID),sum(Sales), sum(Profit)
from supplychain 
where Returned = 'NOT'
group by  Customer_Name
having sum(Profit) > 0 and count(distinct Order_ID) > 1 
order by sum(Sales) desc, sum(Profit) desc;
select Category, Year(Order_Date), sum(Sales)
from supplychain 
group by  Category,Year(Order_Date)
order by Year(Order_Date);
select monthname(Order_Date), sum(Sales), sum(Profit)
from supplychain 
group by monthname(Order_Date) 
order by sum(Sales) desc;
select Segment
from supplychain 
where Returned = 'Yes'
group by Segment;
SELECT Segment,
       SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS Returned_Orders,
       COUNT(*) AS Total_Orders,
       ROUND(
           SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) * 100.0
           / COUNT(*), 2
       ) AS Return_Percentage
FROM supplychain
GROUP BY Segment
ORDER BY Return_Percentage DESC;
select Product_Name,   sum(Profit),count(*) AS Total_Orders, SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS Returned_Orders
           from supplychain
           group by  Product_Name
           having  sum(Profit) < 0 and SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END)> 0
           order by Returned_Orders desc , sum(Profit) desc;
select Category, sum(Sales), sum(Profit), round(sum(Profit) / sum(Sales) * 100,2) AS Proft_Margin 
from supplychain 
group by  Category
order by  Proft_Margin  asc;
SELECT Product_Name,
       ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percentage,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
FROM supplychain
GROUP BY Product_Name
HAVING SUM(Profit) <= 0
ORDER BY Avg_Discount_Percentage DESC;

select Product_Name, sum(Profit),   ceil(count(distinct Product_Name) * 0.2) AS Top_Products 
from supplychain
group by Product_Name
order by sum(Profit) desc
limit 360;

select round(avg(Discount) * 100,2),
sum (Sales), sum(Profit), sum(
case 
when Discount > 0.2 then
 Profit
 else 0
 end)
from supplychain ;
SELECT
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(
        CASE
            WHEN Discount > 0.20 THEN Profit
            ELSE 0
        END
    ) AS High_Discount_Profit
FROM supplychain;
SELECT
ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(DISTINCT Customer_ID) FROM supplychain),
2) AS Repeat_Purchase_Rate
FROM
(
    SELECT Customer_ID
    FROM supplychain
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Order_ID) > 1
) t;



  
           

