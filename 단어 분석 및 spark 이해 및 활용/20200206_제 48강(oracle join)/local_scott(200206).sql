###################### join ############################
Q. 사원이름, 부서번호, 부서이름을 조회 결과로 생성 
select ename, deptno, dname
from emp,dept; --error, 열의 정의가 애매 

select emp.ename, emp.deptno, dept.dname
from emp, dept; -- 총 56개 행

select a.ename, a.deptno, b.dname
from emp a, dept b; --emp 14rows, dept 4rows, 총56행
--join 조건이 누락되어 cartesian product(Cross join)로 수행 됨 

select a.ename, a.deptno, b.dname
from emp a, dept b 
where a.deptno = b.deptno; --14개 행만 출력(inner) 

--employee에도 적용 (hr계정 접속) --
----------------------------------

-- natural join 예제
-- natural join은 데이터 모델링을 잘못해서 두 테이블의 동일한 속성에 대해서 컬럼이름이 다른 경우에는 조인이 수행되지 않습니다. 

create table dept2(deptid, dname, loc)
as select * from dept; --테이블의 구조와 row를 복제 

desc dept2
select * from dept2;

select a.ename, deptno, b.dname
from emp a natural join dept2 b; --cartesian product (join조건 누락; deptno != dname)

--코드 정정
select a.ename, a.deptno, b.dname
from emp a join dept2 b on a.deptno = b.deptid; --14개 행 


--------
--non equi join 
Q. 각 사원별로 급여와 사원의 급여 등급을 조회 출력하는 SQL 작성 
desc emp 
desc salgrade

select a.ename, a.sal, b.grade
from emp a, salgrade b
where a.sal between b.losal and b.hisal;
--또는 
select a.ename, a.sal, b.grade
from emp a join salgrade b on a.sal between b.losal and b.hisal;


--self join 
--자기 참조 관계 테이블에서 PK와 FK컬럼간의 조인 조건 
Q. 각 사원별로 사번, 이름, 관리자번호, 관리자이름을 조회 출력하는 SQL작성 
select a.empno, a.ename, a.mgr, b.ename
from emp a, emp b 
where a.mgr = b.empno;

select a.empno, a.ename, a.mgr, b.ename
fro emp a join emp b on a.mgr = b.empno;

--- 이하 hr 계정으로 연습문제 풀이2-------

Q. 사원이름, 소속부서 이름, 소속부서의 위치(도시명)을 조회 출력하는 SQL(last_name, department_name, city) 