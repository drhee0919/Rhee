select sysdate from dual;
select 10+10 from dual;

alter session set nls_date_format = 'YYYY/MM/DD HH24:MI:SS';
alter session set nls_language=american;
select sysdate from dual;
alter session set nls_date_format='RR/MM/DD';
select sysdate from dual;

alter session set nls_date_format = 'DD Month YYYYspth';
select sysdate from dual;

alter session set nls_language=korean;
select sysdate from dual;

select 'A' || 'B' from dual; -- AB  
select ename, job from emp; -- ename과 job 컬럼의 내용 출력(2개 col)
select ename||job from emp; --ename||job 이란 컬럼으로 각 내용 붙여서 출력(1개 col)
select ename || ' ' || job from emp; -- 상기 결과에서 공백생성으로 구분(1개 col)

--문자 연산 
select 'A' from dual; --A
select '''A''' from dual; --'A'
select q'['A']' from dual; --'A'    

--날짜 연산(date+n, date-n, date+n/24, date+n/1440, date-n/24, date-n/12
alter session set nls_date_format = 'YYYY/MM/DD HH24:MI:SS';
select sysdate, sysdate+1, sysdate-1 from dual; --n이 '하루' 인 것을 확인 
select sysdate, sysdate+ 5/24, sysdate-5/24 from dual; --n이 '시간(5시간)'인 것을 확인
select sysdate-hiredate from emp; -- hiredate: 근무했던 날짜, 기간 출력 

select sal, comm, (sal+comm)*12
from emp; 

-- 10번 부서 소속 사원 검색 
select * 

from emp 

where deptno = 10;

-- 직무가 salesman 인 사원 검색 
select * 

from emp 

where job = 'SALESMAN'; --컬럼값은 대소문자 구별함 



-- 입사날짜가 82년 1월 1일 이후에 입사한 사원 검색 
select * 
from emp 
where HIREDATE > '1982/01/01';

-- 급여가 2500이상인 사원 검색 
select * 
from emp 
where SAL >= 2500;
----------------------------------
-- Where 절 
-- where 절에 사용가능한 범위 연산자 : (기준)컬럼 between 하한값 and 상한값 
-- Q. 급여가 2000이상 3000이하인 사원  검색
from emp 
where sal between 2000 and 3000;
--또는 
select * 
from emp 
where sal>=2000 
and sal<=3000;

-- where절에 사용가능한 여러개의 값을 비교 연산자 :   (기준)컬럼 in (값1, 값2, 값3, 값4, ...)
-- Q. 직무가 clerk이거나 salesman인 사원들 검색
select * 
from emp 
where job in ('CLERK', 'SALESMAN');
--또는 
select *
from emp 
where job = 'CLERK'
or job = 'SALESMAN';

-- where 절에 사용가능한 문자 비교 패턴 연산자 : (기준)칼럼 like '비교문자% 또는 _ '
-- Q. 사원 이름중에 N으로 끝나는 사원 검색 
select ename 
from emp 
where ename like '%N';
--Q. 사원 이름중에 두번째 문자가 O인 사원 검색 
select ename 
from emp 
where ename like '_O%';

-- where 절에 사용가능한 null값 비교 연산자 : is null, is not null 

select * 
from emp
where comm = null; --논리오류 

select * 
from emp 
where comm is null; -- COMM값이 null 인 row 출력 

select * 
from emp 
where comm >= 0;

--orderby 사용 
select * from emp;
select empno, ename,sal, deptno 
from emp
order by depto;

elect empno,ename,sal, deptno 
from emp
order by deptno desc ;
--Q.사원번호, 이름, 부서번호, 연봉(급여*12)를 연봉의 내림차순으로 정렬된 검색 결과 생성 
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by sal * 12 desc; -- 표현식 선언 가능 
--또는
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by "Annual Salary" desc; -- alias 선언 가능 
--또는 
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by 4 desc; -- column position 선언 가능 

--Q. 전체 사원을 부서번호로 오름차순 정렬하고 부서내 사원은 급여의 내림차순으로 정렬한 검색 결과 생성 
select empno, ename, deptno, sal * 12 "Annual Salary"
from emp 
order by 3, 4 desc;

select empno, ename, deptno, sal * 12 "Annual Salary"
from emp 
order by deptno, 4 desc; --혼용도 가능하다 

is not null
not between ~ and
not in
not like

-- input값 획득 
-- cmd에서도 가능하다 
-- Q. 입력받은 사원번호로 해당 사원에 대한 정보 반환 
select *
from emp
where empno = &emp_num;

--자주 수행하는 혹은 정기적으로 수행하는 sql문장을 스크립트파일로 저장
--확장자 .sql

desc dept 
select rowid, deptno, dname 
from dept;



--연습문제 
--문제1)  EMP Table의 모든 자료를 출력하여라.
select * 
from emp

--문제2)  EMP Table에서 사원 번호, 이름, 급여, 담당업무를 출력하여라.
select deptno, ename, sal, job
from emp

--문제3) 모든 사원의 급여를 $300 증가시키기 위해 덧셈 연산자를 사용하고 결과에 SAL+300을 조회한다
select empno, ename, deptno, sal, sal + 300 "Added Salary"
from emp 

--문제4) EMP 테이블에서 사원번호, 이름, 급여보너스를 출력하여라.
select empno, ename, deptno, sal 
from emp 

--문제5) EMP 테이블에서 ENAME를 NAME로 SAL을 SALARY로 출력하여라.
select ename "NAME", sal "SALARY"
from emp

--문제6) EMP 테이블에서 ENAME를 Name로 SAL*12를 Annual Salary 로 출력하여라.


문제7) EMP 테이블에서 ENAME를 '성 명'으로, SAL를 ‘급 여'로  출력하여라.

문제8) EMP 테이블에서 이름과 업무를 연결하여 출력하여라.

문제9) EMP 테이블에서 이름과 업무를 "King is a PRESIDENT" 형식으로 출력하여라.

문제10) EMP 테이블에서 이름과 연봉을 "KING: 1 Year salary = 60000" 

문제11) EMP 테이블에서 JOB을 모두 출력하여라.

문제12) EMP 테이블에서 담당하고 있는 업무의 종류를 출력하여라.

문제13) EMP 테이블이 부서번호를 중복 값을 제거해서 조회하라

문제14) 부서별로 담당하는 업무를 한번씩 출력하여라.

문제15) EMP 테이블에서 사원번호, 이름, rowid를 조회하라.
테이블에 레코드가 추가되면 자동으로 컬럼값이 추가됩니다.
desc dept
select rowid, deptno, dname
from dept;
rowid컬럼은 논리적 행 주소가 저장되는 컬럼으로 오라클 서버가 자동 생성해줍니다.

문제17) EMP 테이블에서 급여가 3000 이상인 사원의 사원번호, 이름, 담당업무, 급여를 출력하라.

문제18) EMP 테이블에서 담당업무가 Manager인 사원의 정보를 사원정보, 성명, 담당업무, 급여, 부서번호를 출력하라.

문제19) EMP 테이블에서 1982년 1월 1일 이후에 입사한 사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라.

문제20) EMP 테이블에서 급여가 1300에서 1700사이의 사원의 성명, 담당업무, 급여, 부서 번호를 출력하여라.

문제21) EMP 테이블에서 사원업호가 7902, 7788, 7566인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자를 출력하여라.

문제22) EMP 테이블에서 입사일자가 82년도에 입사한 사원의 사번, 성명, 당당업무, 급여, 입사일자, 부서번호를 출력하여라.

문제23) EMP 테이블 이름의 첫 글자가 'M'인 사원의 이름, 급여 조회하라

문제24) EMP 테이블 이름의  두 번째 글자가 ‘L'인 사원의 이름,업무를  조회하라

문제25) EMP 테이블에서 보너스가 NULL인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하여라.

문제26) EMP 테이블에서 급여가 1100 이상이고 JOB이 Manager인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하여라.
 
문제28) EMP 테이블에서 JOB이 Manager, Clerk, Analyst가 아닌 사원의 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하여라

문제29) 업무가 PRESIDENT이고 급여가 1500 이상이거나 업무가 SALESMAN인 사원의 사원번호, 이름, 업무, 급여를 출력하여라.

문제30)  급여가 1500 이상인 사원중 업무가  PRESIDENT 이거나  SALESMAN 인 사원번호, 이름, 업무, 급여를 출력하여라.

문제31) EMP 테이블에서 입사일자 순으로 정렬하여 사원번호, 이름, 업무, 급여, 입사일자, 부서번호를 출력하여라.

문제32) EMP 테이블에서 가장 최근에 입사한 순으로 사원번호, 이름, 업무, 급여, 입사일자, 부서번호를 출력하여라.

문제33) EMP 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우 급여가 많은 순으로 정렬하여 사원번호, 성명, 업무, 부서번호, 급여를 출력하여라.

문제34) EMP 테이블에서 첫번째 정렬은 부서번호로 두번째 정렬은 업무로 세번째 정령은 급여가 많은 순으로 정렬하여 사원번호, 성명, 입사일자, 부서번호, 업무, 급여를 출력하여라.

문제35) 부서별로 담당하는 업무를 한번씩 조회하라.단 업무 기준으로 정렬해서 나오도록 한다.

문제36) EMP  사원이름, 연봉, 매니저번호를 조회하라 ,단 매니저 번호가 큰 선수부터 나오도록 정렬한다.


