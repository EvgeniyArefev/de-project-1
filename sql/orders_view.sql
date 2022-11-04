create or replace view analysis.orders as 
  select 
	   order_id
	  ,order_ts
	  ,user_id
	  ,bonus_payment
	  ,payment
	  ,cost
	  ,bonus_grant
	  ,status_id as status
  from (select 
			 o.order_id
			,o.order_ts
			,o.user_id
			,o.bonus_payment
			,o.payment
			,o.cost
			,o.bonus_grant
			,o2.dttm
			,o2.status_id
			,row_number() over (partition by o.order_id order by o.order_id, o2.dttm desc) as rn
		from production.orders o
		left join production.orderstatuslog o2
			on o.order_id = o2.order_id) t
  where rn = 1