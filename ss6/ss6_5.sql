use ss6_1;

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) 
values
    (106, 1, '2026-01-06', 'completed', 4000000),
    (107, 1, '2026-01-07', 'completed', 3500000),
    (108, 1, '2026-01-08', 'completed', 5000000);

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) 
values
    (109, 2, '2026-01-09', 'completed', 6000000),
    (110, 2, '2026-01-10', 'completed', 5500000),
    (111, 2, '2026-01-11', 'completed', 7000000);


select 
    c.full_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_spent,
    avg(o.total_amount) as avg_order_value
from customers c
join orders o on c.customer_id = o.customer_id
where o.status = 'completed' GROUP BY c.full_name
having COUNT(o.order_id) >= 3 and sum(o.total_amount) > 10000000
ORDER BY total_spent desc;
