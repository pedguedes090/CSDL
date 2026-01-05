use ss6_1;
alter table orders add COLUMN total_amount decimal(10,2) not null;

update orders set total_amount = 500000 where order_id = 101;
update orders set total_amount = 250000 where order_id = 102;
update orders set total_amount = 150000 where order_id = 103;
update orders set total_amount = 1800000 where order_id = 104;
update orders set total_amount = 300000 where order_id = 105;

select c.full_name, sum(o.total_amount) as total_spent from customers c
join orders o on c.customer_id = o.customer_id GROUP BY c.full_name;

select c.full_name, max(o.total_amount) as max_order_value from customers c
join orders o on c.customer_id = o.customer_id GROUP BY c.full_name;

select c.full_name, sum(o.total_amount) as total_spent from customers c
join orders o on c.customer_id = o.customer_id GROUP BY c.full_name
ORDER BY total_spent desc;
