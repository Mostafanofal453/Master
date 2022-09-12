# Setup the dimension tables

#create the Timeline table

Timeline_table <- data.frame(
            TimeID=c(43023, 43033, 43089, 43184, 43186, 43190, 43193, 43198, 43213, 43227, 43241, 43256),
            TDate=c("15-Oct-17", "25-Oct-17", "20-Dec-17", "25-Mar-18", "27-Mar-18", "31-Mar-18", "3-Apr-18", "8-Apr-18", "23-Apr-18", "7-May-18", "21-May-18", "5-Jun-18"),
            TMonth=c(10, 10, 12, 3, 3, 3, 4, 4, 4, 5, 5, 6),
            Month_text=c("October", "October", "December", "March", "March", "March", "April", "April", "April", "May", "May", "June"),
            TQuarter=c(3, 3, 3, 1, 1, 1, 2, 2, 2 ,2, 2, 2),
            Quarter_text=c("Qtr3", "Qtr3", "Qtr3", "Qtr1", "Qtr1", "Qtr1", "Qtr2", "Qtr2", "Qtr2", "Qtr2", "Qtr2", "Qtr2"),
            TYear=c(2017, 2017, 2017, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018))

#create the Customer table

Customer_table <- data.frame(
            CustomerID=c(1:12),
            CustomerName=c("Jacobs, Nancy", "Jacobs, Chantel", "Able, Ralph", "Baker, Susan", "Eagleton, Sam", "Foxtrot, Kathy", "George, Sally", "Hullett, Shawn", "Pearson, Bobbi", "Ranger, Terry", "Tyler, Jenny", "Wayne, Joan"),
            Email=c("somewhere.com", "somewhere.com", "somewhere.com", "elsewhere.com", "elsewhere.com", "somewhere.com", "somewhere.com", "elsewhere.com", "elsewhere.com", "somewhere.com", "somewhere.com", "elsewhere.com"),
            PhoneAreaCode=c(817,817,210, 210, 210, 972, 972, 972, 512, 512, 972, 817),
            City=c("Fort Worth", "Fort Worth", "San Antonio", "San Antonio", "San Antonio", "Dallas", "Dallas", "Dallas", "Austin", "Austin", "Dallas", "Fort Worth"),
            State=c("TX", "TX", "TX", "TX", "TX", "TX", "TX", "TX", "TX", "TX", "TX", "TX"),
            ZIP=c(76110, 76112, 78214, 78216, 78218, 75220, 75223, 75224, 78710, 78712, 75225, 76115))

#create the Product table

PRODUCT_table <- data.frame(
            ProductNumber=c("BK001", "BK002", "BK003", "VB001", "VB002", "VB003", "VK001", "VK002", "VK003", "VK004"),
            ProductType=c("Book", "Book", "Book", "Video Companion", "Video Companion", "Video Companion", "Video", "Video", "Video", "Video"),
            ProductName=c("Kitchen Remodeling Basics For Everyone", "Advanced Kitchen Remodeling For Everyone", "Kitchen Remodeling Dallas Style For Everyone", "Kitchen Remodeling Basics", "Advanced Kitchen Remodeling I", "Kitchen Remodeling Dallas Style", "Kitchen Remodeling Basics", "Advanced Kitchen Remodeling", "Kitchen Remodeling Dallas Style", "Heather Sweeney Seminar Live in Dallas on 25-OCT-16"))

# Setup the fact table

Sales_table <- data.frame(
            TimeID=c(43023, 43023, 43033, 43033, 43033, 43089, 43184, 43184, 43184, 43186, 43186, 43186, 43186, 43186, 43186, 43186, 43186, 43186, 43190, 43190, 43190, 43193, 43193, 43193, 43198, 43198, 43198, 43198, 43198, 43198, 43213, 43227, 43227, 43241, 43241, 43241, 43256, 43256, 43256, 43256, 43256, 43256, 43256, 43256, 43256, 43256, 43256),
            CustomerID=c(3 ,3, 4, 4, 4, 7, 4, 4, 4, 6, 6, 6, 6, 6, 7, 7, 7, 7, 9, 9, 9, 11, 11, 11, 1, 1, 1, 5, 5, 5, 3, 9, 9, 8, 8, 8, 3, 3, 3, 3, 3, 11, 11, 12, 12, 12, 12),
            ProductNumber=c("VB001", "VK001", "BK001", "VB001", "VK001", "VK004", "BK002", "VK002", "VK004", "BK002", "VB003", "VK002", "VK003", "VK004", "BK001", "BK002", "Vk003", "VK004", "BK001", "VB001", "VK001", "VB003", "VK003", "VK004", "BK001", "VB001", "VK001", "BK001", "VB001", "VK001", "BK001", "VB002", "VK002", "VB003", "VK003", "VK004", "BK002", "VB001", "VB002", "VK001", "VK002", "VB002", "VK002", "BK002", "VB003", "VK002", "VK003"),
            Quantity=c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2, 1, 1, 1, 1),
            UnitPrice=c(7.99, 14.95, 24.95, 7.99, 14.95, 24.95, 24.95, 14.95, 24.95, 24.95, 9.99, 14.95, 19.95, 24.95, 24.95, 24.95, 19.95, 24.95, 24.95, 7.99, 14.95, 9.99, 19.95, 24.95, 24.95, 7.99, 14.95, 24.95, 7.99, 14.95, 24.95, 7.99, 14.95, 9.99, 19.95, 24.95, 24.95, 7.99, 7.99, 14.95, 14.95, 7.99, 14.95, 24.95, 9.99, 14.95, 19.95),
            Total=c(7.99, 14.95, 24.95, 7.99, 14.95, 24.95, 24.95, 14.95, 24.95, 24.95, 9.99, 14.95, 19.95, 24.95, 24.95, 24.95, 19.95, 24.95, 24.95, 7.99, 14.95, 19.98, 39.9, 49.9, 24.95, 7.99, 14.95, 24.95, 7.99, 14.95, 24.95, 7.99, 14.95, 9.99, 19.95, 24.95, 24.95, 7.99, 15.98, 14.95, 29.9, 15.98, 29.9, 24.95, 9.99, 14.95, 19.95))

print(Sales_table)


# Build up a cube
QuantityC <- 
  tapply(Sales_table$Quantity,
         Sales_table[,c("TimeID", "CustomerID", "ProductNumber")], 
         FUN=function(x){return(sum(x))})

#print the cube
print(QuantityC)

#print the dimensions names of the cube
print(dimnames(QuantityC))


