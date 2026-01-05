drop table if exists customers;
drop table if exists orders;

create table customers(
    customer_id int PRIMARY KEY,
    full_name varchar(255) not null,
    city varchar(255) not null
);

create table orders(
    order_id int PRIMARY KEY,
    customer_id int,
    order_date date not null,
    status enum('pending', 'completed', 'cancelled' ) not null
);

INSERT INTO customers (customer_id, full_name, city) 
VALUES 
    (1, 'Nguyen Van A', 'Hanoi'), 
    (2, 'Tran Thi B', 'Ho Chi Minh'), 
    (3, 'Le Van C', 'Da Nang'), 
    (4, 'Pham Thi D', 'Hai Phong'), 
    (5, 'Hoang Van E', 'Can Tho');

INSERT INTO orders (order_id, customer_id, order_date, status) 
VALUES
    (101, 1, '2026-01-01', 'completed'),
    (102, 2, '2026-01-02', 'pending'),
    (103, 1, '2026-01-03', 'cancelled'),
    (104, 3, '2026-01-04', 'completed'),
    (105, 5, '2026-01-05', 'completed');

select o.order_id, o.order_date, o.status, c.full_name from orders o
join customers c on o.customer_id = c.customer_id;

select c.full_name, count(o.order_id) as total_orders from customers c
left join orders o on c.customer_id = o.customer_id GROUP BY c.full_name;

select c.full_name, count(o.order_id) as total_orders from customers c
join orders o ON c.customer_id = o.customer_id GROUP BY c.full_name
having count(o.order_id) >= 1;
