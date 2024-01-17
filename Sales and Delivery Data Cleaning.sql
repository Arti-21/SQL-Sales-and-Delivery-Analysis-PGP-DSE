create table cust_dimen_m like cust_dimen;
desc cust_dimen_m;

INSERT INTO cust_dimen_m (Customer_Name,Province,Region,Customer_Segment,Cust_id) 
SELECT Customer_Name,Province,Region,Customer_Segment, substring(Cust_id,6) FROM cust_dimen ;

select * from cust_dimen_m;
alter table cust_dimen_m modify column Cust_id int;
desc cust_dimen_m;

create table orders_dimen_m like orders_dimen;
desc orders_dimen_m;

INSERT INTO orders_dimen_m (Order_ID,Order_Date,Order_Priority,Ord_id,DaysTakenForDelivery,Date_Ordered) 
SELECT Order_ID,Order_Date,Order_Priority, substring(Ord_id,5),DaysTakenForDelivery,Date_Ordered FROM orders_dimen ;

select * from orders_dimen_m;

alter table orders_dimen_m modify column Ord_id int;
desc orders_dimen_m;

create table prod_dimen_m like prod_dimen;
desc prod_dimen_m;

INSERT INTO prod_dimen_m (Product_Category,Product_Sub_Category,Prod_id) 
SELECT Product_Category,Product_Sub_Category,substring(Prod_id,6) FROM prod_dimen ;

select * from prod_dimen_m;

alter table prod_dimen_m modify column Prod_id int;
desc prod_dimen_m;


create table shipping_dimen_m like shipping_dimen;
desc shipping_dimen_m;

INSERT INTO shipping_dimen_m (Order_ID,Ship_Mode,Ship_Date,Ship_id) 
SELECT Order_ID,Ship_Mode,Ship_Date,substring(Ship_id,5) FROM shipping_dimen ;

select * from shipping_dimen_m;

alter table shipping_dimen_m modify column Ship_id int;
desc shipping_dimen_m;


create table market_fact_m like market_fact;
desc market_fact_m;

INSERT INTO market_fact_m (Ord_id,Prod_id,Ship_id,Cust_id,Sales,Discount,Order_Quantity,Profit,Shipping_Cost,Product_Base_Margin) 
SELECT substring(Ord_id,5),substring(Prod_id,6),substring(Ship_id,5),substring(Cust_id,6),Sales,Discount,Order_Quantity,Profit,
Shipping_Cost,Product_Base_Margin FROM market_fact ;

select * from market_fact_m;

alter table market_fact_m modify column Ord_id int;
alter table market_fact_m modify column Prod_id int; 
alter table market_fact_m modify column Ship_id int;
alter table market_fact_m modify column Cust_id int;
desc market_fact_m;