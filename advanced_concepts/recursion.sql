--Q1 Display number from 1 to 10 without using any in built functions

with recursion numbers as (
  select 1 as n 
  union select n+1
  from numbers
  where n<10)
  
select * from numbers;

--Q2 Find the hirarchy of employees under a given manager

with recursive emp_hirarchy as (
  select id,name, manger_id, designation, 1 as level
  from emp_details where name ='Asha'
  union
  select e.id,e.name, e.manger_id, e.designation 
  from emp_hirarchy H join emp_details e on 
  h.id = e.manager_id
)
Select * from emp_hirarchy


--Q3 Find Hirarchy of managers for give employee

with recursive emp_hirarchy as (
  select id,name, manger_id, designation, 1 as level
  from emp_details where name ='David'
  union
  select e.id,e.name, e.manger_id, e.designation 
  from emp_hirarchy H join emp_details e on 
  h.manager_id = e.id
)
Select * from emp_hirarchy
