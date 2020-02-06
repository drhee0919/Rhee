
alter session set nls_language=american;
select last_name, hire_date, 
        to_char(next_day(add_months(hire_date, 6), 'MON'),
        'Day, "the " Ddspth "of" Month, YYYY.')   review
from employees;


--------sql 1999문법 : natural join, join ~using, join ~on
Q. 사원이름, 부서번호, 부서이름을 조회 결과로 생성 
conn hr/oracle
--employees 108rows
--departments 27rows
select a.last_name, a.department_id, b.department_name
from employees a, departments b 
where a.department_id = b.department_id; --106rows (부서가 null in 사원이 존재) 

--natural join: oracle서버가 조인할 두 ㅔ이블의 동일한 이름의 컬럼값으로 equi join을 수행 
--동일하 이름의 컬럼앞에 소유자 테이블명이나 alias를 선언할 수 없음 
--데이터 모델링을 잘못해서 두 테이블의 동일한 속성에 대해서 컬럼이름이 다른 경우에는 조인이 수행되지 않는다. 
select a.lst_name, a.department_id, b.department_name
from employees a natural join departments b; --error, 동일한 이름의 컬럼앞에 소유자 테이블명이나 alias를 선언할 수 없음 

select a.last_name, department_id, b.department_name
from employees a natural join departments b; ---32행

desc employees
desc departments --두 데이터에서 department_ID와 manager_ID컬럼이 겹치는 것을 확인 

-- join ~using: 조인할 때 두 테이블의 동일한 이름의 하나의 컬럼으로만 조인 수행 
select a.last_name, a.department_id, b.department_name
from employees a join departments b using(a.department_id); --error 

--고쳐써보자
select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id); --106rows

select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id)
where a.department_id > 50 ; --error

--고쳐쓰장
select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id)
where department_id > 50 ; --51개행 


-------natural 조인 실습을 위해 scott 계정 접속 -----
------ join예제 이어서 ----------------------------
Q. 사원이름, 소속부서 이름, 소속부서의 위치(도시명)을 조회 출력하는 SQL(last_name, department_name, city) 
conn hr/oracle
desc employees
desc departments
desc locations






select rpad(concat(last_name, ' '), length(last_name) +1 + trunc(salary/1000), '*')
EMPLOYEES_AND_THEIR_SALARIES
from employees;
(또는)
select concat(last_name, rpad(' ', trunc(salary/1000)+1, '*'))
      EMPLOYEES_AND_THEIR_SALARIES
from employees;




select job_id , decode(job_id, 'AD_PRES', 'A',
			   'ST_MAN', 'B',
			   'IT_PROG', 'C',
			   'SA_REP', 'D',
			  'ST_CLERK', 'E', '0') grade
From employees;
--(또는)

Select job_id, case job_id when 'AD_PRES' then 'A'
                           when 'ST_MAN' then 'B'
                           when 'IT_PROG' then 'C'
                           when 'SA_REP' then 'D'
                           when 'ST_CLERK' then 'E'
                           else '0' end grade
from employees;

select max(salary) "Maximum", min(salary) "Minimum"
        ,sum(salary)  "Sum", avg(salary) "Average"
from employees;


select job_id, max(salary) "Maximum", min(salary) "Minimum"
      ,sum(salary) "Sum", avg(salary) "Average"
from employees;
--group by job_id;


select job_id, count(*)
from employees
group by job_id;



select job_id, count(job_id) "count(*)"
from employees
group by job_id;




select count(distinct manager_id) "Number of Manager" --중복 계산 안되게 주의 
from employees;


select max(salary)-min(salary) difference
from employees;

select manager_id, min(salary) --5
from employees --1
where manager_id is not null --2 
group by manager_id --3
having min(salary) > 6000 --4
order by 2 desc; --6





select count(*) total,
      sum(decode(to_char(hire_date, 'YYYY'), '2002', 1)) "2002"
from employees; --TOTAL 2002
                --  107    7


select count(*) total, 
      count(case to_char(hire_date, 'YYYY') when '2002' then 1 end)
"2002"
from employees; --TOTAL 2002
                --  107    7


select count(*) total,
count(decode(to_char(hire_date, 'YYYY'), '2002', 1)) "2002",
count(decode(to_char(hire_date, 'YYYY'), '2003', 1)) "2003",
count(decode(to_char(hire_date, 'YYYY'), '2004', 1)) "2004",
count(decode(to_char(hire_date, 'YYYY'), '2005', 1)) "2005"
from employees; 


select job_id,
       sum(decode(department_id, 20, salary)) "Dept 20",
       sum(decode(department_id, 50, salary)) "Dept 50",
       sum(decode(department_id, 80, salary)) "Dept 80",
       sum(decode(department_id, 90, salary)) "Dept 90",
       sum(salary) "Total"
from employees
grou pby job_id;