-- 차집합 MINUS
-- 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
minus
select name
from customer 
where custid in (select custid from orders);

select name
from customer
where custid not in (select custid from orders);

-- 교집합 INTERSECT
-- 도서를 주문한 고객의 이름을 보이시오.
select name
from customer
intersect
select name
from customer 
where custid in (select custid from orders);

-- EXITS
select name, address
from customer c
where exists (select * from orders o
            where c.custid = o.custid);

-- Practice02 풀이완료
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

-- (10) 고객의 이름과 고객별 구매액
select c.name, sum(o.saleprice) from orders o, customer c
where o.custid = c.custid
group by c.name

-- (11) 고객의 이름과 고객이 구매한 도서 목록
select name, bookname from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid
order by name;

-- (12) 도서의 가격(book 테이블)과 판매가격(orders 테이블)의 차이가 가장 많은 주문
select * from book b, orders o
where b.bookid = o.bookid and b.price - o.saleprice = (select max(price - saleprice)
                                                        from book, orders
                                                        where book.bookid = orders.bookid)

-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 
select name from customer c
where c.custid in (select custid from orders
                    group by custid
                    having avg(saleprice) > (select avg(saleprice) from orders));

-- 중첩질의(where 부속질의)
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice from orders
where saleprice <= (select avg(saleprice)
                    from orders);
-- 각 고객의 평균 주문금액보다 큰 금액의 주문내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select orderid,custid,saleprice
from orders o1 
where saleprice > (select avg(saleprice)
                    from orders o2
                    where o1.custid = o2.custid);
                    
-- 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice) from orders o
where o.custid in (select c.custid from customer c
                    where c.address like '%대한민국%')
                    
-- all
select o1.custid, o1.saleprice from orders o1
where saleprice > all (select max(saleprice) from orders o2
                    where o2.custid = 3);
                    
-- Practice03
-- (1)
select custid, (select address
                from customer c
                where c.custid = o.custid) "address",
                sum(saleprice) "total"
from orders o
group by o.custid;

-- (2) 
select c.name, s
from (select custid, avg(saleprice) s
        from orders
        group by custid) o, customer c
where c.custid = o.custid

-- (3)
select sum(saleprice) "total"
from orders o
where exists (select * 
                from customer c
                where c.custid = o.custid and c.custid <= 3)
        
-- DML: insert
insert into book(bookid, bookname, publisher, price)
    values(11, '스포츠 의학', '한솔의학서적', 90000);

select * from book
order by bookid

-- Imported_Book 생성 
CREATE TABLE Imported_Book (
  bookid      NUMBER ,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       NUMBER(8) 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

-- 대량 삽입(bulk insert)
-- imported book 테이블을 book 테이블에 삽입
insert into book(bookid, bookname, price, publisher)
        select bookid, bookname, price, publisher
        from imported_book;
        
select * from book

-- Practice03
-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select name from customer c
where c.custid = (select b1.custid from book b1
                    where b1.bookid = (select o.bookid from orders o)
                                        where )

-- (2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
                    
select * from customer
select * from book    
select * from orders