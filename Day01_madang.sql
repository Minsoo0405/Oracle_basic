select bookname, price from book

select price, bookname from book

-- 중복조건 제외한 select
select distinct publisher from book

-- where 조건에서의 NULL
select name from customer
where phone is null

-- where 조건에서의 between, 연산자
select * from book
where price between 10000 and 20000

select * from book
where price >= 10000 and price <= 20000

-- where 조건에서의 집합
select * from book
where publisher in ('굿스포츠', '대한미디어')

select * from book
where publisher not in ('굿스포츠', '대한미디어')

-- where 조건에서의 패턴
select publisher, bookname from book 
where bookname like ('축구의 역사')

select bookname, publisher from book
where bookname like '%축구%'

select * from book
where bookname like '%_구%'

-- where 복합조건
select * from book
where bookname like '%축구%' and price >= 20000

select * from book
where publisher in ('굿스포츠','대한미디어')

select * from book
where publisher = '굿스포츠' or publisher = '대한미디어'

-- order by
select * from book
order by bookname

select * from book
order by price, publisher

-- 집계함수
select sum(saleprice) AS 총매출 from orders

select sum(saleprice) from orders
where custid = 2

select count(*) from orders

-- group by
select custid, count(*), sum(saleprice) from orders
group by custid
order by custid

-- having: group by에 대한 조
select custid, count(*) from orders
where saleprice >= 8000
group by custid
having count(*) >= 2

-- Practice01
-- (1) 도서번호가 1인 도서의 이름
select bookname from book
where bookid = 1

-- (2) 가격이 20,000원 이상인 도서의 이름
select bookname from book
where price >= 20000

-- (3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
select sum(saleprice) from orders
where custid = 1

-- (4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
select count(*) from orders
where custid = 1

-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오.

-- (1) 마당서점 도서의 총 개수
select count(*) from book

-- (2) 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) from book

-- (3) 모든 고객의 이름, 주소
select name, address from customer

-- (4) 2014년 7월 4일~7월 7일 사이에 주문받은 도서의 주문번호
select orderid, orderdate from orders
where orderdate between '14/07/04' and '14/07/07'

-- (5) 2014년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select orderid, orderdate from orders
where orderdate not between '14/07/04' and '14/07/07'

-- (6) 성이 ‘김’ 씨인 고객의 이름과 주소
select name,address from customer
where name like '%김_%'

-- (7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
select name, address from customer
where name like '%김_아%'

-- inner join
select *
from customer, orders
where customer.custid = orders.custid;

select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid;

select name, saleprice
from customer, orders
where customer.custid = orders.custid;

select *
from customer, orders
where customer.custid = orders.custid
group by customer.name

select name, bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid

select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid
and saleprice = 20000;

-- outer join
select *
from customer left outer join orders
on customer.custid = orders.custid

-- subquery
select bookname
from book
where price = (select max(price) 
                from book);
                
select distinct customer.name
from customer, orders
where customer.custid = orders.custid;

select name
from customer
where custid in (select custid  
                from orders);
                
-- Practice02
-- (5) 박지성이 구매한 도서의 출판사 수
select count(publisher)
from book
where bookid in (select bookid from orders
                where custid = 1)
                
-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select b.bookname, price, (price-saleprice) from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid and c.custid = 1

-- (7) 박지성이 구매하지 않은 도서의 이름
select bookname
from book
where bookid not in (select bookid from orders
                where custid = 1)
                
-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer
where custid not in (select custid from orders)

-- (9) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as 총액, avg(saleprice) as 평균
from orders o

-- (10) 고객의 이름과 고객별 구매액 - 수정필요
select c.name, sum(o.saleprice) from orders o, customer c
where o.custid = c.custid
group by c.name

-- (11) 고객의 이름과 고객이 구매한 도서 목록
select name, bookname from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid
order by name;

-- (12) 도서의 가격(book 테이블)과 판매가격(orders 테이블)의 차이가 가장 많은 주문 - 수정필요
select max(price - saleprice) from book b, orders o
where b.bookid = o.bookid

-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 
