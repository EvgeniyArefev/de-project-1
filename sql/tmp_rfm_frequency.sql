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
 ), agregate_for_frequency as (
   select 
	   id
	  ,count(case when stutus_discr = 'Closed' then order_id end) as cnt_order
	  ,row_number() over (order by count(case when stutus_discr = 'Closed' then order_id end)) as rn
  from users_with_order_info
  group by id 
 )
 
insert into analysis.tmp_rfm_frequency
 select 
 	id as user_id
	,case 
	  when rn <= (select group_1 from group_borders) then 1 
	  when rn <= (select group_2 from group_borders) then 2 
	  when rn <= (select group_3 from group_borders) then 3 
	  when rn <= (select group_4 from group_borders) then 4 
	  when rn <= (select group_5 from group_borders) then 5 
	end as frequency 
 from agregate_for_frequency
 order by frequency, user_id