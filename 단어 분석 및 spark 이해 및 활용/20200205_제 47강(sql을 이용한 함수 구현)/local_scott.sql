--ascii(127개 문자)
--ebcdic(256개 문자)
select chr(48), chr(65), chr(97), chr(13)
from dual;

select upper('hello'), lower('HELLO'), initcap('HELLO SQL')
from dual; -- HELLO hello Hello Sql

select concat('hello' ,  ' SQL')
from dual;  -- hello SQL

select substr('hello world', 6), substr('hello world', 3,2), substr('hello world', -5,3)
from dual; -- world 11 wor

select replace('Jack and Jue', 'J', 'Bl')
from dual; --Black and Blue 

select instr('hello world', 'o'), instr('hello world', 'o', 6), instr('hello world', 'o', 1,2), instr('hello world', 'o', -7)
from dual; --5 8 8 5


select length('korea'), length('대한민국'),
       lengthb('korea'), lengthb('대한민국')
from dual;  

select translate('Jack and Jue', 'acJ', '137')
from dual; --713k 1nd 7ue

select sal, lpad(sal, 10, '$'), rpad(sal, 10, '$')
from emp;


-- Q. emp테이블로부터 82년도에 입사한 사원 조회 
select * 
from emp 
where HIREDATE like '87%';

--또는 
select *
from emp 
where '87' = substr(hiredate, 1, 2);

-- Q. emp테이블로부터 사번이 홀수인 사원 조회 
select ename 
from emp 
where 1 = mod(empno, 2);

-------------이상 숫자함수 예제 -----------
-------------이하 날짜함수 써봅시당 --------
select ename, hiredate, months_between(sysdate, hiredate)
from emp;

select ename, hiredate, trunc(months_between(sysdate, hiredate))
from emp;

select  trunc(to_date('2021/7/16'), 'Month') 
        , trunc(to_date('2021/7/14'), 'Month') 
        , trunc(to_date('2021/7/16'), 'Year') 
        , trunc(to_date('2021/6/16'), 'Month') 
from dual;   --round함수도 날짜 타입에 적용 가능 함수(절삭기능) 


select sysdate, add_months(sysdate, 3)
from dual; --20/02/05 20/05/05

alter session set nls_date_format = 'RR/MM/DD HH24:MI:SS'; -- 형식전환(session 변경)
select sysdate, current_date, current_timestamp, sessiontimezone
from dual;
--sysdate함수는 시스템(운영체제)의 현재 시간을 date타입값으로 반환
--current_date 함수는 DB접속 client 세션의 timezone기반으로  date타입값으로 반환
alter session set time_zone='-9:00'; -- 표준timestamp 기준 9시간 빠른 서울의 시간 표시  

select sysdate, current_date, current_timestamp, sessiontimezone
from dual;

select dbtimezone from dual; --원복
alter session set nls_date_format = 'RR/MM/DD'; --원복 

select last_day(sysdate), last_day(to_date('1900/02/03'))
      ,last_day(to_date('2000/02/03')),last_day(to_date('1996/02/03'))
from dual; --2월의 last day활용, 윤년확인 

select  next_day(sysdate, '금'), next_day(sysdate, '월')
from dual; --20/02/07 20/02/10

select hiredate, extract( month from hiredate)
from emp; --좌측열 HIREDATE에서 우측열에 월 추출 

select hiredate, extract( day from hiredate)
from emp; --좌측열 HIREDATE에서 우측열에 일 추출 

--날짜 시간 관련 컬럼 타입
--timestamp with timezone
--interval year to month
--interval day to second


select hiredate, hiredate + TO_DSINTERVAL('100 00:00:00') -- day to second 
        , hiredate + to_yminterval('01-02') --year to month 
from emp;

---------------------이상 날짜함수----------------------------------
---------------------이하 형변환 함수를 사용해보자 -------------------

select sysdate, to_char(sysdate, 'YYYY"년" MM"월" DD"일" Day')
from dual; --to_char의 1번째 argument 값 형식과 변환할 두번째 argument값 형식은 달라도 변환됨
           --20/02/05 2020년 02월 05일 수요일 

select 1234.56, to_char(1234.56 , '$999,999.990')
from dual; --1234.56 $1,234.560

select '$1,234.56' , to_number('$1234.56' , '999,999.990')
from dual; ---error, 수치부적합
select '$1,234.56' , to_number('$1,234.56' , '$999,999.990')
from dual;   -- $1,234.56   1234.56

select '2020년 2월 5일 수'
        , to_date('2020년 2월 5일 수', ' RR/MM/DD Day')
from dual; --error, 리터럴이 형식 문자열과 일치하지 않음


select '2020년 2월 5일 수'
        , to_date('2020년 2월 5일 수', 'YYYY"년" MM"월" DD"일" Day')
from dual; --error, 지정한 요일이 부적합합니다. 

select '2020년 2월 5일 수'
        , to_date('2020년 2월 5일 수요일', 'YYYY"년" MM"월" DD"일" Day')
from dual; --2020년 02월 5일 수     20/02/05


-----------------이상 날짜함수 ---------------
-----------------null 제어 함수 쓸거야--------
select nvl(comm, 'No Commission')
from emp; ---error, 수치부적합

select nvl(to_char(comm), 'No Commission')
from emp; --null값이 No commission 으로

--예제
Q. emp테이블에서 commission을 받는 사원은 sal_+ comm 리턴하고, 받지 않는 사원은 sal리턴한 결과 출력 
select ename, sal, comm, nvl2(comm, sal+comm, sal)
from emp;

select coalesce(1,2,3,4,5), coalesce(null, null, 3,4,5), coalesce(null, null, null, null, 5)
from dual; -- 1 3 5 

-- 조건처리 : decode(),  표준sql 구문 case when then ...else end
Q> 10번 부서 사원은 급여를 5%인상, 
      20번 부서 사원은 급여를 7%인상, 
     30번 사원은 급여를 3%인상된 급여를 현재급여와 함께 출력
select ename, deptno, sal
        , decode(deptno, 10, sal*1.05, 20, sal*1.07, 30, sal*1.03, sal) "Increase"
from emp; --네번째 col로 Increase 생성, 부서별 증가된 액수로 값 반환 

--또는(표준 sql구문으로 처리) 
select ename, deptno, sal
        , case deptno when 10 then sal*1.05
                      when 20 then sal*1.07
                      when 30 then sal*1.03
                      else sal end "Increase"
from emp; 

Q> 급여에 대한 세금을 급여와 함께 출력하시오
급여가 1000미만이면 세금 0원
급여가 1000이상 2000미만이면 세금 급여의 5%
급여가 2000이상 3000미만이면 세금 급여의 10%
급여가 3000이상 4000미만이면 세금 급여의 15%
급여가 4000이상 이면 세금 급여의 20% 
컬럼 별칭은 Tax

select ename, deptno, sal
        , decode(trunc(sal/1000), 0, 0,
                                 1, sal*0.05,
                                 2, sal*0.1,
                                 3, sal*0.15,
                                 sal*0.2) "Tax"
from emp;

--또는 
select ename, deptno, sal
        , case when sal<1000 then 0
               when sal<2000 then sal*0.05
               when sal<3000 then sal*0.1
               when sal<4000 then sal*0.15
               else sal*0.2 end "Tax"
from emp; 

-------------------이상 null 제어 함수 ------------------
-------------------이하 group 함수(복수행함수) ---------------------
--테이블 전체 레코드를 하나의 그룹으로 함수에 적용
--테이블의 레코드를 특정 컬럼으로 그룹핑하고 그룹핑된 레코드들에 함수 적용
--count(), min(), max(), sum(), avg(), stddev(), variance()
select count(sal), min(sal), max(sal), sum(sal), avg(sal), stddev(sal), variance(sal)
from emp;  
--count(), min(), max()는 모든 컬럼타입 적용 가능
select   count(hiredate), min(hiredate), max(hiredate)
from emp; 

select   count(ename), min(ename), max(ename)
from emp; 

--count는 null이 아닌 컬럼값의 개수를 리턴
--count는 인수로 *를 사용할 수 있음=> 테이블의 행수를 리턴 (not null제약조건이 선언된 컬럼값의 개수 계산 리턴)
select count(*), count(comm), count(deptno), count(distinct deptno)
from emp;

--avg
--※ 그룹함수는 null을 함수 계산에 포함하지 않습니다. (무시)
select avg(comm),sum(comm)/count(empno)
from emp; --comm컬럼에 null 포함 
          --계산 결과가 다르다. 
          
-- 전체 사원의 commision 평균을 구하고자 수정한다면?
select avg(nvl(comm,0)), sum(comm)/count(empno) --null값을 먼저 제어
from emp; --두 col이 동일하게 출력 

Q. 어떤 컬럼이 모두 null인 경우 count 함수의 결과는? 
alter table emp add (address varchar2(50));
desc emp; 
select empno, ename, address from emp; --address 컬럼 전부 null
select count(address) from emp; -- 0이 반환된다. 

Q. 어떤 컬럼이 모두 null인 경우 sum 함수의 결과는? 
alter table emp drop(address);
alter table emp add(price number(6));
desc emp
select empno, ename, price from emp; --price 컬럼 전부 null
select sum(price) from emp; -- null 이 반환된다. 

--그룹핑 실행
select deptno, avg(comm), sum(comm)
from emp; ---error, 단일 그룹의 그룹 함수가 아닙니다. 

select deptno, avg(comm), sum(comm)
from emp
group by deptno;

--1차 그룹된 레코드에 2차 그룹핑 적용 가능 
select deptno, job, avg(comm), sum(comm)
from emp 
group by deptno, job;

--예제
Q. 각 부서별 평균 급여가 2500 이상인 부서와 해당 부서의 급여 평균을 검색 출력하시오 
select deptno, job, avg(sal), sum(sal)
from emp
where avg(sal) >= 2500
group by deptno; --error, where절은 gruop by 전에 수행되며, 그룹함수 사용불가 

--그룹함수의 조건 지정, group by 후에 수행
select deptno, avg(sal), sum(sal)
from emp
group by deptno
having avg(sal) >= 2500;
