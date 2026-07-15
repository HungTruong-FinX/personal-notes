select c.full_name_en, ca.vikki_account_number, cni."number"
from customer_national_id cni 
left join customer_account ca
on cni.cif_number = ca.cif_number
left join customer c
on cni.cif_number = c.cif_number
where cni."number" not like 'B%'
and cni.id < 60874
and length(cni."number") = 12
and c.status = 'Active'
and ca.cbs_account_status = 'Open'
and c.customer_tenant = 'VIKKI_BANK'
and c.vikki_account_number not in (
'333325363',
'886600158',
'886602732')
order by cni.id desc 
limit 1000;