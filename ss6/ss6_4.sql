use ss6_1;
alter table order_items drop FOREIGN KEY order_items_ibfk_1;
drop table if exists products;
drop table if exists order_items;

create table products(
    product_id int PRIMARY key,
    product_name varchar(255) not null,
    price decimal(10,2) not null
);

create table order_items(
    order_id int,
    product_id int,
    quantity int,
    FOREIGN KEY (product_id) references products(product_id)
);

INSERT INTO products (product_id, product_name, price) 
values
    (1, 'Laptop Dell', 15000000),
    (2, 'iPhone 15', 25000000),
    (3, 'Tai nghe Sony', 2000000),
    (4, 'Chuột Logitech', 800000),
    (5, 'Bàn phím cơ Keychron', 250000);

INSERT INTO order_items (order_id, product_id, quantity) 
values
    (101, 1, 2),
    (102, 2, 1),
    (103, 3, 5),
    (104, 4, 10),
    (105, 5, 3);

select p.product_name, sum(oi.quantity) as total_sold from products p
join order_items oi on p.product_id = oi.product_id GROUP BY p.product_name;

select p.product_name, sum(oi.quantity * p.price) as revenue from products p
join order_items oi on p.product_id = oi.product_id GROUP BY p.product_name;

select p.product_name, sum(oi.quantity * p.price) as revenue from products p
join order_items oi on p.product_id = oi.product_id GROUP BY p.product_name
having sum(oi.quantity * p.price) > 5000000;
