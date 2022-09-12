/*Identify transactions with null values on the DateSoldID and remove them from the table*/
/*First Question*/
Delete from TRANS where DateSold is NULL;
/*For Revice*/
Select * from trans where DateSold is NULL;

/*List the WorkId, Title, Medium, ArtistID, and the concatenated artist name renamed as FullName for all 
artwork that the title contains the word “Yellow, “Blue” or “White”, e.g., the title “On White II” would 
meet the criteria*/
/*Second Question*/
select WorkId,Title,Medium,arts.ArtistID ,CONCAT (FirstName,LastName)
from work wrk join artist arts on  wrk.ArtistID = arts.ArtistID
where Title like '%Yellow%' or Title like '%Blue%' or Title like '%White%'

/*For each Artist, show the Year, ArtistID, sum of SalesPrice as SumOfSubTotal, and average of SalesPrice 
as AverageOfSubtotal for each year*/
/*Third Question */
Select DateOfBirth,wrk.ArtistID,sum(salesprice)  as SumOFSubTotal 
,avg(salesprice) as AverageOfSubtotal 
from work wrk 
join trans trns on wrk.WorkID = trns.WorkID 
join ARTIST arts on  wrk.ArtistID = arts.ArtistID 
Group by DateOfBirth,wrk.ArtistID


/*Show the ArtistID , FirstName, Lastname, WorkID, and Title of Artists 
that have an artwork sold with a 
SalesPrice above the average SalesPrice*/
/*Fourth Question*/
Select arts.ArtistID,FirstName,LastName,wrk.WorkID,Title
from WORK wrk
join artist arts on arts.ArtistID = wrk.ArtistID
join trans trns  on trns.WorkID = wrk.WorkID
where trns.SalesPrice >( select avg(salesprice) from trans)


/*Modify the email of the customer Johnson Lynda and her encrypted password from NULL to 
Johnson.lynda@somewhere.com and “aax1xbB” respectively. */
/*Fifth Question */
update customer 
set EmailAddress='Johnson.lynda@somewhere.com' , EncryptedPassword='aax1xbB'
where EmailAddress is Null and EncryptedPassword is Null 

/*For Revice*/
select EmailAddress,EncryptedPassword from customer
where FirstName ='Lynda' and LastName = 'Johnson';



/*six Question */
/*For each customer, find the time (in days) between a purchase and the next for the DateSoldID. Display all 
the attributes of the customer and days between purchase as Days_Difference. Consider using the Lead or Lag function.*/
/*six Question */
select cust.CustomerID,TransactionID,DateSold,COALESCE(DATEDIFF(Day, LAG(DateSold) OVER
(PARTITION BY trns.CustomerID  ORDER BY DateSold),DateSold),0)as Days_Difference
from CUSTOMER cust
join TRANS trns on trns.CustomerID=cust.CustomerID 
order by CustomerID




/*Seven question*/
/*Create a view called CustomerTransactionSummaryView to display the concatenated customer name 
renamed as FullName using the LastName and FirstName, Title, DateAcquired, DateSold, and difference in 
the AcquisitionPrice and SalesPrice as Profit for art works with an AskingPrice greater than $20,000. Use 
the JOIN ON syntax and order by the AskingPrice in descending order (Ensure to add space between the 
full name if required).*/

CREATE VIEW CustomerTransactionSummary As 
Select Title,DateAcquired,DateSold,(SalesPrice-AcquisitionPrice) as Profit,
CONCAT(Arts.FirstName,Arts.LastName) as FullName
from WOrk wrk  JOIN TRANS trn  ON wrk.WorkID =trn.WorkID 
JOIN ARTIST Arts ON Arts.ArtistID=wrk.ArtistID
where wrk.WorkID=trn.WorkID AND trn.AskingPrice>20000
Order by trn.AskingPrice desc OFFSET 0 rows
/*For Revice*/
select * from CustomerTransactionSummary 


/*Build a single temporary table called Purchase that captures customers’ purchases from 2015 to 2017. The 
table should contain the TransactionID, DateAcquired, CustomerID, LastName, FirstName, first
AcquisitionDate as MinAcquisitionDate, last AcquisitionDate as MaxAcquisitionDate, and Medium used 
for the artwork. Also, the Medium values should be represented as numeric values using High Quality 
Limited Print – 1, Color Aquatint – 2, Water Color and Ink – 3, Oil and Collage – 4, Others - 5. Note: 
consider using CTEs and CASE statement in your query if required*/
/*Eight Question*/
with Purchase (CustomerID,MinAcquisitionDate ,MaxAcquisitionDate) as
 (SELECT cust.CustomerID,  MIN(DateAcquired) as Mini,MAX(DateAcquired) as Maxx
FROM TRANS as trns,  CUSTOMER as cust 
WHERE  cust.CustomerID = trns.CustomerID AND DateAcquired BETWEEN  '2015' AND '2018' 
group by  cust.CustomerID)
SELECT   trns.TransactionID , trns.DateAcquired, cust.CustomerID AS CUSTOMER_id , 
LastName, FirstName ,MinAcquisitionDate , MaxAcquisitionDate ,Trns.WorkID , wrk.Medium as artwork  ,
	case
	 when  wrk.Medium =  'High Quality Limited Print' then 1
	 when  wrk.Medium =  'Color Aquatint' then 2	
	 when  wrk.Medium =  'Water Color and Ink' then 3	
	 when  wrk.Medium =  ' Oil and Collage' then 4
	 else 5
	 end as Medium
FROM TRANS as trns,  CUSTOMER as cust , WORK as wrk  , Purchase as pur
WHERE  cust.CustomerID = cust.CustomerID AND  wrk.WorkID =  trns.WorkID AND
pur.CustomerID = cust.CustomerID  AND trns.DateAcquired BETWEEN  '2015' AND '2018'

