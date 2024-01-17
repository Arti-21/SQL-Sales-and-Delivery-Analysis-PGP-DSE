create table shipping_dimen_date like shipping_dimen_m;
desc shipping_dimen_date;

INSERT INTO shipping_dimen_date (Order_ID,Ship_Mode,Ship_Date,Ship_id) 
SELECT Order_ID,Ship_Mode,Ship_Date,Ship_id FROM shipping_dimen_m ;

-- UPDATE TABLE shipping_dimen_date SET Ship_Date = CONCAT(substring(Ship_Date,1,2),"-",substring(Ship_Date,4,5),"-",substring(Ship_Date,7,10));

DESC sales_and_delivery.shipping_dimen_date;
alter table shipping_dimen_date add column ship_date_trimmed char(10);
set sql_safe_updates=0;
update shipping_dimen_date set ship_date_trimmed = trim(Ship_Date);
alter table shipping_dimen_date add column dd char(2);
update shipping_dimen_date set dd = substring(ship_date_trimmed,1,2);
alter table shipping_dimen_date add column mm char(2);
update shipping_dimen_date set mm = substring(ship_date_trimmed,4,2);
alter table shipping_dimen_date add column yyyy char(4);
update shipping_dimen_date set yyyy = substring(ship_date_trimmed,7,4);
alter table shipping_dimen_date add column yyyy char(4);
update shipping_dimen_date set yyyy = substring(ship_date_trimmed,7,4);
alter table shipping_dimen_date add column ddmmyyyy char(10);
update shipping_dimen_date set ddmmyyyy = concat(dd,'-',mm,'-',yyyy); -- doesnt convert to date as mysql default is yyyy-mm-dd

alter table shipping_dimen_date drop column ddmmyyyy;
alter table shipping_dimen_date add column yyyymmdd char(10);
update shipping_dimen_date set yyyymmdd = concat(yyyy,'-',mm,'-',dd);
update shipping_dimen_date set yyyymmdd=str_to_date(yyyymmdd,'%Y-%m-%d');
alter table shipping_dimen_date modify column yyyymmdd DATE;

create table shipping_dimen_c like shipping_dimen_m;
desc shipping_dimen_c;
INSERT INTO shipping_dimen_c (Order_ID,Ship_Mode,Ship_Date,Ship_id) 
SELECT Order_ID,Ship_Mode,yyyymmdd,Ship_id FROM shipping_dimen_date ;
alter table shipping_dimen_c modify column Ship_Date DATE;

set sql_safe_updates=0;
update orders_dimen_m set Date_Ordered = trim(Order_Date);
alter table orders_dimen_m add column dd char(2);
update orders_dimen_m set dd = substring(Date_Ordered,9,2);
alter table orders_dimen_m add column mm char(2);
update orders_dimen_m set mm = substring(Date_Ordered,6,2);
alter table orders_dimen_m add column yyyy char(4);
update orders_dimen_m set yyyy = substring(Date_Ordered,1,4);
alter table orders_dimen_m add column yyyymmdd char(10);
update orders_dimen_m set yyyymmdd = concat(yyyy,'-',mm,'-',dd);
update orders_dimen_m set yyyymmdd=str_to_date(yyyymmdd,'%Y-%m-%d');
alter table orders_dimen_m modify column yyyymmdd DATE;

alter table orders_dimen_m drop column Order_Date;
alter table orders_dimen_m add column Order_Date DATE;
update orders_dimen_m set Order_Date = yyyymmdd;

alter table orders_dimen_m modify column Order_Date DATE after Order_ID;
alter table orders_dimen_m drop column dd;
alter table orders_dimen_m drop column mm;
alter table orders_dimen_m drop column yyyy;
alter table orders_dimen_m drop column yyyymmdd;
alter table orders_dimen_m drop column Date_Ordered;


