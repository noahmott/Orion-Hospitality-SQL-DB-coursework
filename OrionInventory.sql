--Create all tables
CREATE TABLE oh_distributor(
	oh_distributorid int identity,
	oh_distributor_name varchar(20) NOT NULL,
	oh_distributor_email varchar(20),
	oh_distributor_phone_number varchar(15),
	oh_distributor_address varchar(40)
	--constraints
	CONSTRAINT PK_oh_distributor Primary Key (oh_distributorid),
	CONSTRAINT U1_oh_distributor UNIQUE (oh_distributor_name)
	)
	--end first table
CREATE TABLE oh_itemtype(
	oh_itemtypeid int identity primary key,
	oh_itemtype varchar(30) NOT NULL)
--create a rating scale table
CREATE TABLE oh_rating (
oh_ratingid int primary key
CONSTRAINT chk_rating CHECK (oh_ratingid>=1 AND oh_ratingid<=5))

CREATE TABLE oh_user(
oh_userid int identity primary key,
oh_username varchar(20) NOT NULL,
oh_user_email_address varchar(20) NOT NULL,
oh_userdescription varchar(500),
oh_userfollowedrestaurants varchar(50),
oh_userpoints_earned int NOT NULL
CONSTRAINT U1_oh_username UNIQUE (oh_username),
CONSTRAINT U1_oh_user_email_address UNIQUE (oh_user_email_address)
)

CREATE TABLE oh_followerlist (
oh_follower_listid int identity primary key,
oh_userid int NOT NULL,
oh_followerid int NOT NULL,
CONSTRAINT fk1_oh_followerlist FOREIGN KEY (oh_userid) REFERENCES oh_user(oh_userid),
CONSTRAINT fk2_oh_followerlist FOREIGN KEY (oh_followerid) REFERENCES oh_user(oh_userid)
)

CREATE TABLE oh_menu_item (
oh_menuid int identity primary key,
oh_menu_item_name varchar(30) NOT NULL,
oh_menu_item_description varchar(100),
oh_menu_item_price decimal(19,2) NOT NULL,
oh_ratingid int NOT NULL,
CONSTRAINT U1_oh_menu_item UNIQUE (oh_menu_item_name),
CONSTRAINT FK1_oh_menu_item FOREIGN KEY (oh_ratingid) REFERENCES oh_rating(oh_ratingid)
)

CREATE TABLE oh_store (
oh_storeid int identity primary key,
oh_store_name varchar(30) NOT NULL,
oh_store_phone_number varchar(15),
oh_store_address varchar(40),
oh_store_email_address varchar(20),
oh_ratingid int NOT NULL,
CONSTRAINT U1_oh_store UNIQUE (oh_store_name),
CONSTRAINT fk1_oh_store FOREIGN KEY (oh_ratingid) REFERENCES oh_rating(oh_ratingid)
)

CREATE TABLE oh_store_menu_item_list (
oh_store_menu_item_list_id int identity primary key,
oh_storeid int NOT NULL,
oh_menuid int NOT NULL,
CONSTRAINT fk1_oh_store_menu_item_list FOREIGN KEY (oh_storeid) REFERENCES oh_store(oh_storeid),
CONSTRAINT fk2_oh_store_menu_item_list FOREIGN KEY (oh_menuid) REFERENCES oh_menu_item(oh_menuid)
)

CREATE TABLE oh_brand (
oh_brandid int identity primary key,
oh_brand_name varchar(30) NOT NULL UNIQUE,
oh_distributorid int NOT NULL FOREIGN KEY REFERENCES oh_distributor(oh_distributorid)
)
CREATE TABLE oh_user_rating_list (
oh_user_rating_listid int identity primary key,
oh_ratingid int NOT NULL FOREIGN KEY REFERENCES oh_rating(oh_ratingid),
oh_userid int NOT NULL REFERENCES oh_user(oh_userid)
)

CREATE TABLE oh_inventory_item_list (
oh_inventoryid int identity primary key,
oh_inventory_item_name varchar (200) NOT NULL UNIQUE,
oh_item_cost decimal (19,2) NOT NULL,
oh_item_sell_price decimal (19,2) NOT NULL,
oh_item_description varchar (100),
oh_distributorid int NOT NULL FOREIGN KEY REFERENCES oh_distributor(oh_distributorid),
oh_brandid int NOT NULL FOREIGN KEY REFERENCES oh_brand(oh_brandid),
oh_itemtypeid int NOT NULL FOREIGN KEY REFERENCES oh_itemtype(oh_itemtypeid),
oh_ratingid int NOT NULL FOREIGN KEY REFERENCES oh_rating(oh_ratingid),
)
CREATE TABLE oh_store_inventory_item_list (
oh_store_inventory_item_listid int identity primary key,
oh_storeid int NOT NULL FOREIGN KEY REFERENCES oh_store(oh_storeid),
oh_inventoryid int NOT NULL FOREIGN KEY REFERENCES oh_inventory_item_list(oh_inventoryid)
)

CREATE TABLE oh_menuitem_inventoryitem_list (
oh_menuitem_inventoryitem_listid int identity primary key,
oh_menuid int foreign key references oh_menu_item(oh_menuid),
oh_inventoryid int foreign key references oh_inventory_item_list(oh_inventoryid)
)

DATA CREATION AND DATA MANIPULATION
--inserting data into tables

INSERT INTO oh_itemtype(oh_itemtype)
VALUES ('Wine'), ('Tequila'), ('Vermouth'), ('Vodka'), ('Whiskey'), ('Scotch'), ('Gin'), ('Cordial'), ('Sake'), ('Rum'), ('Beer'), ('Cognac'), ('Brandy')

ALTER TABLE oh_distributor ALTER COLUMN oh_distributor_address VARCHAR(4000)
ALTER TABLE oh_user ALTER COLUMN oh_userpoints_earned int NULL

INSERT INTO oh_distributor(oh_distributor_name, oh_distributor_address)
VALUES ('City Beverages', '10928 Florida Crown Dr. Orlando, FL'), ('Republic National', NULL), ('Southern Wine & Spirits', NULL), ('Florida Distribution Company', NULL), ('Pinnacle', NULL), ('Cavalier Distributing', '11760 Miramar Pkwy Suite 600, Miramar, FL')

INSERT into oh_distributor(oh_distributor_name)
values ('Breakthru Beverage')

INSERT into oh_store(oh_store_name, oh_store_phone_number, oh_store_address)
VALUES ('Swiggs', '(407) 906-5455', '50 E Central Blvd, Orlando, FL'), ('Nona Social', '(407) 674-7818', ' 9145 Narcoossee Rd, Orlando, FL'), ('Social House', '(407) 906-9001', '435 N Alafaya Trail, Orlando, FL'),
('Underground', '(407) 841-4000', '19 S Orange Ave, Orlando, FL')

INSERT INTO oh_rating(oh_ratingid)
VALUES (1), (2), (3), (4), (5)

INSERT INTO oh_user(oh_username, oh_user_email_address, oh_userdescription)
VALUES ('olddreadful', 'hueymadcow@icloud.com', 'A nice, rainy, battle.'), ('demurragedictator', 'hughiewierd@comcast.net', 'A better, important, pencil.'), ('equalkent', 'defeatedcurt@yahoo.com', 'A jealous, orange, map.'),
('molarrain', 'callieegoistic@sbcglobal.net', 'A rotten, delightful, dock.'),('signorunsavory', 'bittertel@yahoo.ca','A dusty, shy, day.'),('igloofilli', 'igloofilli', 'A alive, careful, face.'),('annoyancedecimal', 'beccanerd@aol.com', 'A cold, flat, girl.'),
('spinachparadigm', 'rejectedoli@protonmail.com', 'A bitter, flat, cherry.'),('corneliachancellor', 'disappointgreen@me.com', 'A lively, delightful, kiss.')

INSERT INTO oh_brand (oh_brand_name, oh_distributorid)
VALUES ('Avion', 10), ('Bacardi', 10), ('Belvedere', 11), ('Bombay', 10), ('Buffalo Trace', 10), ('Bulleit', 10), ('Captain Morgan', 10), ('Club Caribe', 10), ('3 Olives', 10),
('1800', 10), ('44 North', 15), ('Absolut', 11), ('Ancho Reyes', 15), ('Angels Envy', 15), ('Two Gingers', 15), ('Belvenie', 15), ('Crown', 11), ('Deep Eddy', 15), ('Dewars', 10), ('Di Amore', 10), ('Disoronno', 10), 
('Don Julio', 11), ('Dubouchett', 15), ('Finest Call', 15), ('Fireball', 10), ('Flor De Cana', 15), ('Gaetano', 11), ('Jack Daniels', 15), ('Glenfiddich', 10), ('Glenlivet', 10), ('Glenmorangie', 15), ('Goldschlager', 11),
('Gran Marnier', 11), ('Grey Goose', 11), ('Hendricks', 11), ('Jagermeister', 11), ('Jameson', 15), ('Jim Beam', 11), ('Johnnie Walker', 11), ('Kahlua', 11), ('Ketel One', 11), ('Knob Creek', 11), ('Kraken', 10),
('Macallan', 10), ('Makers Mark', 11), ('Malibu', 10), ('Martini Rossi', 11), ('McCormick', 15), ('Monkey Shoulder', 10), ('Myers', 10), ('New Amsterdam', 15), ('Nolets', 11), ('Old Camp', 15), ('Old Forester', 11),
('Patron', 11), ('Prarie', 11), ('Ramazotti', 11), ('Remy Martin', 15), ('Ron Zacapa', 10), ('Rumchata', 15), ('Rumplemintz', 11), ('Sailor Jerry', 11), ('Seagrams', 11), ('Southern Comfort', 11), ('Tanqueray', 11), 
('Terremoto', 11), ('Titos', 11), ('Wild Turkey', 11), ('Woodford', 11), ('Zodiac', 15), ('3 Daughters', 9), ('Goose Island', 9), ('Amstel', 9), ('Ballast Pointe', 9), ('Bells', 14), ('Big Storm', 9), ('Blue Moon', 12),
('Bold City', 9), ('Breckinridge', 12), ('Brooklyn', 12), ('Budweiser', 9), ('Cigar City', 12), ('Coors', 12), ('Coppertail', 12), ('Corona', 12), ('Crooked Can', 12), ('Dogfishhead', 9), ('Founders', 12), ('Funky Buddha', 12),
('Guinness', 12), ('Heineken', 12), ('Kona', 9), ('Lagunitas', 9), ('Left Hand', 14), ('Michelob', 9), ('Miller', 12), ('New Belgium', 12), ('New Castle', 12), ('Not Your Fathers', 12), ('PBR', 9), ('Rekorderlig', 12),
('Tampa Bay Brewing', 12), ('Shocktop', 9), ('Stella', 9), ('Sweetwater', 9), ('Victory', 9), ('Woodchuck', 9), ('Yuengling', 12), ('Austerity', 11), ('Butternut', 15), ('Capasaldo', 10), ('Chloe', 11), ('Hess', 11),
('Matua', 10), ('Minuty', 15), ('San Angelo', 10), ('Slow Press', 10), ('St Supery', 10), ('Trivento', 15), ('Chandon', 11), ('Wycliff', 15), ('Veuve', 11), ('Sterling', 10), ('Red Bull', 15), ('Zing Zang', 15), ('Gosling', 15)
INSERT INTO oh_inventory_item_list (oh_inventory_item_name, oh_item_cost, oh_item_sell_price, oh_item_description, oh_distributorid, oh_brandid, oh_itemtypeid, oh_ratingid, oh_quantity_on_hand)
VALUES ('Two Gingers Irish Whiskey', 13.50, 4.00, 15, 15,5,4,12)

--added an additional category to item type
INSERT INTO oh_itemtype (oh_itemtype)
VALUES ('Champagne')

--various updates to imported data
ALTER TABLE oh_inventory ALTER COLUMN oh_saleprice decimal(19,2)
ALTER TABLE oh_inventory WITH NOCHECK ADD CONSTRAINT fk3_oh_inventory FOREIGN KEY (oh_brandid) REFERENCES oh_brand(oh_brandid)
--cleared column to change data type by replacing whitespace with null values
UPDATE oh_inventory SET [oh_saleprice ]= REPLACE([oh_saleprice ],'', NULL)
--made adjustments to foreign keys and primary keys to account for imported data
ALTER TABLE oh_inventory add oh_inventoryid int identity NOT NULL
ALTER TABLE oh_store_inventory_item_list ADD CONSTRAINT fk1_oh_store_inventory_item_list FOREIGN KEY (oh_inventoryid) REFERENCES oh_inventory(oh_inventoryid)
ALTER TABLE oh_store_inventory_item_list ADD oh_inventoryid int
ALTER TABLE oh_store_inventory_item_list ADD CONSTRAINT fk1_oh_store_inventory_item_list FOREIGN KEY (oh_inventoryid) REFERENCES oh_inventory(oh_inventoryid)
ALTER TABLE oh_menuitem_inventoryitem_list ADD oh_inventoryid int FOREIGN KEY REFERENCES oh_inventory(oh_inventoryid)

--added a count column for inventory of items per store
ALTER TABLE oh_store_inventory_item_list ADD oh_itemcount int
SELECT* FROM oh_store_inventory_item_list
SELECT * FROM oh_store
ALTER TABLE oh_store_inventory_item_list ALTER COLUMN oh_storeid int NULL
ALTER TABLE oh_store_inventory_item_list ADD CONSTRAINT fk2_oh_store_inventory_item_list FOREIGN KEY (oh_storeid) REFERENCES oh_store(oh_storeid)

--copy data from master list into store inventory item list
INSERT INTO oh_store_inventory_item_list
                         (oh_inventoryid)
SELECT        oh_inventory.oh_inventoryid
FROM            oh_inventory
--replaced null values with a store id of 3 because the master list comes from one store.
UPDATE oh_store_inventory_item_list SET oh_storeid = 5 WHERE oh_storeid IS NULL

--Created A company level inventory overview view

CREATE VIEW oh_inventoryoverview AS
select oh_store.oh_store_name as 'Store', oh_inventory.oh_itemname as 'Inventory Item' , oh_distributor.oh_distributor_name as 'Distributor', oh_itemtype.oh_itemtype as 'Item Type', oh_store_inventory_item_list.oh_inventorycostperstore as 'Unit Cost', 
oh_store_inventory_item_list.oh_itemcount as 'Counts', CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2)) as 'Inventory on hand'
from oh_store_inventory_item_list
JOIN oh_inventory on oh_store_inventory_item_list.oh_inventoryid=oh_inventory.oh_inventoryid
JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
JOIN oh_distributor on oh_inventory.oh_distributorid = oh_distributor.oh_distributorid
JOIN oh_itemtype on oh_inventory.oh_itemtypeid = oh_itemtype.oh_itemtypeid

--create an inventory view for each store
CREATE VIEW oh_Swiggsinventory as
select oh_inventory.oh_itemname as 'Inventory Item' , oh_distributor.oh_distributor_name as 'Distributor', 
oh_itemtype.oh_itemtype as 'Item Type', oh_store_inventory_item_list.oh_inventorycostperstore as 'Unit Cost', 
oh_store_inventory_item_list.oh_itemcount as 'Counts', CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2)) as 'Inventory on hand'
from oh_store_inventory_item_list
JOIN oh_inventory on oh_store_inventory_item_list.oh_inventoryid=oh_inventory.oh_inventoryid
JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
JOIN oh_distributor on oh_inventory.oh_distributorid = oh_distributor.oh_distributorid
JOIN oh_itemtype on oh_inventory.oh_itemtypeid = oh_itemtype.oh_itemtypeid
where oh_store.oh_store_name='Swiggs'

CREATE VIEW oh_Nonainventory as
select oh_inventory.oh_itemname as 'Inventory Item' , oh_distributor.oh_distributor_name as 'Distributor', 
oh_itemtype.oh_itemtype as 'Item Type', oh_store_inventory_item_list.oh_inventorycostperstore as 'Unit Cost', 
oh_store_inventory_item_list.oh_itemcount as 'Counts', CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2)) as 'Inventory on hand'
from oh_store_inventory_item_list
JOIN oh_inventory on oh_store_inventory_item_list.oh_inventoryid=oh_inventory.oh_inventoryid
JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
JOIN oh_distributor on oh_inventory.oh_distributorid = oh_distributor.oh_distributorid
JOIN oh_itemtype on oh_inventory.oh_itemtypeid = oh_itemtype.oh_itemtypeid
where oh_store.oh_store_name='Nona Social'

CREATE VIEW oh_Undergroundinventory as
select oh_inventory.oh_itemname as 'Inventory Item' , oh_distributor.oh_distributor_name as 'Distributor', 
oh_itemtype.oh_itemtype as 'Item Type', oh_store_inventory_item_list.oh_inventorycostperstore as 'Unit Cost', 
oh_store_inventory_item_list.oh_itemcount as 'Counts', CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2)) as 'Inventory on hand'
from oh_store_inventory_item_list
JOIN oh_inventory on oh_store_inventory_item_list.oh_inventoryid=oh_inventory.oh_inventoryid
JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
JOIN oh_distributor on oh_inventory.oh_distributorid = oh_distributor.oh_distributorid
JOIN oh_itemtype on oh_inventory.oh_itemtypeid = oh_itemtype.oh_itemtypeid
where oh_store.oh_store_name='Underground'

CREATE VIEW oh_SocialHouseinventory as
select oh_inventory.oh_itemname as 'Inventory Item' , oh_distributor.oh_distributor_name as 'Distributor', 
oh_itemtype.oh_itemtype as 'Item Type', oh_store_inventory_item_list.oh_inventorycostperstore as 'Unit Cost', 
oh_store_inventory_item_list.oh_itemcount as 'Counts', CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2)) as 'Inventory on hand'
from oh_store_inventory_item_list
JOIN oh_inventory on oh_store_inventory_item_list.oh_inventoryid=oh_inventory.oh_inventoryid
JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
JOIN oh_distributor on oh_inventory.oh_distributorid = oh_distributor.oh_distributorid
JOIN oh_itemtype on oh_inventory.oh_itemtypeid = oh_itemtype.oh_itemtypeid
where oh_store.oh_store_name='Social House'


--test updating data in view
UPDATE oh_inventoryoverview SET [Unit Cost] = 5.00 where [Inventory Item] = '1800 Reposado' AND Store = 'Swiggs'

select * from oh_inventoryoverview
order by [Item Type]

--View of Total inventory cost on hand per store
Create View oh_inventorycostperstoretotals as
select oh_store.oh_store_name as 'Store', SUM(CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2))) as 'Inventory on hand'
from oh_store_inventory_item_list JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
where oh_store.oh_store_name ='Social House'
group by oh_store_name
UNION
select oh_store.oh_store_name as 'Store', SUM(CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2))) as 'Inventory on hand'
from oh_store_inventory_item_list JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
where oh_store.oh_store_name ='Swiggs'
group by oh_store_name
UNION
select oh_store.oh_store_name as 'Store', SUM(CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2))) as 'Inventory on hand'
from oh_store_inventory_item_list JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
where oh_store.oh_store_name ='Nona Social'
group by oh_store_name
UNION
select oh_store.oh_store_name as 'Store', SUM(CAST(ROUND((oh_store_inventory_item_list.oh_inventorycostperstore * oh_store_inventory_item_list.oh_itemcount), 2) as decimal (19,2))) as 'Inventory on hand'
from oh_store_inventory_item_list JOIN oh_store on oh_store_inventory_item_list.oh_storeid = oh_store.oh_storeid
where oh_store.oh_store_name ='Underground'
group by oh_store_name

--computed totals of inventory cost for the company
CREATE VIEW oh_oriontotalinventorycost as
select SUM([Inventory on hand])as 'Orion Inventory Cost Totals' from oh_inventorycostperstoretotals 

--cleared out all counts in inventory carried from excel
UPDATE oh_inventoryoverview SET Counts=0.00 where Store='Social House'


--created function that looks up distributor for a given inventory item
CREATE FUNCTION dbo.oh_distributorlookup (@itemname varchar(30))
RETURNS varchar(30) as
BEGIN 
	DECLARE @returnValue varchar(30)
	SELECT @returnValue = [Distributor] FROM oh_inventoryoverview
	WHERE [Inventory Item] = @itemname
	RETURN @returnValue
END
GO

--procedures for updating cost and counts in each store inventory
CREATE PROCEDURE oh_updatenonacost(@inventoryitem varchar(30), @newcost decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_Nonainventory SET [Unit Cost] = @newcost
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecountnona(@inventoryitem varchar(30), @newcount decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_Nonainventory SET Counts = @newcount
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecostswiggs(@inventoryitem varchar(30), @newcost decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_SwiggsInventory SET [Unit Cost] = @newcost
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecountswiggs(@inventoryitem varchar(30), @newcount decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_SwiggsInventory SET Counts = @newcount
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecostug(@inventoryitem varchar(30), @newcost decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_Undergroundinventory SET [Unit Cost] = @newcost
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecountug (@inventoryitem varchar(30), @newcount decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_Undergroundinventory SET Counts = @newcount
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecostsh(@inventoryitem varchar(30), @newcost decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_SocialHouseinventory SET [Unit Cost] = @newcost
	WHERE [Inventory Item] = @inventoryitem
END
GO

CREATE PROCEDURE oh_updatecountsh (@inventoryitem varchar(30), @newcount decimal (19,2) NULL)
AS 
BEGIN
	UPDATE oh_SocialHouseinventory SET Counts = @newcount
	WHERE [Inventory Item] = @inventoryitem
END
GO

drop procedure oh_addtoinventory

--This procedure updates the inventory per store and in the standard inventory. the parameters are required in order to adequately display the information in views because of how the joins are set up in views.

CREATE PROCEDURE oh_addtoinventory (@itemname varchar(30), @storename varchar(30), @itemtype varchar (30), @distributor varchar(30))
AS
IF EXISTS (SELECT oh_itemname FROM oh_inventory where @itemname=oh_itemname)
	BEGIN 
	PRINT 'This item is already in the Orion Hospitality Inventory'
	END
ELSE
	BEGIN

	DECLARE @RETURNVARIABLE int
	SELECT @RETURNVARIABLE = oh_itemtypeid from oh_itemtype where @itemtype = oh_itemtype.oh_itemtype

	DECLARE @distributorid int
	SELECT @distributorid = oh_distributorid from oh_distributor where @distributor = oh_distributor.oh_distributor_name

	INSERT INTO oh_inventory (oh_itemname, oh_itemtypeid, oh_distributorid) values (@itemname, @RETURNVARIABLE, @distributorid)

	DECLARE @storeid int
	SELECT @storeid = oh_storeid FROM oh_store where @storename = oh_store.oh_store_name

	DECLARE @inventoryid int
	select @inventoryid = oh_inventoryid from oh_inventory where @itemname = oh_inventory.oh_itemname

	INSERT INTO oh_store_inventory_item_list (oh_inventoryid, oh_storeid)
	VALUES (@inventoryid, @storeid)

	RETURN @@identity
	END
	GO
	

--Created a log for user ratings by date
CREATE VIEW oh_RatingLog1
AS
select oh_user.oh_username as 'User Name' , oh_inventory.oh_itemname as 'Rated Item', oh_rating.oh_ratingid as 'Rating', oh_store.oh_store_name as 'Location', oh_ratingdate as 'Date Rated'
from oh_user_rating_list
JOIN oh_rating on oh_user_rating_list.oh_ratingid=oh_rating.oh_ratingid
JOIN oh_user on oh_user.oh_userid=oh_user_rating_list.oh_userid
JOIN oh_inventory on oh_inventory.oh_inventoryid = oh_user_rating_list.oh_inventoryid
LEFT JOIN oh_store on oh_store.oh_storeid= oh_user_rating_list.oh_storeid

--Created a view for the average user rating of each inventory item
CREATE VIEW oh_inventoryratingaverages
AS
SELECT oh_inventory.oh_itemname as 'Inventory Item', ROUND(AVG(CAST(oh_ratingid AS FLOAT)), 1) as 'Average User Rating', COUNT (oh_ratingid) as 'Number of Ratings' FROM oh_user_rating_list
LEFT JOIN oh_inventory on oh_inventory.oh_inventoryid = oh_user_rating_list.oh_inventoryid
group by oh_itemname

--LOOK AT PREVIOUSLY CREATED SCHEMAS
select ROUTINE_NAME from IST659_M402_nomott.INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE'

EXEC oh_addrating 'olddreadful', 'Gentlemen Jack', 5, 'Swiggs'

SELECT * FROM oh_RatingLog1
where [User Name] = 'olddreadful'

--procedure to add inventory items for the individual stores that checks first to see if the item already exists in the global inventory then checks to see if it exists in the store's inventory presenting messages as necessary.
create procedure oh_update_store_inventory_item_list (@item varchar(30), @storename varchar(30))
AS
	DECLARE @RETURNVARIABLE int
	SELECT @RETURNVARIABLE = oh_inventoryid from oh_inventory where @item = oh_inventory.oh_itemname

	DECLARE @RETURNVARIABLE2 int 
	select @RETURNVARIABLE2 = oh_storeid from oh_store where @storename = oh_store.oh_store_name

if not exists (SELECT oh_itemname FROM oh_inventory where @item=oh_itemname)
begin
PRINT 'This item does not exist in the Orion Inventory. Please add it to the inventory list'
end
ELSE IF exists (select * from oh_store_inventory_item_list where @RETURNVARIABLE2=oh_storeid AND @RETURNVARIABLE = oh_inventoryid) 
BEGIN
PRINT 'This item already exists in this store inventory'
end
else
begin
insert into oh_store_inventory_item_list (oh_storeid, oh_inventoryid)
VALUES (@RETURNVARIABLE2, @RETURNVARIABLE)
return @@identity
END
GO
