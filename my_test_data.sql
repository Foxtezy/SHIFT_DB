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
values ('111', 'Ложка'), ('112', 'Вилка'), ('113', 'Атомно эмиссионный масс спектрометр');

insert into employees (first_name, last_name, phone, e_mail, job_name)
values ('Иван', 'Иванов', '+79604353390', 'aboba228@gmail.com', 'Продавец'),
       ('Михал', 'Палыч', '+79604323390', 'aboba1337@gmail.com', 'Управляющий'),
       ('Хидео', 'Кодзима', '+79604351390', 'metal_geer@gmail.com', 'Продавец'),
       ('Наруто', 'Узумаки', '+79604312390', 'hokage228@gmail.com', 'Продавец'),
       ('Абоба', 'Абобович', '+19604353390', 'aboba@gmail.com', 'Продавец');

insert into shops (name, region, city, address, manager_id)
values ('shop1', 'Siberia', 'Tomsk', 'Ленина 23', 3),
       ('shop2', 'Moscow', 'Moskva', 'Неглинная 2', 4);

update employees SET shop_id = 1 WHERE employees.id <= 3;
update employees SET shop_id = 2 WHERE employees.id > 3;

insert into purchases (datetime, amount, seller_id)
values (now() - interval '2d', 1000, 1),
       (now() - interval '5d', 2000, 3),
       (now() - interval '40d', 3000, 2),
       (now() - interval '40d', 4000, 4),
       (now() - interval '41d', 5000, null),
       (now() - interval '35d', 6000, 1);


insert into purchase_receipts (purchase_id, ordinal_number, product_id, quantity, amount_full, amount_discount)
values (1, 1, 1, 2, 300, 0),
       (1, 2, 2, 1, 720, 20),
       (2, 1, 2, 3, 2100, 100),
       (3, 1, 2, 1, 4000, 100),
       (3, 2, 1, 2, 300, 0),
       (4, 1, 2, 2, 1300, 0),
       (4, 2, 1, 1, 2000, 0),
       (4, 3, 1, 2, 800, 100),
       (5, 1, 2, 2, 6000, 2000),
       (5, 2, 1, 2, 1000, 0),
       (6, 1, 2, 1, 4000, 0),
       (6, 2, 2, 2, 1500, 0),
       (6, 3, 1, 2, 500, 0);




