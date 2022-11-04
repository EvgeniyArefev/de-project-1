with users_with_order_info as (
	select 
	   u.id
	  ,o.order_id
	  ,o.order_ts
	  ,o.payment
	  ,o.status
	  ,o2.key as stutus_discr
	from analysis.users u
	left join analysis.orders o
	  on u.id = o.user_id
	  and extract(year from o.order_ts)::int = 2022
    left join analysis.orderstatuses o2
	  on o.status = o2.id
   order by u.id
), group_borders as (
	  select 
		   count(distinct id) as cnt_id
		  ,round(count(distinct id) * 0.2) as group_1
		  ,round(count(distinct id) * 0.4) as group_2
		  ,round(count(distinct id) * 0.6) as group_3
		  ,round(count(distinct id) * 0.8) as group_4
		  ,count(distinct id) as group_5
	  from users_with_order_info
 ), agregate_for_monetary_value_1 as (
	select 
		 id
		,coalesce(sum(case when stutus_discr = 'Closed' then payment end), 0) as sum_payment
   		,count(case when stutus_discr = 'Closed' then order_id end) as cnt_order
	from users_with_order_info
	group by id 
 ), agregate_for_monetary_value_2 as (
   select 
	   id
	  ,row_number() over (order by sum_payment) as rn
   from agregate_for_monetary_value_1
 )
 
 insert into analysis.tmp_rfm_monetary_value
 select 
    id as user_id
	,case 
	  when rn <= (select group_1 from group_borders) then 1 
	  when rn <= (select group_2 from group_borders) then 2 
	  when rn <= (select group_3 from group_borders) then 3 
	  when rn <= (select group_4 from group_borders) then 4 
	  when rn <= (select group_5 from group_borders) then 5 
	end as monetary_value 
from agregate_for_monetary_value_2
 order by monetary_value, user_id