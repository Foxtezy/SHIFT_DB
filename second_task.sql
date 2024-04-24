/* Выяснилось, что в результате программного сбоя в части магазинов в некоторые дни полная
стоимость покупки не бьётся с её разбивкой по товарам. Выведите такие магазины и дни, в которые в
них случился сбой, а также сумму расхождения между полной стоимостью покупки и суммой по чеку. */

select s.id, s.name, date_trunc('day', p.datetime)::date as day, sum(p.amount) - (sum(pr.amount_full) - sum(pr.amount_discount)) as div
from shops as s
         join public.employees e on e.shop_id = s.id
         join public.purchases p on e.id = p.seller_id
         join public.purchase_receipts pr on p.id = pr.purchase_id
group by s.id, s.name, day
having sum(p.amount) != sum(pr.amount_full) - sum(pr.amount_discount);


select s.id, s.name, date_trunc('day', p.datetime)::date as day, sum(p.amount) - (sum(pr.amount_full) - sum(pr.amount_discount)) as div
from shops as s
         join public.employees e on e.shop_id = s.id
         join public.purchases p on e.id = p.seller_id
         join public.purchase_receipts pr on p.id = pr.purchase_id
group by s.id, s.name, day;

select *
from shops as s
         join public.employees e on e.shop_id = s.id
         join public.purchases p on e.id = p.seller_id
         join public.purchase_receipts pr on p.id = pr.purchase_id