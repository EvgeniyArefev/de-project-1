create view analysis.users as 
select *
from production.users us;

create view analysis.orders as 
select *
from production.orders o;

create view analysis.orderstatuses as 
select *
from production.orderstatuses o;

create view analysis.orderitems as 
select *
from production.orderitems;

create view analysis.products as 
select *
from production.products;