insert into analysis.dm_rfm_segments
select 
	 u.id as user_id
	,trr.recency
	,trf.frequency
	,trmv.monetary_value
from (select distinct id 
	  from analysis.users) u
left join analysis.tmp_rfm_recency trr
	on u.id = trr.user_id
left join analysis.tmp_rfm_frequency trf
	on u.id = trf.user_id
left join analysis.tmp_rfm_monetary_value trmv
	on u.id = trmv.user_id
order by user_id


select *
from analysis.dm_rfm_segments
limit 10