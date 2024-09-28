DELIMITER $$ -- default delimiter is ; sql will not continue code once it sees the delimiter
--postgresql
create or replace procedure pr_buy_products()
language plpgsql
as $$ 
declare
  v_product_code varchar(20),
  v_price         float;
begin
  select product_code, price  
  into v_product_code, v_price
  from products 
  where product_name ="Iphone 13 Pro Max";

  insert into sales(order_date, product_code, quantity_ordered, sale_price)
  values(current_date, v_product_code, 1,(v_price*1))

  update products
  set quantity_remaining = (quantity_remaining-1),
    quantity_sold =(quantity_sold+1)
    where product_code= v_product_code;

  raise notice 'Products_sold'
end;
$$

-- in new tab
call pr_buy_products()


--Oracle
create or replace procedure pr_buy_products -- no need to provide () when you dont have parameters. no delimiters needed
declare
  v_product_code varchar(20),
  v_price         float;
begin
  select product_code, price  
  into v_product_code, v_price
  from products 
  where product_name ="Iphone 13 Pro Max";

  insert into sales(order_date, product_code, quantity_ordered, sale_price)
  values(current_date, v_product_code, 1,(v_price*1))

  update products
  set quantity_remaining = (quantity_remaining-1),
    quantity_sold =(quantity_sold+1)
    where product_code= v_product_code;

  dbms_output.putline( 'Products_sold');-- output line
end;

-- in new tab
exec pr_buy_products;


--MSSQL
create or alter procedure pr_buy_products -- no need to provide () when you dont have parameters. no delimiters needed. replace doesnt work
as
  declare
    @v_product_code varchar(20),
    @v_price         float;
begin
  select product_code= @v_product_code, price  =@v_price
   
  from products 
  where product_name ="Iphone 13 Pro Max";

  insert into sales(order_date, product_code, quantity_ordered, sale_price)
  values(cast(getdate()as date), @v_product_code, 1,(@v_price*1))

  update products
  set quantity_remaining = (quantity_remaining-1),
    quantity_sold =(quantity_sold+1)
    where product_code= v_product_code;

  print('Products_sold');-- output line
end;

-- in new tab
exec pr_buy_products;


drop procedure if exists pr_buy_products;

--
create or replace procedure pr_buy_products(p_product_name varchar, p_quantity int)
language plpgsql
as $$ 
declare
  v_product_code varchar(20),
  v_price         float;
  v_cnt            int;
begin
  select count (*)
  into v_cnt
  from products
  where product_name= p_product_name and quantity_remaining >=p_quantity; 
  if v_cnt>0 then
    select product_code, price  
    into v_product_code, v_price
    from products 
    where product_name ="Iphone 13 Pro Max";
  
    insert into sales(order_date, product_code, quantity_ordered, sale_price)
    values(current_date, v_product_code, 1,(v_price*1))
  
    update products
    set quantity_remaining = (quantity_remaining-p_quantity),
      quantity_sold =(quantity_sold+p_quantity)
      where product_code= v_product_code;
  
    raise notice 'Products_sold'
      else
      raise notice 'insufficient Quantity';
end;


call pr_buy_products('ipad Air', 1);
