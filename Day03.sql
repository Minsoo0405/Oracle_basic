select * from book
where bookname like '%축구%';

create view vw_Book
as select * from book
where bookname like '%축구%';

create view vw_Customer
as select * from customer
where address like '%대한민국%';

create view vw_orders
as select O.orderid, B.bookname, O.saleprice from orders O, book B, customer C
where O.custid = C.custid and B.bookid = O.bookid;

