drop table if exists EMPLOYEES cascade;
drop table if exists SHOPS cascade;
drop table if exists PRODUCTS cascade;
drop table if exists PURCHASES cascade;
drop table if exists PURCHASE_RECEIPTS cascade;

create table EMPLOYEES
(
    ID         bigint primary key generated always as identity,
    FIRST_NAME varchar(100) not null check (FIRST_NAME <> '' ),
    LAST_NAME  varchar(100) not null check (LAST_NAME <> '' ),
    PHONE      varchar(50)  not null check (PHONE <> '' ),
    E_MAIL     varchar(50)  not null check (E_MAIL <> '' ),
    JOB_NAME   varchar(50)  not null check (JOB_NAME <> '' )
);

create table SHOPS
(
    ID         bigint primary key generated always as identity,
    NAME       varchar(200) not null check ( NAME <> '' ),
    REGION     varchar(200) not null check ( REGION <> '' ),
    CITY       varchar(200) not null check ( CITY <> '' ),
    ADDRESS    varchar(200) not null check ( ADDRESS <> '' ),
    MANAGER_ID bigint       not null references EMPLOYEES
);

alter table EMPLOYEES
    add column SHOP_ID bigint references SHOPS;

comment on table EMPLOYEES is 'Список всех сотрудников компании';
comment on column EMPLOYEES.job_name is 'Должность, например, «Продавец-консультант», «Управляющий», «Бухгалтер», «Уборщик» и т.д.';
comment on column EMPLOYEES.shop_id is 'Ссылка на магазин, в котором работает сотрудник (если сотрудник не закреплён за конкретным магазином, то данное поле не заполняется)';

comment on table SHOPS is 'Список магазинов с их адресами';
comment on column SHOPS.manager_id is 'Ссылка на сотрудника, который является директором магазина';

create table PRODUCTS
(
    ID   bigint primary key generated always as identity,
    CODE varchar(50) unique not null check (CODE <> '' ),
    NAME varchar(200)       not null check (NAME <> '' )
);

comment on table PRODUCTS is 'Товарный каталог';

create table PURCHASES
(
    ID        bigint primary key generated always as identity,
    DATETIME  timestamp not null,
    AMOUNT    int       not null check ( AMOUNT > 0 ),
    SELLER_ID bigint references EMPLOYEES
);

comment on table PURCHASES is 'Покупки';
comment on column PURCHASES.datetime is 'Дата и время совершения покупки';
comment on column PURCHASES.amount is 'Уплаченная покупателем сумма покупки с учётом всех скидок';
comment on column PURCHASES.seller_id is 'Ссылка на сотрудника, который совершил продажу (данное поле не заполняется, если сделка была совершена без помощи продавца, например, клиент самостоятельно выбрал товар и обратился в пункт выдачи)';

create table PURCHASE_RECEIPTS
(
    PURCHASE_ID     bigint not null references PURCHASES,
    ORDINAL_NUMBER  int    not null check ( QUANTITY > 0 ),
    PRODUCT_ID      bigint not null references PRODUCTS,
    QUANTITY        int    not null check ( QUANTITY > 0 ),
    AMOUNT_FULL     int    not null check ( AMOUNT_FULL > 0 ),
    AMOUNT_DISCOUNT int    not null check ( AMOUNT_DISCOUNT >= 0 ),
    primary key (PURCHASE_ID, ORDINAL_NUMBER)
);

comment on table PURCHASE_RECEIPTS is 'Чеки покупок';
comment on column PURCHASE_RECEIPTS.ordinal_number is 'Порядковый номер позиции в чеке';
comment on column PURCHASE_RECEIPTS.product_id is 'Ссылка на товар';
comment on column PURCHASE_RECEIPTS.quantity is 'Количество купленного товара';
comment on column PURCHASE_RECEIPTS.amount_full is 'Полная стоимость товара (для данного количества товара и без учёта скидок)';
comment on column PURCHASE_RECEIPTS.amount_discount is 'Предоставленная на товар скидка (может быть от 0 до 100% стоимости товара)';