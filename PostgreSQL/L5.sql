drop database if exists tcl;
create database tcl;

--N.B1: DDL(CREATE,ALTER,DROP,TRUNCATE) is auto committed in mysql,oracle but they are transactional (not auto committed) in postgresql.
--N.B2: To run a transaction select the whole begin to commit portion / begin to rollback portion and then click 'Run Selection'.
--Key points:
-- begin : Start a transaction. Changes are temporary until commit.
-- commit : Save all changes permanently.
-- rollback : Undo all changes in the transaction.
-- rollback to savepoint : Undo changes after a specific point.

--Here the table products will not be created cause rollback is used.
begin;
--create table products
create table if not exists products(
  id serial primary key,
  product_id varchar(50) not null,
  title varchar(30) not null,
  price numeric(10,2) not null,
  quantity int not null,
  isStock boolean default true
);

--insert data into table products
insert into products(product_id,title,price,quantity,isStock) values
('P-1001', 'Laptop', 850.00, 15, true),
('P-1002', 'Wireless Mouse', 25.50, 40, true),
('P-1003', 'Keyboard', 45.75, 0, false),
('P-1004', 'Monitor', 220.00, 8, true),
('P-1005', 'USB Flash Drive', 12.99, 0, false);
rollback;

--now the table products will be created cause rollback is not used before commit.
begin;
--create table products
create table if not exists products(
  id serial primary key,
  product_id varchar(50) not null,
  title varchar(30) not null,
  price numeric(10,2) not null,
  quantity int not null,
  isStock boolean default true
);

--insert data into table products
insert into products(product_id,title,price,quantity,isStock) values
('P-1001', 'Laptop', 850.00, 15, true),
('P-1002', 'Wireless Mouse', 25.50, 40, true),
('P-1003', 'Keyboard', 45.75, 0, false),
('P-1004', 'Monitor', 220.00, 8, true),
('P-1005', 'USB Flash Drive', 12.99, 0, false);
commit;


--Now, If you want to rollback the committed part but fails. If you want to drop the table then run the command and commit,But you are not allowed to rollback/undo the previously committed part.
begin;
rollback;

--this updation also not workes cause rolled back
begin;
update products set price=30.00 where id=2;
rollback;

--this updation works cause committed the transaction
begin;
update products set price=30.32 where id=2;
commit;
--now see in products table price of id=2 will 30.32 from 25.50


begin;
delete from products where id=5;
savepoint A;

delete from products where id=4;
savepoint B;

delete from products where id=3;
savepoint C;

rollback to A; 
-- now replace A with B and then C. rollback to savepoint indicates undo all changes after savepoint.
commit;