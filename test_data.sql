create schema if not exists faker;
create extension if not exists faker schema faker cascade;

truncate products cascade;
truncate employees cascade;
truncate products cascade;
truncate purchases cascade;
truncate purchase_receipts cascade;

ALTER SEQUENCE employees_id_seq RESTART WITH 1;
ALTER SEQUENCE products_id_seq RESTART WITH 1;
ALTER SEQUENCE purchases_id_seq RESTART WITH 1;
ALTER SEQUENCE shops_id_seq RESTART WITH 1;

insert into products (code, name)
select md5(random()::text), faker.word()
from generate_series(1, 200) on conflict do nothing;


insert into employees (first_name, last_name, phone, e_mail, job_name)
select faker.first_name(), faker.last_name(), faker.phone_number(), faker.email(), substring(faker.job(), 1, 50)
from generate_series(1, 1000);

insert into shops (name, region, city, address, manager_id)
select faker.company(), faker.state(), faker.city(), faker.address(), id
from employees ORDER BY random() LIMIT 100;

update employees SET shop_id =
    (select id + length(e_mail) - length(e_mail) from shops order by random() limit 1);

/* length(e_mail) - length(e_mail) это черная магия которая заставляет думать postgres думать,
   что подзапрос каждый раз возвращает разные данные (что на самом деле так и есть) и выполнять его на каждый shop_id
 */
update employees SET shop_id = null where random() > 0.9;

insert into purchases (datetime, amount)
select faker.date_between()::DATE + (random() * interval '1d'), ceil(random() * 10000)
from generate_series(1, 10000);

update purchases SET seller_id =
                         (select id + amount - amount from employees order by random() limit 1);

insert into purchase_receipts (purchase_id, ordinal_number, product_id, quantity, amount_full, amount_discount)
select purchases.id, ceil(random() * 10), products.id, ceil(random() * 10), ceil(random() * 100), ceil(random() * 100)
from products, purchases
order by random() on conflict do nothing;




