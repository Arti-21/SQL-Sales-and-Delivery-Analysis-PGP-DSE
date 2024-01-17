ALTER TABLE sales_and_delivery.cust_dimen_m
ADD PRIMARY KEY (Cust_id);
DESC cust_dimen_m;

ALTER TABLE sales_and_delivery.prod_dimen_m
ADD PRIMARY KEY (Prod_id);
DESC prod_dimen_m;

ALTER TABLE sales_and_delivery.orders_dimen_m
ADD CONSTRAINT PK_Orders PRIMARY KEY (Order_ID,Ord_id);
DESC orders_dimen_m;

ALTER TABLE sales_and_delivery.shipping_dimen_m
ADD PRIMARY KEY (Ship_id);
DESC shipping_dimen_m;

ALTER TABLE sales_and_delivery.shipping_dimen_m
ADD FOREIGN KEY (Order_ID) REFERENCES orders_dimen_m(Order_ID) ;
DESC shipping_dimen_m;

ALTER TABLE sales_and_delivery.market_fact_m
ADD FOREIGN KEY (Cust_id) REFERENCES cust_dimen_m(Cust_id) ;
DESC market_fact_m;

ALTER TABLE sales_and_delivery.market_fact_m
ADD FOREIGN KEY (Prod_id) REFERENCES prod_dimen_m(Prod_id) ;
DESC market_fact_m;

ALTER TABLE sales_and_delivery.market_fact_m
ADD FOREIGN KEY (Ship_id) REFERENCES shipping_dimen_m(Ship_id) ;
DESC market_fact_m;


-- Error Code: 1822. Failed to add the foreign key constraint. 
-- Missing index for constraint 'FK_marketfact' in the referenced table 'orders_dimen_m'
ALTER TABLE sales_and_delivery.market_fact_m
ADD CONSTRAINT FK_marketfact FOREIGN KEY (Ord_id) REFERENCES orders_dimen_m(Ord_id) ;
DESC market_fact_m;

-- works after creating index
CREATE INDEX IX_Ord_id ON orders_dimen_m(Ord_id);

ALTER TABLE sales_and_delivery.market_fact_m
ADD CONSTRAINT FK_marketfact FOREIGN KEY (Ord_id) REFERENCES orders_dimen_m(Ord_id) ;
DESC market_fact_m;