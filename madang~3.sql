-- 프로시저(실행부)
exec BOOKINSERTORUPDATE(15,'스포츠 즐거움', '마당과학서적', 25000);

-- 확인작업
select * from book;

-- 프로시저(실행부)
exec BOOKINSERTORUPDATE(15,'스포츠 즐거움', '마당과학서적', 20000);

-- 확인작업
select * from book;

-- 예제 5-3) Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저
-- 프로시저(실행부)
set serveroutput on;
declare
    AverageVal NUMBER;
begin
    AveragePrice(AverageVal);
    DBMS_OUTPUT.PUT_LINE('책값 평균: '|| AverageVal);
end;

-- 예제 5-4) Orders 테이블의 판매도서에 대한 이익을 계산하는 프로시저
-- 프로시저(실행부)
set serveroutput on;
exec interest;