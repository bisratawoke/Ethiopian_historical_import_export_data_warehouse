create table if not exists dim_date (
    id serial primary key not null,
    year integer not null,
    month integer not null,
    month_name varchar(255) not null
);

create table if not exists dim_product (
    id serial primary key not null,
    product_code varchar(255) not null,
    product_name text
);

create table if not exists dim_country (
    id serial primary key not null,
    country_name varchar(255) not null
);