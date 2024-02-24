drop table customer;
drop table "transaction";


create table customer (
	customer_id int4,
	first_name varchar(50),
	last_name 	varchar(50),
	gender 	varchar(30),
	DOB varchar(30),
	job_title varchar(50),
	job_industry_category	varchar(50),
	wealth_segment 	varchar(50),
	deceased_indicator 	varchar(50),
	owns_car 	varchar(30),
	address 	varchar(50),
	postcode 	varchar(30),
	state 	varchar(30),
	country 	varchar(30),
	property_valuation	int4
);

create table transaction (
	transaction_id	int4,
	product_id	int4,
	customer_id	int4,
	transaction_date varchar(30),
	online_order	varchar(30),
	order_status	varchar(30),
	brand	varchar(30),
	product_line	varchar(30),
	product_class	varchar(30),
	product_size	varchar(30),
	list_price	float4,
	standard_cost	float4
);

--Вывести распределение (количество) клиентов по сферам деятельности, отсортировав результат по убыванию количества.

select c.job_industry_category, count(*)
from customer c 
group by c.job_industry_category 
order by count desc; 

--Найти сумму транзакций за каждый месяц по сферам деятельности, отсортировав по месяцам и по сфере деятельности. 

select date_trunc('month' ,t.transaction_date::date) as mnth, c.job_industry_category as industry, sum(t.list_price) 
from "transaction" t 
join customer c 
on t.customer_id = c.customer_id 
group by c.job_industry_category, mnth
order by mnth, industry;

--Вывести количество онлайн-заказов для всех брендов в рамках подтвержденных заказов клиентов из сферы IT.

select t.brand, count(*)
from "transaction" t 
join customer c 
on t.customer_id = t.customer_id 
where c.job_industry_category = 'IT'
and t.order_status = 'Approved'
group by t.brand;

/* Найти по всем клиентам сумму всех транзакций (list_price), максимум, минимум и количество транзакций, 
   отсортировав результат по убыванию суммы транзакций и количества клиентов. 
   Выполните двумя способами: используя только group by и используя только оконные функции. Сравните результат.  */

select t.customer_id, sum(t.list_price), max(t.list_price), min(t.list_price), count(t.list_price)
from "transaction" t 
group by t.customer_id 
order by sum desc, count desc;

select t.transaction_id, t.customer_id,
sum(t.list_price) over customer_id,
max(t.list_price) over customer_id,
min(t.list_price) over customer_id,
count(*) over customer_id
from "transaction" t
window customer_id as (partition by t.customer_id)
order by sum desc, count desc;

/*Найти имена и фамилии клиентов с минимальной/максимальной суммой транзакций за весь период 
 * (сумма транзакций не может быть null). Напишите отдельные запросы для минимальной и максимальной суммы.*/

with sum_price as (
select c.customer_id, sum(t.list_price) as sm
from "transaction" t 
join customer c
on c.customer_id = t.customer_id
group by c.customer_id
) 
select c.first_name, c.last_name, sp.sm
from customer c 
join sum_price sp
on c.customer_id = sp.customer_id
where sp.sm = (select max(sm) from sum_price) or sp.sm = (select min(sm) from sum_price);

--Вывести только самые первые транзакции клиентов. Решить с помощью оконных функций.

select customer_id,
min(t.transaction_date::date) over (partition by t.customer_id)
from "transaction" t;

--Вывести имена, фамилии и профессии клиентов, между транзакциями которых был максимальный интервал (интервал вычисляется в днях)

WITH TransactionIntervals AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.job_title,
    LAG(t.transaction_date::date) OVER (PARTITION BY c.customer_id ORDER BY t.transaction_date::date) AS prev_transaction_date,
    t.transaction_date,
    COALESCE(
      t.transaction_date::date - LAG(t.transaction_date::date) OVER (PARTITION BY c.customer_id ORDER BY t.transaction_date::date),
      0
    ) AS interval_days
  FROM
    customer c
    JOIN "transaction" t ON c.customer_id = t.customer_id
)
SELECT
  customer_id,
  first_name,
  last_name,
  job_title,
  interval_days
FROM
  TransactionIntervals
WHERE
  interval_days = (SELECT MAX(interval_days) FROM TransactionIntervals);








