create Database ecommerce 

use ecommerce 
select * from orders


select COUNT(*) from orders 

select sum(Net_Amount) from orders

select product, sum(net_Amount) [sales] from orders
group by product
order by sales desc

select City,sum(net_amount) [sales] from orders
group by City
order by sales desc 

select MONTH,sum(net_amount) [sales] from orders
group by MONTH
order by sales desc 

select PRODUCT,sum(net_amount) [sales] from orders
group by PRODUCT
order by sales desc 


select payment_mode,count(*) [total_orders] from orders
group by payment_mode
order by total_orders desc 

select * from orders where order_status = 'Cancelled'










