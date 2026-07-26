select table_name
from information_schema.tables
where table_schema='public'
and table_name in
(
'business_reviews',
'business_orders',
'advertisements',
'business_inventory'
)
order by table_name;
