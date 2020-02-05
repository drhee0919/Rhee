select phone_number
from employees;

SELECT
  REGEXP_REPLACE(phone_number,
                 '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})',
                 '(\1) \2-\3') "REGEXP_REPLACE"
  FROM employees
  ORDER BY "REGEXP_REPLACE"; -- 국번을 포함한 employees의 전화번호 출력 
  
SELECT country_name,
  REGEXP_REPLACE(country_name, '(.)', '\1 ') "REGEXP_REPLACE"
  FROM countries;  -- 
  
SELECT
  REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA',
                ',[^,]+,') "REGEXPR_SUBSTR"
  FROM DUAL; --Redwood Shores

SELECT REGEXP_COUNT('123123123123123', '(12)3', 1, 'i') REGEXP_COUNT
   FROM DUAL; -- 5
SELECT REGEXP_COUNT('123123153123123', '(12)3', 1, 'i') REGEXP_COUNT
   FROM DUAL; -- 4


SELECT
  REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA',
               '[^ ]+', 1, 6) "REGEXP_INSTR"
  FROM DUAL;



-------이상 문자함수 예시 끝 ----
-------이하 숫자함수 -----------

select round(1234.567, 2), round(1234.567, 0), round(1234.567, -2)
from dual; --1234.57 1235 1200

select trunc(1234.567, 2), trunc(1234.567), trunc(1234.567, -2)
from dual; -- 1234.56 1234 1200

select mod(100, 35), remainder(100, 35)
from dual; -- 30 -5

select ceil(34.56), floor(34.56), power(2, 10)
from dual; --35 34 1024


------이상 숫자함수 --------------------
------숫자함수 예제는 scott계정 ㄱㄱ -----



---그룹함수 예제 ---
Q. employees테이블의 department_id, salary컬럼..
부서별 급여의 평균을 평균의 내림차순으로 출력하도록 SQL 작성 
select department_id, avg(salary)
from employees
group by department_id
order by 2 desc;

Q. employees 테이블의 department_id, salary, manager_id 컬럼...
관리자가 있는 사원들을 관리자로 그룹핑해서 동일한 관리자로부터 관리를 받는 
피관리자 중 최소 급여가 6000미만인 사원의 관리자와 최소급여를 출력 하는 SQL 작성 
select  manager_id, min(salary)           ---5
from employees                              ----1
where manager_id is not null             -----2
group by manager_id                       ----3
having min(salary) < 6000                 ----4
order by 2 desc;                            ---6





#################set operator(집합 연산자)#####################
교집합
합집합
차집합
conn hr/oracle
desc employees
select count(*) from employees;  --현재 근무하는 사원들의 정보(107)

desc job_history
select count(*) from employees;--사원들이 과거에 근무 이력 정보(10)

Q> 사원들의 현재 근무정보와 과거 근무 정보를 모두 출력하는 SQL 작성
select employee_id, department_id, job_id
from employees
union all
select employee_id, department_id, job_id
from job_history; ---(117)

Q> 사원들의 현재 근무정보와 과거 근무 정보를 모두 출력하되
동일한 직무와 부서에서의 근무인 경우 한번만 출력하는  SQL 작성
select employee_id, department_id, job_id
from employees
union 
select employee_id, department_id, job_id
from job_history; ---()

Q> 사원들의 현재 직무를 과거에 동일한 직무를 수행했던 사원번호, 직무를 출력하는 SQL 작성
select employee_id, job_id 
from employees 
intersect 
select employee_id, job_id
from job_history;

Q> 사원들중에서 입사한 이후 한번도 부서나 직무를 변경한적이 없는 
사원번호를  출력하는 SQL 작성
select employee_id
from employees
minus 
select employee_id 
from job_history


--set연산자를 사용하는 select문에서는 set연산자와 함께 사용되는 select문중 마지막 select문에서만 선언 가능합니다.
select employee_id,   job_id
from employees
order by job_id desc
intersect
select employee_id,   job_id
from job_history;  --error

select employee_id, job_id
from employees
intersect 
select employee_id, job_id
from job_history
order by job_id desc;

Q> 전체 사원의 급여 평균과
     부서별 사원들의 급여 평균과
      부서와 직무별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오
      
select to_number(null), to_char(null),avg(salary) --select가 안맞는 부분은 임의의 null로 채워주기 
from employees
union all --중복된 열이 없으므로 연산 최소화 
select department_id, to_char(null), avg(salary)
from employees
group by department_id
union all
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

--또는 (rollup으로 간단하게 바꾸어보자)
select department_id, job_id, avg(salary)
from employees
group by rollup(department_id, job_id); --department_id job_id avg(salary)
--(규칙)--
select ~
from ~
group by rollup (A,B)
→ group by A,B
→ group by A
→ group by ()

select ~
from ~
group by rollup (A,B,C)
→ group by A,B,C
→ group by A,B
→ group by A
→ group by ()


-- 대상이 4개 일때 
Q> 전체 사원의 급여 평균과
     부서별 사원들의 급여 평균과
     직무별 사원들의 급여 평균과
      부서와 직무별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오

select to_number(null), to_char(null),avg(salary)
from employees
union all
select department_id, to_char(null), avg(salary)
from employees
group by department_id
union all
select to_number(null), job_id, avg(salary)
from employees
group by  job_id
union all
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

-- cube 로 대체 
select department_id, job_id, avg(salary)
from employees
group by cube(department_id, job_id);


Q. 전체 사원의 급여 평균과 
    부서별 사원들의 급여 평균과 
    관리자와 직무별 사원들의 급여 평균과 
    부서별 관리자별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL 작성 
select department_id, job_id, avg(salary)
from employees
group by grouping sets((department_id, manager_id, job_id), 
                       (department_id),
                       (department_id, manager_id), 
                       (department_id, job_id));