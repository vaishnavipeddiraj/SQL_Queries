create materialized view mv_random_tab
as
select id, avg(val), count(*)
from random_tab
group by id;

select * from mv_random_tab;
