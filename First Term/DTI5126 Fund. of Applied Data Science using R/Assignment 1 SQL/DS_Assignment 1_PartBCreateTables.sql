USE HSD_DW
GO

-- Create Tables

CREATE TABLE TIMELINE (
TimeID				INT,
TDate				varchar(50),
TMonth				INT,
Month_text			varchar(50),
TQuarter			INT,
Quarter_text		varchar(50),
TYear				INT,
CONSTRAINT TimeID_PK				PRIMARY KEY(TimeID)
); 


CREATE TABLE CUSTOMER (
CustomerID			INT,
CustomerName		varchar(50),
Email				varchar(100),	
PhoneAreaCode		INT,
City				varchar(50),
CustomerState		varchar(50),
ZIP					INT,
CONSTRAINT CustomerID_PK			PRIMARY KEY(CustomerID)
);


CREATE TABLE PRODUCT (
ProductNumber		varchar(50),
ProductType			varchar(50),
ProductName			varchar(100),
CONSTRAINT ProductNumber_PK			PRIMARY KEY(ProductNumber)
);

CREATE TABLE PRODUCT_SALES (
TimeID				INT,
CustomerID			INT,
ProductNumber		varchar(50),
Quantity			INT,
UnitPrice			Numeric(8,2),
Total				Numeric(8,2)
CONSTRAINT Product_Sales_PK			PRIMARY KEY(TimeID, CustomerID,ProductNumber),
CONSTRAINT TimeID_FK				FOREIGN KEY(TimeID) REFERENCES TIMELINE(TimeID),
CONSTRAINT CustomerID_FK			FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID),
CONSTRAINT ProductNumber_FK			FOREIGN KEY(ProductNumber) REFERENCES PRODUCT(ProductNumber)  
);



