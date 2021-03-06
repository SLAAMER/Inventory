/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 12.1 		*/
/*  Created On : 09-nov.-2016 16:48:53 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Drop Foreign Key Constraints */

CREATE DATABASE Inventory;
GO
USE Inventory;
GO

/* Create Tables */

CREATE TABLE [HumanResource.employees]
(
	[emp_id] smallint NOT NULL,
	[emp_name] varchar(70) NOT NULL,
	[emp_lastname] varchar(70) NOT NULL,
	[emp_type] char(5) NOT NULL,
	[emp_nickname] varchar(50) NOT NULL,
	[emp_passwd] varchar(50) NOT NULL
)
GO

CREATE TABLE [Inventory.conversions]
(
	[cvn_from_id_ingredient] int NOT NULL,
	[cvn_from_id_warehouse] int NOT NULL,
	[cvn_from_id_measurement] char(3) NOT NULL,
	[cvn_to_id_measurement] char(3) NOT NULL,
	[cvn_factor_number] int NOT NULL
)
GO

CREATE TABLE [Inventory.ingredient_measurements]
(
	[ims_id_ingredient] int NOT NULL,
	[ims_id_warehouse] int NOT NULL,
	[ims_id_measurement] char(3) NOT NULL
)
GO

CREATE TABLE [Inventory.measurementunits]
(
	[meu_id] char(3) NOT NULL,
	[meu_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [Inventory.movementconcepts]
(
	[mco_id] int NOT NULL,
	[mco_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [Inventory.movements]
(
	[mov_id] int NOT NULL IDENTITY (1, 1),
	[mov_date] datetime NOT NULL,
	[mov_quantity] int NOT NULL,
	[mov_warehouse_id] int NOT NULL,
	[mov_id_stock_ingredient] int NOT NULL,
	[mov_concept] int NOT NULL
)
GO

CREATE TABLE [Inventory.stock]
(
	[sto_id_ing] int NOT NULL,
	[war_id] int NOT NULL,
	[sto_quantity] int NOT NULL,
	[sto_min] int,
	[sto_max] int NOT NULL
)
GO

CREATE TABLE [Inventory.warehouses]
(
	[war_id] int NOT NULL,
	[war_name] varchar(50) NOT NULL
)
GO

CREATE TABLE [Kitchen.dish_ingredients]
(
	[ing_id] int NOT NULL,
	[dis_id] int NOT NULL,
	[measurement] char(3) NOT NULL,
	[dis_ing_quantity] int NOT NULL
)
GO

CREATE TABLE [Kitchen.dishes]
(
	[dis_id] int NOT NULL,
	[dis_name] varchar(50) NOT NULL,
	[dis_description] text NOT NULL,
	[dis_price] money NOT NULL
)
GO

CREATE TABLE [Kitchen.ingredients]
(
	[ing_id] int NOT NULL,
	[ing_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [Sales.order_dishes]
(
	[dis_id] int NOT NULL,
	[ord_id] int NOT NULL,
	[ord_dis_quantity] int NOT NULL,
	[ord_date] datetime NOT NULL,
	[ord_total] money NOT NULL
)
GO

CREATE TABLE [Sales.orders]
(
	[ord_id] int NOT NULL,
	[ord_date] datetime NOT NULL,
	[ord_subtotal] money NOT NULL,
	[ord_iva] money NOT NULL,
	[ord_total] money NOT NULL,
	[ord_status] int NOT NULL,
	[ord_employee_id] smallint NOT NULL
)
GO

CREATE TABLE [Sales.orderstatus]
(
	[ors_id] int NOT NULL,
	[ors_description] varchar(50) NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [HumanResource.employees] 
 ADD CONSTRAINT [PK_employees]
	PRIMARY KEY CLUSTERED ([emp_id] ASC)
GO

ALTER TABLE [Inventory.conversions] 
 ADD CONSTRAINT [PK_Inventory.conversions]
	PRIMARY KEY CLUSTERED ([cvn_from_id_ingredient] ASC,[cvn_from_id_warehouse] ASC,[cvn_from_id_measurement] ASC,[cvn_to_id_measurement] ASC)
GO

ALTER TABLE [Inventory.ingredient_measurements] 
 ADD CONSTRAINT [PK_Inventory.ingredient_measurements]
	PRIMARY KEY CLUSTERED ([ims_id_ingredient] ASC,[ims_id_warehouse] ASC,[ims_id_measurement] ASC)
GO

ALTER TABLE [Inventory.measurementunits] 
 ADD CONSTRAINT [PK_measurementunits]
	PRIMARY KEY CLUSTERED ([meu_id] ASC)
GO

ALTER TABLE [Inventory.movementconcepts] 
 ADD CONSTRAINT [PK_movementconpects]
	PRIMARY KEY CLUSTERED ([mco_id] ASC)
GO

ALTER TABLE [Inventory.movements] 
 ADD CONSTRAINT [PK_movements]
	PRIMARY KEY CLUSTERED ([mov_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_movements_movementconpects] 
 ON [Inventory.movements] ([mov_concept] ASC)
GO

ALTER TABLE [Inventory.stock] 
 ADD CONSTRAINT [PK_stock]
	PRIMARY KEY CLUSTERED ([war_id] ASC,[sto_id_ing] ASC)
GO

ALTER TABLE [Inventory.warehouses] 
 ADD CONSTRAINT [PK_warehouses]
	PRIMARY KEY CLUSTERED ([war_id] ASC)
GO

ALTER TABLE [Kitchen.dish_ingredients] 
 ADD CONSTRAINT [PK_dish_ingredients]
	PRIMARY KEY CLUSTERED ([dis_id] ASC,[ing_id] ASC,[measurement] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_dish_ingredients_dishes] 
 ON [Kitchen.dish_ingredients] ([dis_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_dish_ingredients_ingredients] 
 ON [Kitchen.dish_ingredients] ([ing_id] ASC)
GO

ALTER TABLE [Kitchen.dishes] 
 ADD CONSTRAINT [PK_dishes]
	PRIMARY KEY CLUSTERED ([dis_id] ASC)
GO

ALTER TABLE [Kitchen.ingredients] 
 ADD CONSTRAINT [PK_ingredients]
	PRIMARY KEY CLUSTERED ([ing_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ingredients_measurementunits] 
 ON [Kitchen.ingredients] ()
GO

ALTER TABLE [Sales.order_dishes] 
 ADD CONSTRAINT [PK_order_dishes]
	PRIMARY KEY CLUSTERED ([dis_id] ASC,[ord_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_order_dishes_dishes] 
 ON [Sales.order_dishes] ([dis_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_order_dishes_orders] 
 ON [Sales.order_dishes] ([ord_id] ASC)
GO

ALTER TABLE [Sales.orders] 
 ADD CONSTRAINT [PK_orders]
	PRIMARY KEY CLUSTERED ([ord_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_orders_dishes] 
 ON [Sales.orders] ()
GO

ALTER TABLE [Sales.orderstatus] 
 ADD CONSTRAINT [PK_orderstatus]
	PRIMARY KEY CLUSTERED ([ors_id] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [Inventory.conversions] ADD CONSTRAINT [FK_Inventory.conversions_Inventory.ingredient_measurements]
	FOREIGN KEY ([cvn_from_id_ingredient],[cvn_from_id_warehouse],[cvn_from_id_measurement]) REFERENCES [Inventory.ingredient_measurements] ([ims_id_ingredient],[ims_id_warehouse],[ims_id_measurement]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.conversions] ADD CONSTRAINT [FK_Inventory.conversions_Inventory.measurementunits]
	FOREIGN KEY ([cvn_to_id_measurement]) REFERENCES [Inventory.measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.ingredient_measurements] ADD CONSTRAINT [FK_Inventory.ingredient_measurements_Inventory.measurementunits]
	FOREIGN KEY ([ims_id_measurement]) REFERENCES [Inventory.measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.ingredient_measurements] ADD CONSTRAINT [FK_Inventory.ingredient_measurements_Inventory.stock]
	FOREIGN KEY ([ims_id_warehouse],[ims_id_ingredient]) REFERENCES [Inventory.stock] ([sto_id_ing],[war_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.movements] ADD CONSTRAINT [FK_Inventory.movements_Inventory.stock]
	FOREIGN KEY ([mov_warehouse_id],[mov_id_stock_ingredient]) REFERENCES [Inventory.stock] ([sto_id_ing],[war_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.movements] ADD CONSTRAINT [FK_movements_movementconpects]
	FOREIGN KEY ([mov_concept]) REFERENCES [Inventory.movementconcepts] ([mco_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.stock] ADD CONSTRAINT [FK_Inventory.stock_Inventory.warehouses]
	FOREIGN KEY ([war_id]) REFERENCES [Inventory.warehouses] ([war_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Inventory.stock] ADD CONSTRAINT [FK_Inventory.stock_Kitchen.ingredients]
	FOREIGN KEY ([sto_id_ing]) REFERENCES [Kitchen.ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Kitchen.dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [Kitchen.dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Kitchen.dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_ingredients]
	FOREIGN KEY ([ing_id]) REFERENCES [Kitchen.ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Kitchen.dish_ingredients] ADD CONSTRAINT [FK_Kitchen.dish_ingredients_Inventory.measurementunits]
	FOREIGN KEY ([measurement]) REFERENCES [Inventory.measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Sales.order_dishes] ADD CONSTRAINT [FK_order_dishes_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [Kitchen.dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Sales.order_dishes] ADD CONSTRAINT [FK_order_dishes_orders]
	FOREIGN KEY ([ord_id]) REFERENCES [Sales.orders] ([ord_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Sales.orders] ADD CONSTRAINT [FK_orders_employees]
	FOREIGN KEY ([ord_employee_id]) REFERENCES [HumanResource.employees] ([emp_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [Sales.orders] ADD CONSTRAINT [FK_orders_orderstatus]
	FOREIGN KEY ([ord_status]) REFERENCES [Sales.orderstatus] ([ors_id]) ON DELETE No Action ON UPDATE No Action
GO
