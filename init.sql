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
    MANAGER_ID bigint not null references EMPLOYEES
);

alter table EMPLOYEES
    add column SHOP_ID bigint references SHOPS;

create table PRODUCTS
(
    ID   bigint primary key generated always as identity,
    CODE varchar(50) unique not null check (CODE <> '' ),
    NAME varchar(200)       not null check (NAME <> '' )
);

create table PURCHASES
(
    ID        bigint primary key generated always as identity,
    DATETIME  timestamp not null,
    AMOUNT    int       not null check ( AMOUNT > 0 ),
    SELLER_ID bigint references EMPLOYEES
);

create table PURCHASE_RECEIPTS
(
    PURCHASE_ID     bigint not null references PURCHASES,
    ORDINAL_NUMBER  int    not null check ( QUANTITY > 0 ),
    PRODUCT_ID      bigint not null references PRODUCTS,
    QUANTITY        int    not null check ( QUANTITY > 0 ),
    AMOUNT_FULL     int    not null check ( AMOUNT_FULL > 0 ),
    AMOUNT_DISCOUNT int    not null check ( AMOUNT_DISCOUNT >= 0 ),
    primary key (PURCHASE_ID, ORDINAL_NUMBER)
)