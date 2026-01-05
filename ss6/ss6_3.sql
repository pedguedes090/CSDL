use ss6_1;
select order_date, sum(total_amount) as daily_revenue from orders
where status = 'completed' GROUP BY order_date;

select order_date, count(order_id) as daily_orders from orders
where status = 'completed' GROUP BY order_date;

select order_date, sum(total_amount) as daily_revenue from orders
where status = 'completed' GROUP BY order_date
HAVING sum(total_amount) >= 1000000;
