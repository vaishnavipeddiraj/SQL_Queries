--Recyclable and Low Fat Products
select product_id
from Products
where low_fats='Y' and recyclable ='Y'

--Find Customer Referee
select name
from Customer
where referee_id is null or referee_id !=2

--Big Countries
select name, population, area 
from World
where area >=3000000 or population >= 25000000

--Article Views I
select distinct(author_id) as id
from views
where author_id = viewer_id
order by author_id

--Invalid Tweets
select tweet_id 
from tweets
where length(content) >15


-------------joins----------------------
--Replace Employee ID With The Unique Identifier
select uni.unique_id, e.name
from employees e
left join EmployeeUNI uni
on e.id = uni.id

--Product Sales Analysis
select p.product_name, s.year, s.price
from sales s
join product p
on p.product_id = s.product_id
