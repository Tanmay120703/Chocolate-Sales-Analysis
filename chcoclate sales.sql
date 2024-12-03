use chocolate;
select * from sales_fact_table;
select * from product_dimension;
select * from location_dimension;
select * from customer_dimension;

select sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID;

select sum(quantity_sold) as total_quantity
from sales_fact_table;

select c.Loyalty_Status , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
inner join customer_dimension c
on b.Customer_ID = c.Customer_ID
group by c.Loyalty_Status;

select c.city , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
inner join location_dimension c
on c.location_id = b.location_id
group by c.city;

select c.gender , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
inner join customer_dimension c
on c.customer_id = b.customer_id
group by c.gender;

select c.customer_name , sum(p.cost*s.quantity_sold)as sales  from sales_fact_table s
inner join product_dimension p
on s.product_id = p.product_id
inner join customer_dimension c
on c.customer_id  = s.customer_id
group by c.customer_name
order by sales desc;

select a.chocolate_type , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
group by a.chocolate_type;

select a.brand , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
group by a.brand
order by sales desc;

select costsegment , sum(a.cost*sft.quantity_sold) as sales
from (
select product_id , cost ,
case when cost > 150 then 'very costly'
when cost > 100 then 'high cost'
when cost > 50 then 'average cost'
else 'inexpensive'
end as costsegment
from product_dimension )a
inner join 
sales_fact_table sft
on a.product_id = sft.product_id
group by costsegment
order by costsegment;

select a.product_name , sum(a.cost*b.quantity_sold) as sales
from product_dimension a
inner join sales_fact_table b
on a.Product_ID = b.Product_ID
group by a.product_name
order by sales desc;

select quarter(str_to_date(s.date ,'%m/%d/%y')) as monthn , sum(p.cost*s.quantity_sold) as sales  from sales_fact_table s
inner join product_dimension p
on s.product_id = p.product_id
group by quarter(str_to_date(s.date ,'%m/%d/%y'))
order by sales desc;

with ct1 as (
select monthname(str_to_date(s.date ,'%m/%d/%y')) as monthn , sum(p.cost*s.quantity_sold) as sales  from sales_fact_table s
inner join product_dimension p
on s.product_id = p.product_id
group by monthname(str_to_date(s.date ,'%m/%d/%y'))
)
select monthn , sales from ct1 where monthn in ('December','November','October')







