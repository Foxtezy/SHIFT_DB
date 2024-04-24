/* С целью повышения эффективности магазинов отделу маркетинга необходимы следующие отчёты за
предыдущий месяц. Отчёт формируется на дату запуска за предыдущий календарный месяц. */


/* a. Коды и названия товаров, по которым не было покупок. */
select code, name
from products
where id not in (select p.id
                 from products as p
                          join purchase_receipts pr on p.id = pr.product_id
                          join purchases p2 on p2.id = pr.purchase_id
                 where p2.datetime >= date_trunc('month', now()) - INTERVAL '1 month'
                   and p2.datetime < date_trunc('month', now()));

/* В разрезе магазинов имена и фамилии продавцов, которые не совершили ни одной продажи, */
select id, first_name, last_name
from employees
where id not in (select e.id
                 from employees as e
                          join purchases p on e.id = p.seller_id
                 where p.datetime >= date_trunc('month', now()) - INTERVAL '1 month'
                   and p.datetime < date_trunc('month', now()));
/* Вывожу ещё id т.к. могут существовать полные тёзки */


/* а также самых эффективных продавцов (по полученной выручке). */
select e.id, e.first_name, e.last_name, coalesce(sum(p.amount), 0) as total_amount
from employees as e
         left join purchases p on e.id = p.seller_id
where p.datetime >= date_trunc('month', now()) - INTERVAL '1 month'
  and p.datetime < date_trunc('month', now())
group by e.id, e.first_name, e.last_name
order by total_amount desc
limit 10;
/* вывожу топ 10 */

/* Выручка в разрезе регионов. Упорядочите результат по убыванию выручки. */
select s.region, coalesce(sum(p.amount), 0) as total_amount
from shops as s
         join public.employees e on e.shop_id = s.id
         join public.purchases p on e.id = p.seller_id
where p.datetime >= date_trunc('month', now()) - INTERVAL '1 month'
  and p.datetime < date_trunc('month', now())
group by s.region
order by total_amount desc;

/* Тут получается выручка только с тех товаров, которые были куплены с помощью продавцов.
   Если покупатель купил что-то сам, то это не учитывается здесь, хотя должно, но текущая схема этого не позволяет.
   Логично было бы связать PURCHASE и SHOPS, тогда было бы сильно проще
 */